import 'dart:math';

import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/numpad/key.dart';
import 'package:calc_triangle/app/shared_components/numpad/key_symbol.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/utils/app_convert.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/utils/logger.dart';
import 'package:calc_triangle/app/utils/validation_utils.dart';

import 'package:get/get.dart';

enum ScaleneTriangle {
  aSide,
  bSide,
  cSide,
  hHeight,
  aAngle,
  bAngle,
  yAngle,
  empty,
}

class ScaleneTriangleController extends GetxController {
  static ScaleneTriangleController get to =>
      Get.find<ScaleneTriangleController>();

  static const startAngleValue = '0°';
  static const startLengthValue = '0';

  var activeParamMap = <int, ScaleneTriangle>{}.obs;

  var aSide = startLengthValue.obs;
  var bSide = startLengthValue.obs;
  var cSide = startLengthValue.obs;
  var hHeight = startLengthValue.obs;
  var aAngle = startAngleValue.obs;
  var bAngle = startAngleValue.obs;
  var yAngle = startAngleValue.obs;

  var area = "".obs;
  var perimeter = "".obs;
  var xSPoint = "".obs;
  var ySPoint = "".obs;

  double aSideD = 0.0;
  double bSideD = 0.0;
  double cSideD = 0.0;
  double hHeightD = 0.0;
  double aAngleD = 0.0;
  double bAngleD = 0.0;
  double yAngleD = 0.0;

  var isDeg = true.obs;

  var isaAngle = false.obs;
  var isbAngle = false.obs;
  var isyAngle = false.obs;
  var isaSide = false.obs;
  var isbSide = false.obs;
  var iscSide = false.obs;
  var ishHeight = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isActiveImageInfo = false.obs;

  //что  бы не сбрасывать в методе
  var paramLastLenght = ScaleneTriangle.empty;

  late int precisionResult;

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
      resetValue();
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
      log.e('return max');
      showSnack('max');
      return;
    }

    // если две точки возврат
    if (isTwoDecimalPointRightTriangle(keySymbol)) {
      log.e('isTwoDecimalPointRightTriangle');

      return;
    }
    if (isAngleOver180(keySymbol)) {
      log.e('isAngleOver180');
      showSnack(TranslateHelper.messageAngleOver180);
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
    } else if (iscSide.value) {
      oldInput = cSide.value;

      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      cSide.value = sumInput;
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
    } else if (isyAngle.value) {
      oldInput = yAngle.value;

      // удаляю знак угла
      oldInput = AppUtilsString.removeLastCharacter(oldInput);
      //удаляю начальное значение при вводе
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      yAngle.value = sumInput + "°";
    }

    log.v('end input');
    // setActiveParam();
    // showMessage();

    // if (isActiveOneParamEmpty()) return;

    setActiveParam();
    initValue();
    calculate();
    showMessage();

    printElements();
    log.w('end click ${keySymbol.value}');
  }

//
  void printElements() {
    log.v('''printElements
        ${activeParamMap[1]} ${activeParamMap[2]} ${activeParamMap[3]}

        $aSideD | ${aSide.value} aSide 
        $bSideD | ${bSide.value} bSide 
        $cSideD | ${cSide.value} cSide 
        $hHeightD | ${hHeight.value} Height
        $aAngleD | ${aAngle.value} aAngle 
        $bAngleD | ${bAngle.value} bAngle
        $yAngleD | ${yAngle.value} yAngle
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
    } else if (iscSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(cSide.value + keySymbol.value)) {
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
    } else if (isyAngle.value) {
      if (ValidationUtils.isTwoDecimalPoint(yAngle.value + keySymbol.value)) {
        return true;
      }
    }
    return false;
  }

  void resetActiveParam() {
    activeParamMap.value = <int, ScaleneTriangle>{
      1: ScaleneTriangle.empty,
      2: ScaleneTriangle.empty,
      3: ScaleneTriangle.empty,
    };

    resetValue();
  }

  void resetActiveInput() {
//начальное значение при запуске
    isaSide.value = true;
    isbSide.value = false;
    iscSide.value = false;
    ishHeight.value = false;

    isaAngle.value = false;
    isbAngle.value = false;
    isyAngle.value = false;
  }

  void initValue() {
    log.w('start initValue');

    if (isDeg.isFalse) {
      convertDMSToDeg();
    }

    // if (isValueChange()) {
    try {
      if (activeParamMap.containsValue(ScaleneTriangle.aSide)) {
        aSideD = double.parse(aSide.value);
      }
      if (activeParamMap.containsValue(ScaleneTriangle.bSide)) {
        bSideD = double.parse(bSide.value);
      }
      if (activeParamMap.containsValue(ScaleneTriangle.cSide)) {
        cSideD = double.parse(cSide.value);
      }

      if (activeParamMap.containsValue(ScaleneTriangle.hHeight)) {
        hHeightD = double.parse(hHeight.value);
      }

      if (activeParamMap.containsValue(ScaleneTriangle.aAngle)) {
        aAngleD =
            double.parse(AppUtilsString.removeLastCharacter(aAngle.value));
      }

      if (activeParamMap.containsValue(ScaleneTriangle.bAngle)) {
        bAngleD =
            double.parse(AppUtilsString.removeLastCharacter(bAngle.value));
      }

      if (activeParamMap.containsValue(ScaleneTriangle.yAngle)) {
        yAngleD =
            double.parse(AppUtilsString.removeLastCharacter(yAngle.value));
      }
    } catch (e) {
      log.e('initValue error to double');
      resetValue();
      resetActiveParam();
    }
    // }
  }

  void calcYangKnowAangBang() {
    yAngleD = 180 - aAngleD - bAngleD;

    yAngle.value =
        AppUtilsNumber.getFormatNumber(yAngleD, precisionResult) + "°";
  }

  void calcAangKnowYangBang() {
    aAngleD = 180 - yAngleD - bAngleD;

    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcBangKnowYangAang() {
    bAngleD = 180 - yAngleD - aAngleD;

    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcHheiKnowCsideAang() {
    hHeightD = cSideD * sin(AppConvert.toRadian(aAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcHheiKnowBsideBang() {
    hHeightD = bSideD * sin(AppConvert.toRadian(bAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowAsideBSideCside() {
    bAngleD = AppConvert.toDegree(acos(
        (pow(aSideD, 2) + pow(bSideD, 2) - pow(cSideD, 2)) /
            (2 * aSideD * bSideD)));
    bAngle.value = AppUtilsNumber.getFormatNumber(bAngleD, precisionResult);
  }

  void calcYangKnowAsideBSideCside() {
    yAngleD = AppConvert.toDegree(acos(
        (pow(bSideD, 2) + pow(cSideD, 2) - pow(aSideD, 2)) /
            (2 * cSideD * bSideD)));
    yAngle.value = AppUtilsNumber.getFormatNumber(yAngleD, precisionResult);
  }

  void calcAangKnowAsideBSideCside() {
    aAngleD = AppConvert.toDegree(acos(
        (pow(aSideD, 2) + pow(cSideD, 2) - pow(bSideD, 2)) /
            (2 * aSideD * cSideD)));
    aAngle.value = AppUtilsNumber.getFormatNumber(aAngleD, precisionResult);
  }

  void calcAreaKnowAsideHhei() {
    area.value = AppUtilsNumber.getFormatNumber(
        0.5 * aSideD * hHeightD, precisionResult);
  }

  void calcPerimKnowAsideBsideCside() {
    perimeter.value = AppUtilsNumber.getFormatNumber(
        aSideD + bSideD + cSideD, precisionResult);
  }

  void calcXsPointKnowAsideCsideAang() {
    xSPoint.value = AppUtilsNumber.getFormatNumber(
        (aSideD + cSideD * cos(AppConvert.toRadian(aAngleD))) / 3,
        precisionResult);
  }

  void calcYsPointKnowCsideAang() {
    ySPoint.value = AppUtilsNumber.getFormatNumber(
        (cSideD * sin(AppConvert.toRadian(aAngleD))) / 3, precisionResult);
  }

  void calculate() {
    log.i('start calculate');
    printElements();
    ScaleneTriangle param1;
    ScaleneTriangle param2;
    ScaleneTriangle param3;

    // ==========================================
    // aAngle bAngle == ok
    // ==========================================
    param1 = ScaleneTriangle.aAngle;
    param2 = ScaleneTriangle.bAngle;
    if (isAvailableTwoParams(param1, param2)) {
      calcYangKnowAangBang();
    }

    // ==========================================
    // yAngle bAngle == ok
    // ==========================================
    param1 = ScaleneTriangle.yAngle;
    param2 = ScaleneTriangle.bAngle;
    if (isAvailableTwoParams(param1, param2)) {
      calcAangKnowYangBang();
    }

    // ==========================================
    // yAngle bAngle == ok
    // ==========================================
    param1 = ScaleneTriangle.yAngle;
    param2 = ScaleneTriangle.aAngle;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangKnowYangAang();
    }

    // ==========================================
    //  //aSide bSide cSide ==
    // ==========================================
    param1 = ScaleneTriangle.aSide;
    param2 = ScaleneTriangle.bSide;
    param3 = ScaleneTriangle.cSide;
    if (isAvailableThreeParams(param1, param2, param3)) {
      calcBangKnowAsideBSideCside();
      calcAangKnowAsideBSideCside();
      calcYangKnowAsideBSideCside();
      calcPerimKnowAsideBsideCside();
      calcHheiKnowBsideBang();
      calcAreaKnowAsideHhei();
      calcXsPointKnowAsideCsideAang();
      calcYsPointKnowCsideAang();
    }

//aSide bSide hHeight
//aSide bSide aAngle
//aSide bSide bAngle
//aSide bSide yAngle
//aSide cSide hHeight
//aSide cSide aAngle
//aSide cSide bAngle
//aSide cSide yAngle
//aSide hHeight aAngle
//aSide hHeight bAngle
//aSide hHeight yAngle
//aSide aAngle bAngle
//aSide aAngle yAngle
//aSide bAngle yAngle
//bSide cSide hHeight
//bSide cSide aAngle
//bSide cSide bAngle
//bSide cSide yAngle
//bSide hHeight aAngle
//bSide hHeight bAngle
//bSide hHeight yAngle
//bSide aAngle bAngle
//bSide aAngle yAngle
//bSide bAngle yAngle
//cSide hHeight aAngle
//cSide hHeight bAngle
//cSide hHeight yAngle
//cSide aAngle bAngle
//cSide aAngle yAngle
//cSide bAngle yAngle
//hHeight aAngle bAngle
//hHeight aAngle yAngle
//hHeight bAngle yAngle
//aAngle bAngle yAngle

// проверка если цифры не числа
    checkIfNaN();
    printElements();
    log.i('end calculate');
  }

  void checkIfNaN() {
    if (ValidationUtils.isNumberNanAndInfinity(aSideD)) {
      aSide.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bSideD)) {
      bSide.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(cSideD)) {
      cSide.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
    }

    if (ValidationUtils.isNumberNanAndInfinity(aAngleD)) {
      aAngle.value = startAngleValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bAngleD)) {
      bAngle.value = startAngleValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(yAngleD)) {
      yAngle.value = startAngleValue;
    }
  }

  void setActiveParam() {
    log.v(
        'start active param ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]} ${activeParamMap[4]}');
    ScaleneTriangle paramActive = ScaleneTriangle.empty;

    if (isaSide.value) {
      if (aSide.value == startLengthValue) {
        resetActiveParam();
        return;
      }

      paramActive = ScaleneTriangle.aSide;
      paramLastLenght = ScaleneTriangle.aSide;
    } else if (isbSide.value) {
      if (bSide.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramActive = ScaleneTriangle.bSide;
      paramLastLenght = ScaleneTriangle.bSide;
    } else if (iscSide.value) {
      if (cSide.value == startLengthValue) {
        resetActiveParam();
        return;
      }

      paramActive = ScaleneTriangle.cSide;
      paramLastLenght = ScaleneTriangle.cSide;
    } else if (ishHeight.value) {
      if (hHeight.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramActive = ScaleneTriangle.hHeight;
      paramLastLenght = ScaleneTriangle.hHeight;
    } else if (isaAngle.value) {
      if (aAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramActive = ScaleneTriangle.aAngle;
    } else if (isbAngle.value) {
      if (bAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramActive = ScaleneTriangle.bAngle;
    } else if (isyAngle.value) {
      if (yAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramActive = ScaleneTriangle.yAngle;
    }

    activeParamMap[4] = paramActive;

// //если последний параметр похож на активный
//     if (activeParamMap[3] == activeParamMap[4]) return;

    if (activeParamMap[1] == activeParamMap[2] ||
        activeParamMap[2] == activeParamMap[3] ||
        activeParamMap[3] != activeParamMap[4]) {
      activeParamMap[1] = activeParamMap[2]!;
      activeParamMap[2] = activeParamMap[3]!;
      activeParamMap[3] = activeParamMap[4]!;
    }

    log.v(
        'end active param | ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]} ${activeParamMap[4]}');
  }

  bool isAvailableOneParam(
    ScaleneTriangle param1,
  ) {
    if (activeParamMap.containsValue(param1)) {
      return true;
    }
    return false;
  }

  bool isAvailableTwoParams(
    ScaleneTriangle param1,
    ScaleneTriangle param2,
  ) {
    if (activeParamMap.containsValue(param1) &&
        activeParamMap.containsValue(param2)) {
      return true;
    }
    return false;
  }

  bool isAvailableThreeParams(
    ScaleneTriangle param1,
    ScaleneTriangle param2,
    ScaleneTriangle param3,
  ) {
    if (activeParamMap.containsValue(param1) &&
        activeParamMap.containsValue(param2) &&
        activeParamMap.containsValue(param3)) {
      return true;
    }
    return false;
  }

  void showMessage() {
    // если активные углы то сбрасываем один выбор до последнй длины

    if (isActiveThreeParamAngles()) {
      showSnack(TranslateHelper.messageEnterAnyLength);
      return;
    }

    if (ifMaxNumberEnter()) {
      showSnack('maximum number');
      return;
    }

    endSnack();
    // showSnack('OK');
  }

  bool isAngleOver180(KeySymbol keySymbol) {
    String newInput = keySymbol.value;
    initValue();
    double sum = 0;
    if (isaAngle.value) {
      sum = double.parse(
          AppUtilsString.removeLastCharacter(aAngle.value) + newInput);
      if (180 <= sum) {
        return true;
      } else if (180 <= yAngleD + bAngleD) {
        return true;
      }
    } else if (isbAngle.value) {
      sum = double.parse(
          AppUtilsString.removeLastCharacter(bAngle.value) + newInput);
      if (180 <= sum) {
        return true;
      } else if (180 <= yAngleD + aAngleD) {
        return true;
      }
    } else if (isyAngle.value) {
      sum = double.parse(
          AppUtilsString.removeLastCharacter(yAngle.value) + newInput);
      if (180 <= sum) {
        return true;
      } else if (180 <= yAngleD + bAngleD) {
        return true;
      }
    }

    return false;
  }

  bool isActiveThreeParamAngles() {
    bool condition1 = activeParamMap.containsValue(ScaleneTriangle.aAngle);
    bool condition2 = activeParamMap.containsValue(ScaleneTriangle.bAngle);
    bool condition3 = activeParamMap.containsValue(ScaleneTriangle.yAngle);

    if (condition1 && condition2 && condition3) {
      logger.e('isActiveThreeParamAngles');
      return true;
    }

    return false;
  }

  bool isActiveTwoParamAngles() {
    bool condition1 = activeParamMap.containsValue(ScaleneTriangle.aAngle);
    bool condition2 = activeParamMap.containsValue(ScaleneTriangle.bAngle);
    bool condition3 = activeParamMap.containsValue(ScaleneTriangle.yAngle);

    if (condition1 && condition2) {
      logger.e('isActiveTwoParamAngles');
      return true;
    }

    if (condition1 && condition3) {
      logger.e('isActiveTwoParamAngles');
      return true;
    }

    if (condition2 && condition3) {
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
    } else if (iscSide.value) {
      value = cSide.value;
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
    } else if (isyAngle.value) {
      value = AppUtilsString.removeLastCharacter(yAngle.value);
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
    if (activeParamMap[1] == ScaleneTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }
    if (activeParamMap[3] == ScaleneTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == ScaleneTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }
    if (activeParamMap[3] == ScaleneTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }
//===============================================
    if (activeParamMap[1] == ScaleneTriangle.cSide &&
        cSide.value == startLengthValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.cSide &&
        cSide.value == startLengthValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }
    if (activeParamMap[3] == ScaleneTriangle.cSide &&
        cSide.value == startLengthValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == ScaleneTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }
    if (activeParamMap[3] == ScaleneTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }

//===============================================
    if (activeParamMap[1] == ScaleneTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }

    if (activeParamMap[3] == ScaleneTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }
//===============================================

    if (activeParamMap[1] == ScaleneTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }

    if (activeParamMap[3] == ScaleneTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }

//===============================================

    if (activeParamMap[1] == ScaleneTriangle.yAngle &&
        yAngle.value == startAngleValue) {
      activeParamMap[1] = ScaleneTriangle.empty;
    }

    if (activeParamMap[2] == ScaleneTriangle.yAngle &&
        yAngle.value == startAngleValue) {
      activeParamMap[2] = ScaleneTriangle.empty;
    }

    if (activeParamMap[3] == ScaleneTriangle.yAngle &&
        yAngle.value == startAngleValue) {
      activeParamMap[3] = ScaleneTriangle.empty;
    }
  }

  void prevElement() {
    // переключение  между widgets

    _isNext(false);
  }

  void convertDMSToDeg() {
    aAngle.value = AppConvert.convertDMStoDeg(aAngle.value, precisionResult);
    bAngle.value = AppConvert.convertDMStoDeg(bAngle.value, precisionResult);
    yAngle.value = AppConvert.convertDMStoDeg(yAngle.value, precisionResult);
  }

  void convertDegToDMS() {
// если мы в минутах то переводим углы
    aAngle.value = AppConvert.convertDegToDMS(aAngleD, precisionResult);
    bAngle.value = AppConvert.convertDegToDMS(bAngleD, precisionResult);
    yAngle.value = AppConvert.convertDegToDMS(bAngleD, precisionResult);
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
    } else if (iscSide.value) {
      cSide.value = startLengthValue;
    } else if (ishHeight.value) {
      hHeight.value = startLengthValue;
    } else if (isaAngle.value) {
      aAngle.value = startAngleValue;
    } else if (isbAngle.value) {
      bAngle.value = startAngleValue;
    } else if (isyAngle.value) {
      yAngle.value = startAngleValue;
    }

    initValue();
    setActiveParam();
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
        newInput = startLengthValue;
      }
      aSide.value = newInput;
    } else if (isbSide.value) {
      oldInput = bSide.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      bSide.value = newInput;
    } else if (iscSide.value) {
      oldInput = cSide.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      cSide.value = newInput;
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      hHeight.value = newInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      aAngle.value = newInput + '°';
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      bAngle.value = newInput + '°';
    } else if (isyAngle.value) {
      oldInput = yAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      yAngle.value = newInput + '°';
    }
  }

  void clearAll() {
    //устанавливаем начальные значения
    log.v(' start clearAll');
    printElements();
    resetValue();

    resetActiveInput();
    resetActiveParam();

    printElements();
    log.v(' end clearAll');
  }

  void resetValue() {
    //устанавливаем начальные значения
    aSide.value = startLengthValue;
    bSide.value = startLengthValue;
    cSide.value = startLengthValue;

    hHeight.value = startLengthValue;

    aAngle.value = startAngleValue;
    bAngle.value = startAngleValue;
    yAngle.value = startAngleValue;

    area.value = startLengthValue;
    perimeter.value = startLengthValue;

    xSPoint.value = startLengthValue;
    ySPoint.value = startLengthValue;
    aSideD = 0;
    bSideD = 0;
    cSideD = 0;
    hHeightD = 0;
    aAngleD = 0;
    bAngleD = 0;
    yAngleD = 0;

    isDeg.value = true;
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
}
