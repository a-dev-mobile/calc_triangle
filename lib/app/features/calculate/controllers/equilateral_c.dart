// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/numpad/key.dart';
import 'package:calc_triangle/app/shared_components/numpad/key_symbol.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/utils/app_convert.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/utils/app_utils_map.dart';
import 'package:calc_triangle/app/utils/logger.dart';
import 'package:calc_triangle/app/utils/validation_utils.dart';

import 'package:get/get.dart';

enum EquilateralTriangle {
  aSide,

  hHeight,

  empty,
}

class EquilateralTriangleController extends GetxController {
  static EquilateralTriangleController get to =>
      Get.find<EquilateralTriangleController>();

  static const startAngleValue = '0°';
  static const startLengthValue = '0';

  var activeParamMap = <int, EquilateralTriangle>{}.obs;

  var aSide = startLengthValue.obs;

  var hHeight = startLengthValue.obs;

  double hHeightD = 0.0;
  double aSideD = 0.0;

/////////////////////////////
  var area = "".obs;
  var perimeter = "".obs;
  var xSPoint = "".obs;
  var ySPoint = "".obs;
/////////////////////////////
  double areaD = 0.0;
  double perimeterD = 0.0;
  double xSPointD = 0.0;
  double ySPointD = 0.0;
/////////////////////////////

  var mA = "".obs;
  var mB = "".obs;
  var mC = "".obs;
  double mAd = 0.0;
  double mBd = 0.0;
  double mCd = 0.0;
/////////////////////////////

  var lA = "".obs;
  var lB = "".obs;
  var lC = "".obs;
  double lAd = 0.0;
  double lBd = 0.0;
  double lCd = 0.0;

  //// Radius of the inscribed circle
  var r = "".obs;
  var xr = "".obs;
  var yr = "".obs;
  double rd = 0.0;
  double xrd = 0.0;
  double yrd = 0.0;

  var R = "".obs;
  var xR = "".obs;
  var yR = "".obs;
  double Rd = 0.0;
  double xRd = 0.0;
  double yRd = 0.0;

/////////////////////////////

  var isDeg = true.obs;

  var isaSide = false.obs;
  var ishHeight = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isActiveImageInfo = false.obs;

  //что  бы не сбрасывать в методе
  var paramLastLenght = EquilateralTriangle.empty;

  late int precisionResult;

  String message = "";
  bool isNotFormula = false;

  @override
  void onInit() {
    clearAll();
    showMessage();
    super.onInit();
  }

  void clickKey(KeySymbol keySymbol) {
    precisionResult = GlobalServ.to.precisionResult.value;

    log.w('start click ${keySymbol.value}');
    printElements();

    if (keySymbol == Keys.next) {
      nextElement();

      return;
    }

    if (keySymbol == Keys.prev) {
      prevElement();

      return;
    }

    if (keySymbol == Keys.clearAll) {
      clearAll();
      showMessage();
      return;
    }

    if (keySymbol == Keys.backspace) {
      backspace();
      setActiveParam();

      initValue();
      calculate();
      showMessage();

      return;
    }

    if (ifMaxNumberEnter()) {
      showSnack(TranslateHelper.message_max_number_entered);
      return;
    }

    // если две точки возврат
    if (isTwoDecimalPointRightTriangle(keySymbol)) {
      log.e('isTwoDecimalPointRightTriangle');

      return;
    }

    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;
    log.v('start input');
    if (isaSide.value) {
      oldInput = aSide.value;

      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      aSide.value = sumInput;
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      hHeight.value = sumInput;
    }
    log.v('end input');

    setActiveParam();
    log.v('1 ${activeParamMap[1]}  click end active param');

    initValue();
    calculate();
    showMessage();

    printElements();
    log.w('end click ${keySymbol.value}');
  }

  void printElements() {
    log.v('''printElements
        ${activeParamMap[1]} ${activeParamMap[2]} ${activeParamMap[3]}

        $aSideD | ${aSide.value} aSide 
       
        $hHeightD | ${hHeight.value} Height
       
       ''');
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
    if (isaSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(aSide.value + keySymbol.value)) {
        return true;
      }
    } else if (ishHeight.value) {
      if (ValidationUtils.isTwoDecimalPoint(hHeight.value + keySymbol.value)) {
        return true;
      }
    }
    return false;
  }

  void resetActiveParams() {
    activeParamMap.value = <int, EquilateralTriangle>{
      1: EquilateralTriangle.empty,
    };
  }

  void resetActiveInput() {
//начальное значение при запуске
    isaSide.value = true;

    ishHeight.value = false;
  }

  void initValue() {
    log.w('start initValue');

    // if (isValueChange()) {
    try {
      if (activeParamMap.containsValue(EquilateralTriangle.aSide)) {
        aSideD = double.parse(aSide.value);
      }

      if (activeParamMap.containsValue(EquilateralTriangle.hHeight)) {
        hHeightD = double.parse(hHeight.value);
      }
    } catch (e) {
      log.e('initValue error to double');
      resetAllValue();
      resetActiveParams();
    }
    // }
  }

  void calcAreaKnowAside() {
    areaD = (sqrt(3)/4)*pow(aSideD,2);
    area.value = AppUtilsNumber.getFormatNumber(areaD, precisionResult);
  }
  void calcAreaKnowhHei() {
    areaD = (sqrt(3)/3)*pow(hHeightD,2);
    area.value = AppUtilsNumber.getFormatNumber(areaD, precisionResult);
  }
  
  void calcSubResultKnowAsideBsideCsideAangl() async {
    calcMedianKnowAsideBsideCside();
    calcBisectorKnowAsideBsideCside();
    //внут круг
    calcRIncenterKnowAsideBsideCside();
    //внеш круг
    calcRCircumCenterKnowAsideBsideCside();
    calcXSRCircumCenterKnowAside();
    calcYSrIncenter();
    //last
    calcXSrIncenterKnowAsideAanglBangl();
    calcYSRCircumCenterKnowRradAside();
  }

  void calcMedianKnowAsideBsideCside() {
    // mAd =
    //     0.5 * (sqrt(2 * pow(cSideD, 2) + 2 * pow(bSideD, 2) - pow(aSideD, 2)));
    // mBd =
    //     0.5 * (sqrt(2 * pow(cSideD, 2) + 2 * pow(aSideD, 2) - pow(bSideD, 2)));
    // mCd =
    //     0.5 * (sqrt(2 * pow(aSideD, 2) + 2 * pow(bSideD, 2) - pow(cSideD, 2)));

    // mA.value = AppUtilsNumber.getFormatNumber(mAd, precisionResult);
    // mB.value = AppUtilsNumber.getFormatNumber(mBd, precisionResult);
    // mC.value = AppUtilsNumber.getFormatNumber(mCd, precisionResult);
  }

  void calcBisectorKnowAsideBsideCside() {
    // lBd = (sqrt(aSideD *
    //         bSideD *
    //         (cSideD + bSideD + aSideD) *
    //         (aSideD + bSideD - cSideD))) /
    //     (aSideD + bSideD);
    // lCd = (sqrt(cSideD *
    //         aSideD *
    //         (cSideD + bSideD + aSideD) *
    //         (cSideD + aSideD - bSideD))) /
    //     (cSideD + aSideD);
    // lAd = (sqrt(cSideD *
    //         bSideD *
    //         (cSideD + bSideD + aSideD) *
    //         (cSideD + bSideD - aSideD))) /
    //     (cSideD + bSideD);
    // lA.value = AppUtilsNumber.getFormatNumber(lAd, precisionResult);
    // lB.value = AppUtilsNumber.getFormatNumber(lBd, precisionResult);
    // lC.value = AppUtilsNumber.getFormatNumber(lCd, precisionResult);
  }

  void calcRIncenterKnowAsideBsideCside() {
    // double m = 0;

    // m = (aSideD + bSideD + cSideD) / 2;

    // rd = sqrt(((m - aSideD) * (m - bSideD) * (m - cSideD)) / m);

    // r.value = AppUtilsNumber.getFormatNumber(rd, precisionResult);
  }

  void calcRCircumCenterKnowAsideBsideCside() {
    // // Rd = bSideD / 2 * (sin(AppConvert.toRadian(aAngleD)));
    // Rd = (aSideD * bSideD * cSideD) / (4 * areaD);
    // R.value = AppUtilsNumber.getFormatNumber(Rd, precisionResult);
  }

  void calcYSrIncenter() {
    yr.value = r.value;
  }

  void calcXSRCircumCenterKnowAside() {
    xRd = aSideD / 2;
    xR.value = AppUtilsNumber.getFormatNumber(xRd, precisionResult);
  }

  void calcXSrIncenterKnowAsideAanglBangl() {
    // xrd = (tan(AppConvert.toRadian(bAngleD / 2))) *
    //     aSideD /
    //     (tan(AppConvert.toRadian(aAngleD / 2)) +
    //         tan(AppConvert.toRadian(bAngleD / 2)));

    // xr.value = AppUtilsNumber.getFormatNumber(xrd, precisionResult);
  }

  void calcYSRCircumCenterKnowRradAside() {
    yRd = sqrt(pow(Rd, 2) - (pow(aSideD, 2) / 4));

    yR.value = AppUtilsNumber.getFormatNumber(yRd, precisionResult);
  }

  void calculate() {
    if (isOnlyOneParamEmpty()) return;
    log.i('start calculate');
    printElements();
    EquilateralTriangle param1;

    isNumberNaN();

    printElements();
    log.i('end calculate');
  }

  bool isNumberNaN() {
    if (ValidationUtils.isNumberNanAndInfinity(aSideD)) {
      aSide.value = startLengthValue;
      return true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
      return true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(areaD)) {
      area.value = startLengthValue;
      return true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(perimeterD)) {
      perimeter.value = startLengthValue;
      return true;
    }

    if (ValidationUtils.isNumberNanAndInfinity(xSPointD)) {
      xSPoint.value = startLengthValue;
      return true;
    }

    if (ValidationUtils.isNumberNanAndInfinity(ySPointD)) {
      ySPoint.value = startLengthValue;
      return true;
    }

    return false;
  }

  void moveEmptyValueToStartInParameters() {
    activeParamMap.addAll(AppUtilsMap.moveValue(
            oldMap: activeParamMap,
            moveValue: EquilateralTriangle.empty,
            isPositionStart: true)
        .cast<int, EquilateralTriangle>());
  }

  void moveValueToEndInParameters(var value) {
    activeParamMap.addAll(AppUtilsMap.moveValue(
            oldMap: activeParamMap, moveValue: value, isPositionStart: false)
        .cast<int, EquilateralTriangle>());
  }

// если значение при удалении равно 0 то обнуляем активный параметр
  bool isInputStartValue() {
    bool activeInput;
    String valueActiveInput;

    activeInput = isaSide.value;
    valueActiveInput = aSide.value;
    EquilateralTriangle oldValue;
    var newValue = EquilateralTriangle.empty;

    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = EquilateralTriangle.aSide;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, EquilateralTriangle>();

      return true;
    }

    activeInput = ishHeight.value;
    valueActiveInput = hHeight.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = EquilateralTriangle.hHeight;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, EquilateralTriangle>();

      return true;
    }

    return false;
  }

  void setActiveParam() {
    log.v(
        '1 ${activeParamMap[1]}  start active param');

    EquilateralTriangle paramActive = EquilateralTriangle.empty;

    if (isInputStartValue()) return;

    if (isaSide.value) {
      paramActive = EquilateralTriangle.aSide;
      paramLastLenght = EquilateralTriangle.aSide;
    } else if (ishHeight.value) {
      paramActive = EquilateralTriangle.hHeight;
      paramLastLenght = EquilateralTriangle.hHeight;
    }

    moveEmptyValueToStartInParameters();
    //если уже есть данный параметр переместить его наверх
    if (isAvailableOneParam(paramActive)) {
      moveValueToEndInParameters(paramActive);
      return;
    }

//если последний параметр похож на активный
    if (activeParamMap[1] == paramActive) return;

    if (activeParamMap[1] != EquilateralTriangle.empty) {
      activeParamMap[1] = paramActive;
    }
  }

  bool isAvailableOneParam(
    EquilateralTriangle param1,
  ) {
    if (activeParamMap.containsValue(param1)) {
      return true;
    }
    return false;
  }

  bool isAvailableTwoParams(
    EquilateralTriangle param1,
    EquilateralTriangle param2,
  ) {
    if (activeParamMap.containsValue(param1) &&
        activeParamMap.containsValue(param2)) {
      return true;
    }
    return false;
  }

  bool isAvailableThreeParams(
    EquilateralTriangle param1,
    EquilateralTriangle param2,
    EquilateralTriangle param3,
  ) {
    if (activeParamMap.containsValue(param1) &&
        activeParamMap.containsValue(param2) &&
        activeParamMap.containsValue(param3)) {
      return true;
    }
    return false;
  }

  void showMessage() {
    double result = 0.0;

    log.w('start showMessage');

    if (isNotFormula) {
      log.w('isNotFormula');
      showSnack(TranslateHelper.messageFormulaNotFound);
      isNotFormula = false;
      return;
    }

    if (isNumberNaN()) {
      log.w('isNumberNaN');
      showSnack(TranslateHelper.message_calc_error_chang_value);
      return;
    }
    endSnack();
    // showSnack('OK');
  }

  bool isLeatOneParamEmpty() {
    if (activeParamMap.containsValue(EquilateralTriangle.empty)) {
      return true;
    }
    return false;
  }

  bool isOnlyOneParamEmpty() {
    if (activeParamMap[1] == EquilateralTriangle.empty) {
      return true;
    }
    return false;
  }

  bool isMaxNumberAfterPoint(String value) {
    return ValidationUtils.isMoreAccuracy(
        value, ConstNumber.maxNumberAfterPoint);
  }

  bool isMaxNumberInput(String value) {
    double number = double.parse(value);
    if (number > ConstNumber.maxValueInput) {
      return true;
    }
    return false;
  }

  bool ifMaxNumberEnter() {
    String value;

    if (isaSide.value) {
      value = aSide.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (ishHeight.value) {
      value = hHeight.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    }
    return false;
  }

  void endSnack() {
    isActiveSnackBar.value = false;
  }

  void showSnack(String message) {
    isActiveSnackBar.value = true;
    messageSnackBar.value = message;
  }

  void nextElement() {
    // переключение вперед между widgets backspace

    _isNext(true);
  }

  void restartActiveParamIfZeroValue() {
    if (activeParamMap[1] == EquilateralTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[1] = EquilateralTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == EquilateralTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[1] = EquilateralTriangle.empty;
    }
  }

  void prevElement() {
    // переключение  между widgets

    _isNext(false);
  }

  void longBackspace() {
// взависимости от активного ввода
    if (isaSide.value) {
      aSide.value = startLengthValue;
    } else if (ishHeight.value) {
      hHeight.value = startLengthValue;
    }

    initValue();
    setActiveParam();
    log.v('1 ${activeParamMap[1]}  longBackspace active param  ');

    calculate();
    showMessage();
    restartActiveParamIfZeroValue();
  }

  void backspace() {
    String oldInput;
    String newInput;

// взависимости от активного ввода
    if (isaSide.value) {
      oldInput = aSide.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        aSideD = 0;

        newInput = startLengthValue;

        resetNotActiveValue();
      }
      aSide.value = newInput;
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        hHeightD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      hHeight.value = newInput;
    }
  }

  void clearAll() {
    //устанавливаем начальные значения
    log.v(' start clearAll');
    printElements();
    resetAllValue();

    resetActiveInput();
    resetActiveParams();

    printElements();
    log.v(' end clearAll');
  }

  void resetAllValue() {
    //устанавливаем начальные значения
    aSide.value = startLengthValue;

    hHeight.value = startLengthValue;

    area.value = startLengthValue;
    perimeter.value = startLengthValue;

    xSPoint.value = startLengthValue;
    ySPoint.value = startLengthValue;
    aSideD = 0;
    hHeightD = 0;

    areaD = 0;
    perimeterD = 0;

    ySPointD = 0;
    xSPointD = 0;

    mA.value = mB.value = mC.value = startLengthValue;
    mAd = mBd = mCd = 0.0;
/////////////////////////////
    lA.value = lB.value = lC.value = startLengthValue;
    lAd = lBd = lCd = 0.0;

    r.value = xr.value = yr.value = startLengthValue;
    rd = xrd = yrd = 0.0;

    R.value = xR.value = yR.value = startLengthValue;
    Rd = xRd = yRd = 0.0;

    isDeg.value = true;
  }

  void resetNotActiveValue() {
    areaD = 0;
    perimeterD = 0;
    area.value = startLengthValue;
    perimeter.value = startLengthValue;

    ySPointD = 0;
    xSPointD = 0;
    xSPoint.value = startLengthValue;
    ySPoint.value = startLengthValue;

    mA.value = mB.value = mC.value = startLengthValue;
    mAd = mBd = mCd = 0.0;
/////////////////////////////
    lA.value = lB.value = lC.value = startLengthValue;
    lAd = lBd = lCd = 0.0;

    r.value = xr.value = yr.value = startLengthValue;
    rd = xrd = yrd = 0.0;

    R.value = xR.value = yR.value = startLengthValue;
    Rd = xRd = yRd = 0.0;

    if (!isAvailableOneParam(EquilateralTriangle.aSide)) {
      aSide.value = startLengthValue;
      aSideD = 0;
    }

    if (!isAvailableOneParam(EquilateralTriangle.hHeight)) {
      hHeight.value = startLengthValue;
      hHeightD = 0;
    }
  }

  void _isNext(bool isNext) {
    if (isNext) {
      //   if (isaCathet.value) {
      //     isbCathet.value = true;
      //     isaCathet.value = false;
      //   } else if (isbCathet.value) {
      //     iscHypotenuse.value = true;
      //     isbCathet.value = false;
      //   } else if (iscHypotenuse.value) {
      //     isaAngle.value = true;
      //     iscHypotenuse.value = false;
      //   } else if (isaAngle.value) {
      //     isbAngle.value = true;
      //     isaAngle.value = false;
      //   } else if (isbAngle.value) {
      //     isaCathet.value = true;
      //     isbAngle.value = false;
      //   }
      // } else {
      //   if (isaCathet.value) {
      //     isbAngle.value = true;
      //     isaCathet.value = false;
      //   } else if (isbAngle.value) {
      //     isaAngle.value = true;
      //     isbAngle.value = false;
      //   } else if (isaAngle.value) {
      //     iscHypotenuse.value = true;
      //     isaAngle.value = false;
      //   } else if (iscHypotenuse.value) {
      //     isbCathet.value = true;
      //     iscHypotenuse.value = false;
      //   } else if (isbCathet.value) {
      //     isaCathet.value = true;
      //     isbCathet.value = false;
      //   }
      // }
      // }
    }
  }

  @override
  void onClose() {
    clearAll();
    super.onClose();
  }
}
