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

enum IsoscelesTriangle {
  aSide,
  bSide,
  aAngle,
  bAngle,
  hHeight,

  empty,
}

class IsoscelesTriangleController extends GetxController {
  static IsoscelesTriangleController get to =>
      Get.find<IsoscelesTriangleController>();

  static const startAngleValue = '0°';
  static const startLengthValue = '0';

  var activeParamMap = <int, IsoscelesTriangle>{}.obs;

  var aSide = startLengthValue.obs;
  var bSide = startLengthValue.obs;

  var hHeight = startLengthValue.obs;
  var aAngle = startAngleValue.obs;
  var bAngle = startAngleValue.obs;

/////////////////////////////
  double aSideD = 0.0;
  double bSideD = 0.0;

  double hHeightD = 0.0;
  double aAngleD = 0.0;
  double bAngleD = 0.0;

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
  var rInscribed = "".obs;
  var xr = "".obs;
  var yr = "".obs;
  double rd = 0.0;
  double xrd = 0.0;
  double yrd = 0.0;

  var Rcircum = "".obs;
  var xR = "".obs;
  var yR = "".obs;
  double Rd = 0.0;
  double xRd = 0.0;
  double yRd = 0.0;

/////////////////////////////

  var isDeg = true.obs;

  var isaAngle = false.obs;
  var isbAngle = false.obs;

  var isaSide = false.obs;
  var isbSide = false.obs;

  var ishHeight = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isActiveImageInfo = false.obs;

  //что  бы не сбрасывать в методе
  var paramLastLenght = IsoscelesTriangle.empty;

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

    //если нажалти на конвертацию
    if (keySymbol == Keys.deg || keySymbol == Keys.degMinSec) {
      clickConvertDeg();
      return;
    }

    //если у нас углы в минутах при нажатие любой кнопки далее очищаем ввод
    if (isDeg.isFalse) {
      resetAllValue();
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
    } else if (isbSide.value) {
      oldInput = bSide.value;

      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      bSide.value = sumInput;
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      hHeight.value = sumInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      // удаляю знак угла
      oldInput = AppUtilsString.removeLastCharacter(oldInput);

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      // если начинается ввод с точки
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      aAngle.value = sumInput + "°";
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

      // удаляю знак угла
      oldInput = AppUtilsString.removeLastCharacter(oldInput);
      //удаляю начальное значение при вводе
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      bAngle.value = sumInput + "°";
    }

    log.v('end input');
    // setActiveParam();
    // showMessage();

    // if (isActiveOneParamEmpty()) return;

    setActiveParam();
    log.v(
        '1 ${activeParamMap[1]} 2 ${activeParamMap[2]} 3 ${activeParamMap[3]} click end active param');

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
        $bSideD | ${bSide.value} bSide 
       
        $hHeightD | ${hHeight.value} Height
        $aAngleD | ${aAngle.value} aAngle 
        $bAngleD | ${bAngle.value} bAngle
    
       ''');
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
    if (isaSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(aSide.value + keySymbol.value)) {
        return true;
      }
    } else if (isbSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(bSide.value + keySymbol.value)) {
        return true;
      }
    } else if (ishHeight.value) {
      if (ValidationUtils.isTwoDecimalPoint(hHeight.value + keySymbol.value)) {
        return true;
      }
    } else if (isaAngle.value) {
      if (ValidationUtils.isTwoDecimalPoint(aAngle.value + keySymbol.value)) {
        return true;
      }
    } else if (isbAngle.value) {
      if (ValidationUtils.isTwoDecimalPoint(bAngle.value + keySymbol.value)) {
        return true;
      }
    }
    return false;
  }

  void resetActiveParams() {
    activeParamMap.value = <int, IsoscelesTriangle>{
      1: IsoscelesTriangle.empty,
      2: IsoscelesTriangle.empty,
    };
  }

  void resetActiveInput() {
//начальное значение при запуске
    isaSide.value = true;
    isbSide.value = false;

    ishHeight.value = false;

    isaAngle.value = false;
    isbAngle.value = false;
  }

  void initValue() {
    log.w('start initValue');

    if (isDeg.isFalse) {
      convertDMSToDeg();
    }

    // if (isValueChange()) {
    try {
      if (activeParamMap.containsValue(IsoscelesTriangle.aSide)) {
        aSideD = double.parse(aSide.value);
      }
      if (activeParamMap.containsValue(IsoscelesTriangle.bSide)) {
        bSideD = double.parse(bSide.value);
      }

      if (activeParamMap.containsValue(IsoscelesTriangle.hHeight)) {
        hHeightD = double.parse(hHeight.value);
      }

      if (activeParamMap.containsValue(IsoscelesTriangle.aAngle)) {
        aAngleD =
            double.parse(AppUtilsString.removeLastCharacter(aAngle.value));
      }

      if (activeParamMap.containsValue(IsoscelesTriangle.bAngle)) {
        bAngleD =
            double.parse(AppUtilsString.removeLastCharacter(bAngle.value));
      }
    } catch (e) {
      log.e('initValue error to double');
      resetAllValue();
      resetActiveParams();
    }
    // }
  }

  void calcHheiKnowAsideBside() {
    hHeightD = sqrt(4 * pow(bSideD, 2) - pow(aSideD, 2)) / 2;
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowAsideBSideCside() {
    // bAngleD = AppConvert.toDegree(acos(
    //     (pow(aSideD, 2) + pow(bSideD, 2) - pow(cSideD, 2)) /
    //         (2 * aSideD * bSideD)));
    bAngle.value = AppUtilsNumber.getFormatNumber(bAngleD, precisionResult);
  }

  void calcYangKnowAsideBsideCside() {
    // yAngleD = AppConvert.toDegree(acos(
    //     (pow(bSideD, 2) + pow(cSideD, 2) - pow(aSideD, 2)) /
    //         (2 * cSideD * bSideD)));
    // yAngle.value = AppUtilsNumber.getFormatNumber(yAngleD, precisionResult);
  }

  void calcAangKnowAsideBSide() {
    aAngleD = AppConvert.toDegree(acos(
        (pow(aSideD, 2) + pow(bSideD, 2) - pow(bSideD, 2)) /
            (2 * aSideD * bSideD)));
    aAngle.value = AppUtilsNumber.getFormatNumber(aAngleD, precisionResult);
  }

  void calcCsideKnowAsideBSideBang() {
    // cSideD = sqrt(pow(aSideD, 2) +
    //     pow(bSideD, 2) -
    //     2 * aSideD * bSideD * cos(AppConvert.toRadian(bAngleD)));

    // cSide.value = AppUtilsNumber.getFormatNumber(cSideD, precisionResult);
  }

  void calcBsideKnowAsideCSideAang() {
    // bSideD = sqrt(pow(aSideD, 2) +
    //     pow(cSideD, 2) -
    //     2 * aSideD * cSideD * cos(AppConvert.toRadian(aAngleD)));

    // bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcAsideKnowBsideCSideYang() {
    // aSideD = sqrt(pow(bSideD, 2) +
    //     pow(cSideD, 2) -
    //     2 * bSideD * cSideD * cos(AppConvert.toRadian(yAngleD)));

    // aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcCsideKnowAsideYangBang() {
    // cSideD = (aSideD * sin(AppConvert.toRadian(bAngleD))) /
    //     sin(AppConvert.toRadian(yAngleD));
    // cSide.value = AppUtilsNumber.getFormatNumber(cSideD, precisionResult);
  }

  void calcAreaKnowAsideHhei() {
    areaD = 0.5 * aSideD * hHeightD;
    area.value = AppUtilsNumber.getFormatNumber(areaD, precisionResult);
  }

  void calcPerimKnowAsideBside() {
    perimeterD = aSideD + bSideD + bSideD;

    perimeter.value =
        AppUtilsNumber.getFormatNumber(perimeterD, precisionResult);
  }

  void calcXsPointKnowAsideBsideAang() {
    xSPointD = (aSideD + bSideD * cos(AppConvert.toRadian(aAngleD))) / 3;

    xSPoint.value = AppUtilsNumber.getFormatNumber(xSPointD, precisionResult);
  }

  void calcYsPointKnowBsideAang() {
    ySPointD = bSideD * sin(AppConvert.toRadian(aAngleD)) / 3;
    ySPoint.value = AppUtilsNumber.getFormatNumber(ySPointD, precisionResult);
  }

  void calcBangKnowAangl() {
    bAngleD = 180 - 2 * aAngleD;
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcBSideKnowBangHhei() {
    bSideD = hHeightD / sin(AppConvert.toRadian(bAngleD));
    bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcYangKnowAsideBsideAang() {
    // yAngleD = AppConvert.toDegree(
    //     asin(aSideD * sin(AppConvert.toRadian(aAngleD)) / bSideD));
    // yAngle.value =
    // AppUtilsNumber.getFormatNumber(yAngleD, precisionResult) + "°";
  }

  void calcYangKnowAsideCsideBang() {
    // yAngleD = AppConvert.toDegree(
    //     asin(aSideD * sin(AppConvert.toRadian(bAngleD)) / cSideD));
    // yAngle.value =
    //     AppUtilsNumber.getFormatNumber(yAngleD, precisionResult) + "°";
  }

  void calcBangKnowAsideCsideYang() {
    // bAngleD = AppConvert.toDegree(
    //     (asin(cSideD * sin(AppConvert.toRadian(yAngleD)) / aSideD)));
    // bAngle.value =
    //     AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAangKnowAsideBsideYang() {
    // aAngleD = AppConvert.toDegree(
    //     asin(bSideD * sin(AppConvert.toRadian(yAngleD)) / aSideD));
    // aAngle.value =
    //     AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcBangKnowCsideBsideAang() {
    // bAngleD = AppConvert.toDegree(
    //     asin(cSideD * sin(AppConvert.toRadian(aAngleD)) / bSideD));
    // bAngle.value =
    //     AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAangKnowCsideBsideBang() {
    // aAngleD = AppConvert.toDegree(
    //     asin(bSideD * sin(AppConvert.toRadian(bAngleD)) / cSideD));
    // aAngle.value =
    //     AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcCsideKnowBsideAangBang() {
    // cSideD = (bSideD *
    //     sin(AppConvert.toRadian(bAngleD)) /
    //     sin(AppConvert.toRadian(aAngleD)));
    // cSide.value = AppUtilsNumber.getFormatNumber(cSideD, precisionResult);
  }

  void calcAsideKnowBsideAangYang() {
    // aSideD = (bSideD *
    //     sin(AppConvert.toRadian(yAngleD)) /
    //     sin(AppConvert.toRadian(aAngleD)));
    // aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcAsideKnowCsideBangYang() {
    // aSideD = (cSideD *
    //     sin(AppConvert.toRadian(yAngleD)) /
    //     sin(AppConvert.toRadian(bAngleD)));
    // aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcCsideKnowHheiAang() {
    // cSideD = hHeightD / (sin(AppConvert.toRadian(aAngleD)));
    // cSide.value = AppUtilsNumber.getFormatNumber(cSideD, precisionResult);
  }

  void calcAanglKnowCsideHhei() {
    // aAngleD = AppConvert.toDegree(asin(hHeightD / cSideD));

    // aAngle.value =
    //     AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcSubResultKnowAsideBsideCsideAangl() async {
    // calcMedianKnowAsideBsideCside();
    // calcBisectorKnowAsideBsideCside();
    // //внут круг
    // calcRIncenterKnowAsideBsideCside();
    // //внеш круг
    // calcRCircumCenterKnowAsideBsideCside();
    // calcXSRCircumCenterKnowAside();
    // calcYSrIncenter();
    // //last
    // calcXSrIncenterKnowAsideAanglBangl();
    // calcYSRCircumCenterKnowRradAside();
  }

  void calcMedianKnowAsideBside() {
    mAd =
        0.5 * (sqrt(2 * pow(bSideD, 2) + 2 * pow(bSideD, 2) - pow(aSideD, 2)));
    mBd =
        0.5 * (sqrt(2 * pow(bSideD, 2) + 2 * pow(aSideD, 2) - pow(bSideD, 2)));
    mCd =
        0.5 * (sqrt(2 * pow(aSideD, 2) + 2 * pow(bSideD, 2) - pow(bSideD, 2)));

    mA.value = AppUtilsNumber.getFormatNumber(mAd, precisionResult);
    mB.value = AppUtilsNumber.getFormatNumber(mBd, precisionResult);
    mC.value = AppUtilsNumber.getFormatNumber(mCd, precisionResult);
  }

  void calcBisectorKnowAsideBside() {
    lBd = (sqrt(aSideD *
            bSideD *
            (bSideD + bSideD + aSideD) *
            (aSideD + bSideD - bSideD))) /
        (aSideD + bSideD);
    lCd = (sqrt(bSideD *
            aSideD *
            (bSideD + bSideD + aSideD) *
            (bSideD + aSideD - bSideD))) /
        (bSideD + aSideD);
    lAd = (sqrt(bSideD *
            bSideD *
            (bSideD + bSideD + aSideD) *
            (bSideD + bSideD - aSideD))) /
        (bSideD + bSideD);
    lA.value = AppUtilsNumber.getFormatNumber(lAd, precisionResult);
    lB.value = AppUtilsNumber.getFormatNumber(lBd, precisionResult);
    lC.value = AppUtilsNumber.getFormatNumber(lCd, precisionResult);
  }

  void calcRIncenterKnowAsideBside() {
    double m = 0;

    m = (aSideD + bSideD + bSideD) / 2;

    rd = sqrt(((m - aSideD) * (m - bSideD) * (m - bSideD)) / m);

    rInscribed.value = AppUtilsNumber.getFormatNumber(rd, precisionResult);
  }

  void calcRCircumCenterKnowAsideBside() {
    Rd = (aSideD * bSideD * bSideD) / (4 * areaD);
    Rcircum.value = AppUtilsNumber.getFormatNumber(Rd, precisionResult);
  }

  void calcYSrIncenter() {
    yr.value = rInscribed.value;
  }

  void calcXSRCircumCenterKnowAside() {
    xRd = aSideD / 2;
    xR.value = AppUtilsNumber.getFormatNumber(xRd, precisionResult);
  }

  void calcXSrKnowXRCircumCenter() {
    xrd = xRd;

    xr.value = AppUtilsNumber.getFormatNumber(xrd, precisionResult);
  }

  void calcYSRCircumCenterKnowRradAside() {
    yRd = sqrt(pow(Rd, 2) - (pow(aSideD, 2) / 4));

    yR.value = AppUtilsNumber.getFormatNumber(yRd, precisionResult);
  }

  void calculate() {
    if (isOnlyTwoParamEmpty()) return;
    log.i('start calculate');
    printElements();
    IsoscelesTriangle param1;
    IsoscelesTriangle param2;

    //* ==========================================
    // aSide bSide
    //* ==========================================
    param1 = IsoscelesTriangle.aSide;
    param2 = IsoscelesTriangle.bSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcHheiKnowAsideBside();
      calcAangKnowAsideBSide();
      calcBangKnowAangl();
      calcAreaKnowAsideHhei();
      calcPerimKnowAsideBside();

      calcXsPointKnowAsideBsideAang();
      calcYsPointKnowBsideAang();

      calcMedianKnowAsideBside();
      calcBisectorKnowAsideBside();
      //внут круг
      calcRIncenterKnowAsideBside();
      //внеш круг
      calcRCircumCenterKnowAsideBside();
      calcXSRCircumCenterKnowAside();
      calcYSrIncenter();
      //last
      calcXSrKnowXRCircumCenter();
      calcYSRCircumCenterKnowRradAside();
    }

// aSide aAngle
// aSide bAngle
// aSide hHeight
// bSide aAngle
// bSide bAngle
// bSide hHeight
// aAngle bAngle
// aAngle hHeight
// bAngle hHeight

    // ==========================================
    // aAngle bAngle == ok
    // ==========================================
    param1 = IsoscelesTriangle.aAngle;
    param2 = IsoscelesTriangle.bAngle;
    if (isAvailableTwoParams(param1, param2)) {}

    printElements();
    log.i('end calculate');
  }

  bool isNumberNaN() {
    bool isNan = false;
    if (ValidationUtils.isNumberNanAndInfinity(aSideD)) {
      aSide.value = startLengthValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bSideD)) {
      bSide.value = startLengthValue;
      isNan = true;
    }

    if (ValidationUtils.isNumberNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
      isNan = true;
    }

    if (ValidationUtils.isNumberNanAndInfinity(aAngleD)) {
      aAngle.value = startAngleValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bAngleD)) {
      bAngle.value = startAngleValue;
      isNan = true;
    }

    return isNan;
  }

  void moveEmptyValueToStartInParameters() {
    activeParamMap.addAll(AppUtilsMap.moveValue(
            oldMap: activeParamMap,
            moveValue: IsoscelesTriangle.empty,
            isPositionStart: true)
        .cast<int, IsoscelesTriangle>());
  }

  void moveValueToEndInParameters(var value) {
    activeParamMap.addAll(AppUtilsMap.moveValue(
            oldMap: activeParamMap, moveValue: value, isPositionStart: false)
        .cast<int, IsoscelesTriangle>());
  }

// если значение при удалении равно 0 то обнуляем активный параметр
  bool isInputStartValue() {
    bool activeInput;
    String valueActiveInput;

    activeInput = isaSide.value;
    valueActiveInput = aSide.value;
    IsoscelesTriangle oldValue;
    var newValue = IsoscelesTriangle.empty;

    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = IsoscelesTriangle.aSide;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, IsoscelesTriangle>();

      return true;
    }

    activeInput = isbSide.value;
    valueActiveInput = bSide.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = IsoscelesTriangle.bSide;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, IsoscelesTriangle>();

      return true;
    }

    activeInput = ishHeight.value;
    valueActiveInput = hHeight.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = IsoscelesTriangle.hHeight;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, IsoscelesTriangle>();

      return true;
    }

    activeInput = isaAngle.value;
    valueActiveInput = aAngle.value;
    if (activeInput && valueActiveInput == startAngleValue) {
      oldValue = IsoscelesTriangle.aAngle;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, IsoscelesTriangle>();

      return true;
    }

    activeInput = isbAngle.value;
    valueActiveInput = bAngle.value;
    if (activeInput && valueActiveInput == startAngleValue) {
      oldValue = IsoscelesTriangle.bAngle;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, IsoscelesTriangle>();

      return true;
    }

    return false;
  }

  void setActiveParam() {
    log.v(
        '1 ${activeParamMap[1]} 2 ${activeParamMap[2]} 3 ${activeParamMap[3]} start active param');

    IsoscelesTriangle paramActive = IsoscelesTriangle.empty;

    if (isInputStartValue()) return;

    if (isaSide.value) {
      paramActive = IsoscelesTriangle.aSide;
      paramLastLenght = IsoscelesTriangle.aSide;
    } else if (isbSide.value) {
      paramActive = IsoscelesTriangle.bSide;
      paramLastLenght = IsoscelesTriangle.bSide;
    } else if (ishHeight.value) {
      paramActive = IsoscelesTriangle.hHeight;
      paramLastLenght = IsoscelesTriangle.hHeight;
    } else if (isaAngle.value) {
      paramActive = IsoscelesTriangle.aAngle;
    } else if (isbAngle.value) {
      paramActive = IsoscelesTriangle.bAngle;
    }

    moveEmptyValueToStartInParameters();
    //если уже есть данный параметр переместить его наверх
    if (isAvailableOneParam(paramActive)) {
      moveValueToEndInParameters(paramActive);
      return;
    }

//если последний параметр похож на активный
    if (activeParamMap[2] == paramActive) return;

    if (activeParamMap[2] != IsoscelesTriangle.empty) {
      activeParamMap[1] = activeParamMap[2]!;
    }

    activeParamMap[2] = paramActive;
  }

  bool isAvailableOneParam(
    IsoscelesTriangle param1,
  ) {
    if (activeParamMap.containsValue(param1)) {
      return true;
    }
    return false;
  }

  bool isAvailableTwoParams(
    IsoscelesTriangle param1,
    IsoscelesTriangle param2,
  ) {
    if (activeParamMap.containsValue(param1) &&
        activeParamMap.containsValue(param2)) {
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
    // если активные углы то сбрасываем один выбор до последнй длины
    if (isActiveParamAngles()) {
      showSnack(TranslateHelper.messageEnterAnyLength);
      return;
    }
    // если есть пустой параметр
    if (isOnlyTwoParamEmpty()) {
      showSnack(TranslateHelper.enterTwoParameters);
      return;
    }
    if (isOnlyOneParamEmpty()) {
      showSnack(TranslateHelper.enterOneParameters);
      return;
    }

    if (isAvailableTwoParams(
        IsoscelesTriangle.aSide, IsoscelesTriangle.bSide)) {
      if (isbSide.value) {
        result = aSideD;
        if (!(bSideD > result)) {
          showSnack(
              '${TranslateHelper.side} b ${TranslateHelper.must_be} > a/2 = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (isaSide.value) {
        result = bSideD;
        if (!(aSideD < result)) {
          showSnack(
              'Base a ${TranslateHelper.must_be} < 2b = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }

    endSnack();
    // showSnack('OK');
  }

  bool isActiveParamAngles() {
    bool condition1 = activeParamMap.containsValue(IsoscelesTriangle.aAngle);
    bool condition2 = activeParamMap.containsValue(IsoscelesTriangle.bAngle);

    if (condition1 && condition2) {
      logger.e('isActiveThreeParamAngles');
      return true;
    }

    return false;
  }

  bool isLeatOneParamEmpty() {
    if (activeParamMap.containsValue(IsoscelesTriangle.empty)) {
      return true;
    }
    return false;
  }

  bool isOnlyOneParamEmpty() {
    if (activeParamMap[1] != IsoscelesTriangle.empty &&
            activeParamMap[2] == IsoscelesTriangle.empty ||
        activeParamMap[1] == IsoscelesTriangle.empty &&
            activeParamMap[2] != IsoscelesTriangle.empty) {
      return true;
    }
    return false;
  }

  bool isOnlyTwoParamEmpty() {
    if (activeParamMap[1] == IsoscelesTriangle.empty &&
        activeParamMap[2] == IsoscelesTriangle.empty) {
      return true;
    }
    return false;
  }

  bool isActiveTwoParamAngles() {
    bool condition1 = activeParamMap.containsValue(IsoscelesTriangle.aAngle);
    bool condition2 = activeParamMap.containsValue(IsoscelesTriangle.bAngle);

    if (condition1 && condition2) {
      logger.e('isActiveTwoParamAngles');
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
    } else if (isbSide.value) {
      value = bSide.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (ishHeight.value) {
      value = hHeight.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (isaAngle.value) {
      value = AppUtilsString.removeLastCharacter(aAngle.value);
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (isbAngle.value) {
      value = AppUtilsString.removeLastCharacter(bAngle.value);
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
    if (activeParamMap[1] == IsoscelesTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[1] = IsoscelesTriangle.empty;
    }

    if (activeParamMap[2] == IsoscelesTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[2] = IsoscelesTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == IsoscelesTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[1] = IsoscelesTriangle.empty;
    }

    if (activeParamMap[2] == IsoscelesTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[2] = IsoscelesTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == IsoscelesTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[1] = IsoscelesTriangle.empty;
    }

    if (activeParamMap[2] == IsoscelesTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[2] = IsoscelesTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == IsoscelesTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[1] = IsoscelesTriangle.empty;
    }

    if (activeParamMap[2] == IsoscelesTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[2] = IsoscelesTriangle.empty;
    }

//===============================================

    if (activeParamMap[1] == IsoscelesTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[1] = IsoscelesTriangle.empty;
    }

    if (activeParamMap[2] == IsoscelesTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[2] = IsoscelesTriangle.empty;
    }

//===============================================
  }

  void prevElement() {
    // переключение  между widgets

    _isNext(false);
  }

  void convertDMSToDeg() {
    aAngle.value = AppConvert.convertDMStoDeg(aAngle.value, precisionResult);
    bAngle.value = AppConvert.convertDMStoDeg(bAngle.value, precisionResult);
  }

  void convertDegToDMS() {
// если мы в минутах то переводим углы
    aAngle.value = AppConvert.convertDegToDMS(aAngleD, precisionResult);
    bAngle.value = AppConvert.convertDegToDMS(bAngleD, precisionResult);
  }

  void clickConvertDeg() {
    isDeg.value = !(isDeg.value);

    isDeg.value ? convertDMSToDeg() : convertDegToDMS();
  }

  void longBackspace() {
// взависимости от активного ввода
    if (isaSide.value) {
      aSide.value = startLengthValue;
    } else if (isbSide.value) {
      bSide.value = startLengthValue;
    } else if (ishHeight.value) {
      hHeight.value = startLengthValue;
    } else if (isaAngle.value) {
      aAngle.value = startAngleValue;
    } else if (isbAngle.value) {
      bAngle.value = startAngleValue;
    }

    initValue();
    setActiveParam();
    log.v(
        '1 ${activeParamMap[1]} 2 ${activeParamMap[2]} longBackspace active param  ');

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
    } else if (isbSide.value) {
      oldInput = bSide.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        bSideD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      bSide.value = newInput;
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        hHeightD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      hHeight.value = newInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        aAngleD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      aAngle.value = newInput + '°';
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      if (newInput.isEmpty) {
        bAngleD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      bAngle.value = newInput + '°';
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
    bSide.value = startLengthValue;

    hHeight.value = startLengthValue;

    aAngle.value = startAngleValue;
    bAngle.value = startAngleValue;

    area.value = startLengthValue;
    perimeter.value = startLengthValue;

    xSPoint.value = startLengthValue;
    ySPoint.value = startLengthValue;
    aSideD = 0;
    bSideD = 0;

    hHeightD = 0;

    aAngleD = 0;
    bAngleD = 0;

    areaD = 0;
    perimeterD = 0;

    ySPointD = 0;
    xSPointD = 0;

    mA.value = mB.value = mC.value = startLengthValue;
    mAd = mBd = mCd = 0.0;
/////////////////////////////
    lA.value = lB.value = lC.value = startLengthValue;
    lAd = lBd = lCd = 0.0;

    rInscribed.value = xr.value = yr.value = startLengthValue;
    rd = xrd = yrd = 0.0;

    Rcircum.value = xR.value = yR.value = startLengthValue;
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

    rInscribed.value = xr.value = yr.value = startLengthValue;
    rd = xrd = yrd = 0.0;

    Rcircum.value = xR.value = yR.value = startLengthValue;
    Rd = xRd = yRd = 0.0;

    if (!isAvailableOneParam(IsoscelesTriangle.aSide)) {
      aSide.value = startLengthValue;
      aSideD = 0;
    }
    if (!isAvailableOneParam(IsoscelesTriangle.bSide)) {
      bSide.value = startLengthValue;
      bSideD = 0;
    }

    if (!isAvailableOneParam(IsoscelesTriangle.hHeight)) {
      hHeight.value = startLengthValue;
      hHeightD = 0;
    }
    if (!isAvailableOneParam(IsoscelesTriangle.aAngle)) {
      aAngle.value = startAngleValue;
      aAngleD = 0;
    }
    if (!isAvailableOneParam(IsoscelesTriangle.bAngle)) {
      bAngle.value = startAngleValue;
      bAngleD = 0;
    }
  }

  void _isNext(bool isNext) {
    if (isNext) {
      if (isaSide.value) {
        isaAngle.value = true;
        isaSide.value = false;
      } else if (isaAngle.value) {
        isaAngle.value = false;
        ishHeight.value = true;
      } else if (ishHeight.value) {
        ishHeight.value = false;
        isbSide.value = true;
      } else if (isbSide.value) {
        isbSide.value = false;
        isbAngle.value = true;
      }else if (isbAngle.value) {
        isbAngle.value = false;
        isaSide.value = true;
      }

      } else {
        if (isaSide.value) {
        isbAngle.value = true;
        isaSide.value = false;
      } else if (isbAngle.value) {
        isbAngle.value = false;
        isbSide.value = true;
      } else if (isbSide.value) {
        ishHeight.value = true;
        isbSide.value = false;
      } else if (ishHeight.value) {
        ishHeight.value = false;
        isaAngle.value = true;
      } else if (isaAngle.value) {
        isaAngle.value = false;
        isaSide.value = true;
      }
    }
  }

  @override
  void onClose() {
    clearAll();
    super.onClose();
  }
}
