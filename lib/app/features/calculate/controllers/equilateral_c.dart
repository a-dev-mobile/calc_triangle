// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/constants/const_string.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/numpad/key.dart';
import 'package:calc_triangle/app/shared_components/numpad/key_symbol.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/utils/app_convert.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/utils/app_utils_map.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';
import 'package:calc_triangle/app/utils/logger.dart';
import 'package:calc_triangle/app/utils/validation_utils.dart';

import 'package:get/get.dart';

enum EquilateralTriangle { aSide, hHeight, empty }

class EquilateralTriangleController extends GetxController {
  static EquilateralTriangleController get to =>
      Get.find<EquilateralTriangleController>();

  static const String startAngleValue = '0°';
  static const String startLengthValue = '0';

  RxMap<int, EquilateralTriangle> activeParamMap =
      <int, EquilateralTriangle>{}.obs;

  RxString aSide = startLengthValue.obs;

  RxString hHeight = startLengthValue.obs;

  double hHeightD = 0.0;
  double aSideD = 0.0;

  /////////////////////////////
  RxString area = ''.obs;
  RxString perimeter = ''.obs;
  RxString xSPoint = ''.obs;
  RxString ySPoint = ''.obs;
  /////////////////////////////
  double areaD = 0.0;
  double perimeterD = 0.0;
  double xSPointD = 0.0;
  double ySPointD = 0.0;
  /////////////////////////////

  RxString mA = ''.obs;
  RxString mB = ''.obs;
  RxString mC = ''.obs;
  double mAd = 0.0;
  double mBd = 0.0;
  double mCd = 0.0;
  /////////////////////////////

  RxString lA = ''.obs;
  RxString lB = ''.obs;
  RxString lC = ''.obs;
  double lAd = 0.0;
  double lBd = 0.0;
  double lCd = 0.0;

  //// Radius of the inscribed circle
  RxString rInscribed = ''.obs;
  RxString xr = ''.obs;
  RxString yr = ''.obs;
  double rd = 0.0;
  double xrd = 0.0;
  double yrd = 0.0;

  RxString Rcircum = ''.obs;
  RxString xR = ''.obs;
  RxString yR = ''.obs;
  double Rd = 0.0;
  double xRd = 0.0;
  double yRd = 0.0;

  /////////////////////////////

  RxBool isDeg = true.obs;

  RxBool isaSide = false.obs;
  RxBool ishHeight = false.obs;

  RxBool isActiveSnackBar = false.obs;
  RxString messageSnackBar = ''.obs;
  RxBool isActiveImageInfo = false.obs;

  //что  бы не сбрасывать в методе
  EquilateralTriangle paramLastLenght = EquilateralTriangle.empty;

  late int precisionResult;

  String message = '';
  bool isNotFormula = false;

  void clickKey(KeySymbol keySymbol) {
    precisionResult = GlobalServ.to.precisionResult.value;

    log.w('start click ${keySymbol.value}');
    printElements();

    if (keySymbol == Keys.next) {
      nextElement();
      showMessage();
      return;
    }

    if (keySymbol == Keys.prev) {
      prevElement();
      showMessage();
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
        ${activeParamMap[1]} 

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
    areaD = (sqrt(3) / 4) * pow(aSideD, 2);
    area.value = AppUtilsNumber.getFormatNumber(areaD, precisionResult);
  }

  void calcAreaKnowHhei() {
    areaD = (sqrt(3) / 3) * pow(hHeightD, 2);
    area.value = AppUtilsNumber.getFormatNumber(areaD, precisionResult);
  }

  void calcAsideKnowHhei() {
    aSideD = ((2 * sqrt(3)) / 3) * hHeightD;
    aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcHheiKnowAside() {
    hHeightD = (aSideD * sqrt(3)) / 2;
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcPerimKnowAside() {
    perimeterD = 3 * aSideD;
    perimeter.value = AppUtilsNumber.getFormatNumber(
      3 * aSideD,
      precisionResult,
    );
  }

  void calcMedianKnowAsideBsideCside() {
    mAd =
        0.5 * (sqrt(2 * pow(aSideD, 2) + 2 * pow(aSideD, 2) - pow(aSideD, 2)));
    mBd =
        0.5 * (sqrt(2 * pow(aSideD, 2) + 2 * pow(aSideD, 2) - pow(aSideD, 2)));
    mCd =
        0.5 * (sqrt(2 * pow(aSideD, 2) + 2 * pow(aSideD, 2) - pow(aSideD, 2)));

    mA.value = AppUtilsNumber.getFormatNumber(mAd, precisionResult);
    mB.value = AppUtilsNumber.getFormatNumber(mBd, precisionResult);
    mC.value = AppUtilsNumber.getFormatNumber(mCd, precisionResult);
  }

  void calcBisectorKnowAsideBsideCside() {
    lBd =
        (sqrt(
          aSideD *
              aSideD *
              (aSideD + aSideD + aSideD) *
              (aSideD + aSideD - aSideD),
        )) /
        (aSideD + aSideD);
    lCd =
        (sqrt(
          aSideD *
              aSideD *
              (aSideD + aSideD + aSideD) *
              (aSideD + aSideD - aSideD),
        )) /
        (aSideD + aSideD);
    lAd =
        (sqrt(
          aSideD *
              aSideD *
              (aSideD + aSideD + aSideD) *
              (aSideD + aSideD - aSideD),
        )) /
        (aSideD + aSideD);
    lA.value = AppUtilsNumber.getFormatNumber(lAd, precisionResult);
    lB.value = AppUtilsNumber.getFormatNumber(lBd, precisionResult);
    lC.value = AppUtilsNumber.getFormatNumber(lCd, precisionResult);
  }

  void calcRIncenterKnowAsideBsideCside() {
    double m = 0;

    m = (aSideD + aSideD + aSideD) / 2;

    rd = sqrt(((m - aSideD) * (m - aSideD) * (m - aSideD)) / m);

    rInscribed.value = AppUtilsNumber.getFormatNumber(rd, precisionResult);
  }

  void calcRCircumCenterKnowAsideBsideCside() {
    // Rd = bSideD / 2 * (sin(AppConvert.toRadian(aAngleD)));
    Rd = (aSideD * aSideD * aSideD) / (4 * areaD);
    Rcircum.value = AppUtilsNumber.getFormatNumber(Rd, precisionResult);
  }

  void calcYSrIncenter() {
    yr.value = rInscribed.value;
  }

  void calcXSRCircumCenterKnowAside() {
    xRd = aSideD / 2;
    xR.value = AppUtilsNumber.getFormatNumber(xRd, precisionResult);
  }

  void calcXSrIncenterKnowAsideAanglBangl() {
    xrd =
        (tan(AppConvert.toRadian(60 / 2))) *
        aSideD /
        (tan(AppConvert.toRadian(60 / 2)) + tan(AppConvert.toRadian(60 / 2)));

    xr.value = AppUtilsNumber.getFormatNumber(xrd, precisionResult);
  }

  void calcYSRCircumCenterKnowRradAside() {
    yRd = sqrt(pow(Rd, 2) - (pow(aSideD, 2) / 4));

    yR.value = AppUtilsNumber.getFormatNumber(yRd, precisionResult);
  }

  void calcXsPointKnowAside() {
    xSPointD = aSideD / 2;
    xSPoint.value = AppUtilsNumber.getFormatNumber(xSPointD, precisionResult);
  }

  void calcYsPointKnowhHei() {
    ySPointD = hHeightD / 3;
    ySPoint.value = AppUtilsNumber.getFormatNumber(ySPointD, precisionResult);
  }

  void calculate() {
    if (isOnlyOneParamEmpty()) return;
    log.i('start calculate');
    printElements();
    EquilateralTriangle param1;

    // ==========================================
    //hHeight
    // ==========================================
    param1 = EquilateralTriangle.hHeight;

    if (isAvailableOneParam(param1)) {
      calcAsideKnowHhei();
      calcAreaKnowHhei();
      calcPerimKnowAside();
      calcYsPointKnowhHei();

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
      calcXsPointKnowAside();
    }
    // ==========================================
    //aSide
    // ==========================================
    param1 = EquilateralTriangle.aSide;

    if (isAvailableOneParam(param1)) {
      calcHheiKnowAside();
      calcAreaKnowHhei();
      calcPerimKnowAside();
      calcYsPointKnowhHei();
      calcXsPointKnowAside();
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

    isNumberNaN();

    printElements();
    log.i('end calculate');
  }

  bool isNumberNaN() {
    bool isNan = false;
    if (ValidationUtils.isNumberNanAndInfinity(aSideD)) {
      aSide.value = startLengthValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
      isNan = true;
    }

    return isNan;
  }

  void moveEmptyValueToStartInParameters() {
    activeParamMap.addAll(
      AppUtilsMap.moveValue(
        oldMap: activeParamMap,
        moveValue: EquilateralTriangle.empty,
        isPositionStart: true,
      ).cast<int, EquilateralTriangle>(),
    );
  }

  void moveValueToEndInParameters(var value) {
    activeParamMap.addAll(
      AppUtilsMap.moveValue(
        oldMap: activeParamMap,
        moveValue: value,
        isPositionStart: false,
      ).cast<int, EquilateralTriangle>(),
    );
  }

  // если значение при удалении равно 0 то обнуляем активный параметр
  bool isInputStartValue() {
    bool activeInput;
    String valueActiveInput;

    activeInput = isaSide.value;
    valueActiveInput = aSide.value;
    EquilateralTriangle oldValue;
    EquilateralTriangle newValue = EquilateralTriangle.empty;

    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = EquilateralTriangle.aSide;

      activeParamMap.value =
          AppUtilsMap.updateValues(
            oldMap: activeParamMap,
            oldValue: oldValue,
            newValue: newValue,
          ).cast<int, EquilateralTriangle>();

      return true;
    }

    activeInput = ishHeight.value;
    valueActiveInput = hHeight.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = EquilateralTriangle.hHeight;

      activeParamMap.value =
          AppUtilsMap.updateValues(
            oldMap: activeParamMap,
            oldValue: oldValue,
            newValue: newValue,
          ).cast<int, EquilateralTriangle>();

      return true;
    }

    return false;
  }

  void setActiveParam() {
    log.v('1 ${activeParamMap[1]}  start active param');

    EquilateralTriangle paramActive = EquilateralTriangle.empty;

    if (isInputStartValue()) return;

    if (isaSide.value) {
      paramActive = EquilateralTriangle.aSide;
    } else if (ishHeight.value) {
      paramActive = EquilateralTriangle.hHeight;
    }

    moveEmptyValueToStartInParameters();
    //если уже есть данный параметр переместить его наверх
    if (isAvailableOneParam(paramActive)) {
      moveValueToEndInParameters(paramActive);
      return;
    }
    // //если последний параметр похож на активный
    if (activeParamMap[1] == paramActive) return;

    activeParamMap[1] = paramActive;

    //     if (activeParamMap[1] != EquilateralTriangle.empty) {
    //       activeParamMap[1] = paramActive;
    //     }
  }

  bool isAvailableOneParam(EquilateralTriangle param1) {
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
    log.w('start showMessage');

    if (isNotFormula) {
      log.w('isNotFormula');
      showSnack(TranslateHelper.messageFormulaNotFound);
      isNotFormula = false;
      return;
    }

    // если есть пустой параметр
    if (isOnlyOneParamEmpty()) {
      showSnack(TranslateHelper.enterOneParameters);
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
      value,
      ConstNumber.maxNumberAfterPoint,
    );
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
    if (isaSide.value) {
      ishHeight.value = true;
      isaSide.value = false;
    } else if (ishHeight.value) {
      isaSide.value = true;
      ishHeight.value = false;
    }
  }

  void saveValues() {
    try {
      Map<String, dynamic> values = <String, dynamic>{
        'aSide': aSide.value,
        'hHeight': hHeight.value,
        'activeASide': isaSide.value,
        'activeHHeight': ishHeight.value,
        'isActiveImageInfo': isActiveImageInfo.value,
        'activeParamMap': activeParamMap.map(
          (int key, EquilateralTriangle value) =>
              MapEntry(key.toString(), value.index),
        ),
      };
      LocalStorage().setItemString(
        ConstString.keyEquilateralTriangleValues,
        json.encode(values),
      );
      log.i('Saved equilateral triangle values and active parameters');
    } catch (e) {
      log.e('Error saving equilateral triangle values: $e');
    }
  }

  void restoreValues() async {
    try {
      Map<String, dynamic> values = await LocalStorage().getJsonMap(
        ConstString.keyEquilateralTriangleValues,
      );

      // Only restore if values exist
      if (values.isNotEmpty) {
        // Restore input values
        aSide.value = values['aSide'] ?? startLengthValue;
        hHeight.value = values['hHeight'] ?? startLengthValue;

        // Restore active state
        isaSide.value = values['activeASide'] ?? false;
        ishHeight.value = values['activeHHeight'] ?? false;
        isActiveImageInfo.value = values['isActiveImageInfo'] ?? false;

        // Restore active parameter map
        if (values.containsKey('activeParamMap')) {
          try {
            Map<String, dynamic> savedMap = Map<String, dynamic>.from(
              values['activeParamMap'],
            );
            activeParamMap.clear();
            savedMap.forEach((String key, value) {
              int keyInt = int.parse(key);
              int valueInt = value is int ? value : int.parse(value.toString());
              if (valueInt < EquilateralTriangle.values.length) {
                activeParamMap[keyInt] = EquilateralTriangle.values[valueInt];
              }
            });
          } catch (e) {
            log.e('Error restoring active parameters: $e');
            // Fall back to default parameter setup
            resetActiveParams();
          }
        }

        // Initialize values and recalculate
        initValue();
        calculate();
        log.i('Restored equilateral triangle values and active parameters');
      }
    } catch (e) {
      log.e('Error in restoreValues: $e');
      resetAllValue();
    }
  }

  // Modify onInit and onClose methods
  @override
  void onInit() {
    clearAll();
    restoreValues(); // Add this line
    showMessage();
    super.onInit();
  }

  @override
  void onClose() {
    saveValues(); // Add this line
    super.onClose();
  }
}
