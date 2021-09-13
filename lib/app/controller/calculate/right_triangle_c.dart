import 'dart:ffi';

import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key_symbol.dart';

import 'package:calc_triangle/main.dart';
import 'dart:math';
import 'package:get/get.dart';

enum RightTriangle {
  aCathet,
  bCathet,
  cHypotenuse,
  aAngle,
  bAngle,
  empty,
}
late WelcomeController c = Get.find();

class RightTriangleController extends GetxController {
  var aCathet = startLengthValue.obs;
  var bCathet = startLengthValue.obs;
  var cHypotenuse = startLengthValue.obs;
  var aAngle = startAngleValue.obs;
  var bAngle = startAngleValue.obs;

  String aAngleOld = startAngleValue;
  String bAngleOld = startAngleValue;

  var activeParamMap = <int, RightTriangle>{}.obs;

  //начальное значение при запуске
  var isaCathet = false.obs;
  var isbCathet = false.obs;
  var iscHypotenuse = false.obs;
  var isaAngle = false.obs;
  var isbAngle = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isDeg = true.obs;

  static const startLengthValue = '0';
  static const startAngleValue = '0°';

  int numberDigitsAfterPoint = c.precisionResult.value;

  String aCathetS = "";
  String bCathetS = "";
  String bAngleS = "";
  String cHypotenuseS = "";
  String aAngleS = "";

  double aCathetD = 0;
  double bCathetD = 0;
  double cHypotenuseD = 0;
  double bAngleD = 0;
  double aAngleD = 0;

  void clickKey(KeySymbol keySymbol) {
    showMessage();

    printt.i('start_print');
    _printElements();

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
      showMessage();
      return;
    }

    if (ifMaxNumbeEnter()) {
      printt.i('return max value');
      showMessage();
      return;
    }

    // если две точки возврат
    if (isTwoDecimalPointRightTriangle(keySymbol)) {
      printt.v('isTwoDecimalPointRightTriangle');

      return;
    }
    if (isAngleOver90(keySymbol)) {
      printt.v('isAngleOver90');
      showSnack(TranslateHelper.messageAngleOver90);

      return;
    }

    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;
    printt.i('add key');

    if (isaCathet.value) {
      oldInput = aCathet.value;

      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      aCathet.value = sumInput;
    } else if (isbCathet.value) {
      oldInput = bCathet.value;

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);
      bCathet.value = sumInput;
    } else if (iscHypotenuse.value) {
      oldInput = cHypotenuse.value;

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);
      cHypotenuse.value = sumInput;
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

    showMessage();

    setActiveParam();

    return;

    calculate();
    initValue();
    printt.i('end_print');
    _printElements();
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
    String newInput = keySymbol.value;

    if (isaCathet.value) {
      if (AppUtilsString.isTwoDecimalPoint(aCathet.value + keySymbol.value)) {
        return true;
      }
    } else if (isbCathet.value) {
      if (AppUtilsString.isTwoDecimalPoint(bCathet.value + keySymbol.value)) {
        return true;
      }
    } else if (iscHypotenuse.value) {
      if (AppUtilsString.isTwoDecimalPoint(
          cHypotenuse.value + keySymbol.value)) {
        return true;
      }
    } else if (isaAngle.value) {
      if (AppUtilsString.isTwoDecimalPoint(aAngle.value + keySymbol.value)) {
        return true;
      }
    } else if (isbAngle.value) {
      if (AppUtilsString.isTwoDecimalPoint(bAngle.value + keySymbol.value)) {
        return true;
      }
    }
    return false;
  }

  void resetActiveParam() {
    activeParamMap.value = <int, RightTriangle>{
      1: RightTriangle.empty,
      2: RightTriangle.empty,
    };
    resetValue();
  }

  void resetActiveInput() {
//начальное значение при запуске
    isaCathet.value = true;
    isbCathet.value = false;
    iscHypotenuse.value = false;
    isaAngle.value = false;
    isbAngle.value = false;
  }

  void initValue() {
    printt.v('initValue');
    aCathetS = aCathet.value;
    bCathetS = bCathet.value;
    bAngleS = bAngle.value;
    cHypotenuseS = cHypotenuse.value;
    aAngleS = aAngle.value;

    try {
      aCathetD = double.parse(aCathetS);
      bCathetD = double.parse(bCathetS);
      cHypotenuseD = double.parse(cHypotenuseS);
      bAngleD = double.parse(AppUtilsString.removeLastCharacter(bAngleS));
      aAngleD = double.parse(AppUtilsString.removeLastCharacter(aAngleS));
    } catch (e) {
      printt.e('error to double');
      resetValue();
      resetActiveParam();
    }
  }

  void calculate() {
    RightTriangle activeParm2 = activeParamMap[2]!;
    bool conditionOne = false;
    bool conditionTwo = false;

    double calc;

    //find bAngle
    conditionOne = activeParm2 == RightTriangle.aAngle;
    if (conditionOne) {
      calc = 90 - aAngleD;
      bAngle.value =
          AppUtilsNumber.getFormatNumber(calc, numberDigitsAfterPoint) + "°";
    }
    //find aAngle
    conditionTwo = activeParm2 == RightTriangle.bAngle;
    if (conditionTwo) {
      calc = 90 - bAngleD;
      aAngle.value =
          AppUtilsNumber.getFormatNumber(calc, numberDigitsAfterPoint) + "°";
    }
    // знаем а угол и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value =
          AppUtilsNumber.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      bCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value =
          AppUtilsNumber.getFormatNumber(bCathetD, numberDigitsAfterPoint);
    }

    // знаем b угол и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.bAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value =
          AppUtilsNumber.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      bCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value =
          AppUtilsNumber.getFormatNumber(bCathetD, numberDigitsAfterPoint);
    }

    // знаем а угол и a катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.aCathet);
    if (conditionOne && conditionTwo) {
      bCathetD = aCathetD * tan(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value =
          AppUtilsNumber.getFormatNumber(bCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }
// знаем b угол и a катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.bAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.aCathet);
    if (conditionOne && conditionTwo) {
      bCathetD = aCathetD / tan(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value =
          AppUtilsNumber.getFormatNumber(bCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }

    // знаем b угол и b катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.bAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bCathet);
    if (conditionOne && conditionTwo) {
      aCathetD = bCathetD * tan(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value =
          AppUtilsNumber.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }

    // знаем а угол и b катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bCathet);
    if (conditionOne && conditionTwo) {
      aCathetD = bCathetD / tan(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value =
          AppUtilsNumber.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }

    //знаем а катет и в катет --
    conditionOne = activeParamMap.containsValue(RightTriangle.aCathet);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bCathet);
    if (conditionOne && conditionTwo) {
      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);

      bAngleD = acos(
          (pow(bCathetD, 2) + pow(cHypotenuseD, 2) - pow(aCathetD, 2)) /
              (2 * bCathetD * cHypotenuseD));
      bAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), numberDigitsAfterPoint) +
          "°";

      aAngleD = acos(
          (pow(aCathetD, 2) + pow(cHypotenuseD, 2) - pow(bCathetD, 2)) /
              (2 * aCathetD * cHypotenuseD));
      aAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), numberDigitsAfterPoint) +
          "°";
    }

    //знаем а катет и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.aCathet);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      // находим гипотенузу
      bCathetD = sqrt(pow(cHypotenuseD, 2) - pow(aCathetD, 2));
      bCathet.value =
          AppUtilsNumber.getFormatNumber(bCathetD, numberDigitsAfterPoint);

      bAngleD = asin(aCathetD / cHypotenuseD);
      bAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), numberDigitsAfterPoint) +
          "°";

      aAngleD = acos(aCathetD / cHypotenuseD);
      aAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), numberDigitsAfterPoint) +
          "°";
    }

    //знаем b катет и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.bCathet);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      aCathetD = sqrt(pow(cHypotenuseD, 2) - pow(bCathetD, 2));
      aCathet.value =
          AppUtilsNumber.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      bAngleD = acos(bCathetD / cHypotenuseD);
      bAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), numberDigitsAfterPoint) +
          "°";

      aAngleD = asin(bCathetD / cHypotenuseD);
      aAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), numberDigitsAfterPoint) +
          "°";
    }

// если мы в минутах то переводим углы
    convertDeg();

// проверка если цифры не числа
    if (AppUtilsNumber.isDoublesNanAndInfinity(
        [aCathetD, bCathetD, cHypotenuseD, bAngleD, aAngleD])) {
      printt.i('clear');
      resetValue();
      // _resetActiveParam();
    }
  }

  //что  бы не сбрасывать в методе
  RightTriangle paramLenght = RightTriangle.empty;
  void setActiveParam() {
    printt.v('setActiveParam');
    RightTriangle paramAll = RightTriangle.empty;

    if (isaCathet.value) {
      if (aCathet.value == startLengthValue) {
        resetActiveParam();
        return;
      }

      paramAll = RightTriangle.aCathet;
      paramLenght = RightTriangle.aCathet;
    } else if (isbCathet.value) {
      if (bCathet.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.bCathet;
      paramLenght = RightTriangle.bCathet;
    } else if (iscHypotenuse.value) {
      if (cHypotenuse.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.cHypotenuse;
      paramLenght = RightTriangle.cHypotenuse;
    } else if (isaAngle.value) {
      if (aAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.aAngle;
    } else if (isbAngle.value) {
      if (bAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.bAngle;
    }

    activeParamMap[3] = paramAll;

    if (activeParamMap[1] == activeParamMap[2] ||
        activeParamMap[2] != activeParamMap[3]) {
      activeParamMap[1] = activeParamMap[2]!;
      activeParamMap[2] = activeParamMap[3]!;
    }

// если активные углы то сбрасываем один выбор до последнй длины
    if (isActiveParamAngles()) {
      activeParamMap[1] = paramLenght;
    }
  }

  void showMessage() {
    initValue();

    printt.v('show message');
    // если есть пустой параметр
    if (activeParamMap[1] == RightTriangle.empty &&
        activeParamMap[2] == RightTriangle.empty) {
      showSnack(TranslateHelper.enterTwoParameters);
      return;
    }

    // если один из них пустой
    if (activeParamMap[1] == RightTriangle.empty ||
        activeParamMap[2] == RightTriangle.empty) {
      showSnack(TranslateHelper.enterOneParameters);
      return;
    }

//если гипотенуза меньше
    if (cHypotenuseD <= aCathetD || cHypotenuseD <= bCathetD) {
      showSnack(TranslateHelper.messageHypotenuseGreaterCathetus);

      return;
    }

//если угол больше 90
    if (90 <= aAngleD || 90 <= bAngleD) {
      showSnack(TranslateHelper.messageAngleOver90);

      return;
    }

    // endSnack();
    showSnack('OK');
  }

  bool isAngleOver90(KeySymbol keySymbol) {
    String newInput = keySymbol.value;
    double sum = 0;
    if (isaAngle.value) {
      sum = double.parse(
          AppUtilsString.removeLastCharacter(aAngle.value) + newInput);
      if (90 <= sum) return true;
    } else if (isbAngle.value) {
      sum = double.parse(
          AppUtilsString.removeLastCharacter(bAngle.value) + newInput);
      if (90 <= sum) return true;
    }
    return false;
  }

  bool isActiveParamAngles() {
    bool conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    bool conditionTwo = activeParamMap.containsValue(RightTriangle.bAngle);
    if (conditionOne && conditionTwo) {
      return true;
    }
    return false;
  }

  bool isMaxNumberAfterPoint(String value) {
    return AppUtilsString.isMoreAccuracy(
        value, ConstNumber.maxNumberAfterPoint);
  }

  bool isMaxNumberInput(String value) {
    double number = double.parse(value);
    if (number > ConstNumber.maxValueInput) {
      return true;
    }
    return false;
  }

  bool ifMaxNumbeEnter() {
    String value;
    if (isaCathet.value) {
      value = aCathet.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (isbCathet.value) {
      value = bCathet.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (iscHypotenuse.value) {
      value = cHypotenuse.value;
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

  void _printElements() {
    // printt.i(
    //     'aCathet ${aCathet.value} bCathet ${bCathet.value} cHypotenuse ${cHypotenuse.value} aAngle ${aAngle.value} bAngle ${bAngle.value}');
    printt.i(
        'print\n\nactiveParam  ${activeParamMap[1]} ${activeParamMap[2]}\naCathetS $aCathetS   bCathetS $bCathetS cHypotenuseS $cHypotenuseS aAngleS $aAngleS bAngleS $bAngleS\naCathetD $aCathetD   bCathetD $bCathetD cHypotenuseD $cHypotenuseD aAngleD $aAngleD bAngleD $bAngleD\nisaCathet ${isaCathet.value} isbCathet ${isbCathet.value} iscHypotenuse ${iscHypotenuse.value} isaAngle ${isaAngle.value} isbAngle ${isbAngle.value}');
  }

  void nextElement() {
    // переключение вперед между widgets backspace

    _isNext(true);
  }

  void restartActiveParamIfZeroValue() {
    if (activeParamMap[1] == RightTriangle.aCathet &&
        aCathet.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.aCathet &&
        aCathet.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }

    if (activeParamMap[1] == RightTriangle.bCathet &&
        bCathet.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.bCathet &&
        bCathet.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }

    if (activeParamMap[1] == RightTriangle.cHypotenuse &&
        cHypotenuse.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.cHypotenuse &&
        cHypotenuse.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }

    if (activeParamMap[1] == RightTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.aAngle &&
        aAngle.value == startAngleValue) {
      activeParamMap[2] = RightTriangle.empty;
    }
    if (activeParamMap[1] == RightTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.bAngle &&
        bAngle.value == startAngleValue) {
      activeParamMap[2] = RightTriangle.empty;
    }
  }

  void prevElement() {
    // переключение  между widgets

    _isNext(false);
  }

  void convertDeg() {
    initValue();
// если мы в минутах то переводим углы
    if (!isDeg.value) {
      aAngle.value = AppUtilsNumber.convertDegToDMS(
          aAngleD, AppUtils.getPrecisionResults());
      bAngle.value = AppUtilsNumber.convertDegToDMS(
          bAngleD, AppUtils.getPrecisionResults());
    } else {
      aAngle.value = AppUtilsNumber.convertDMStoDeg(
          aAngle.value, AppUtils.getPrecisionResults());
      bAngle.value = AppUtilsNumber.convertDMStoDeg(
          bAngle.value, AppUtils.getPrecisionResults());
    }
  }

  void longClickConvertDeg() {
    isDeg.value = !(isDeg.value);

    convertDeg();
  }

  void longBackspace() {
// взависимости от активного ввода
    if (isaCathet.value) {
      aCathet.value = startLengthValue;
    } else if (isbCathet.value) {
      bCathet.value = startLengthValue;
    } else if (iscHypotenuse.value) {
      cHypotenuse.value = startLengthValue;
    } else if (isaAngle.value) {
      aAngle.value = startAngleValue;
    } else if (isbAngle.value) {
      bAngle.value = startAngleValue;
    }
    setActiveParam();

    calculate();

    // if (aAngle.value == _startAngleValue || bAngle.value == _startAngleValue) {
    //   _resetValue();
    // }
    restartActiveParamIfZeroValue();
  }

  void backspace() {
    String oldInput;
    String newInput;

// взависимости от активного ввода
    if (isaCathet.value) {
      oldInput = aCathet.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      aCathet.value = newInput;
    } else if (isbCathet.value) {
      oldInput = bCathet.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      bCathet.value = newInput;
    } else if (iscHypotenuse.value) {
      oldInput = cHypotenuse.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      cHypotenuse.value = newInput;
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
    }

    initValue();
  }

  void clearAll() {
    //устанавливаем начальные значения
    resetValue();

    resetActiveInput();
    resetActiveParam();
    initValue();
  }

  void resetValue() {
    //устанавливаем начальные значения
    aCathet.value = startLengthValue;
    bCathet.value = startLengthValue;
    cHypotenuse.value = startLengthValue;
    aAngle.value = startAngleValue;
    bAngle.value = startAngleValue;

    aCathetD = bCathetD = cHypotenuseD = bAngleD = aAngleD = 0;
  }

  void _isNext(bool isNext) {
    if (isNext) {
      if (isaCathet.value) {
        isbCathet.value = true;
        isaCathet.value = false;
      } else if (isbCathet.value) {
        iscHypotenuse.value = true;
        isbCathet.value = false;
      } else if (iscHypotenuse.value) {
        isaAngle.value = true;
        iscHypotenuse.value = false;
      } else if (isaAngle.value) {
        isbAngle.value = true;
        isaAngle.value = false;
      } else if (isbAngle.value) {
        isaCathet.value = true;
        isbAngle.value = false;
      }
    } else {
      if (isaCathet.value) {
        isbAngle.value = true;
        isaCathet.value = false;
      } else if (isbAngle.value) {
        isaAngle.value = true;
        isbAngle.value = false;
      } else if (isaAngle.value) {
        iscHypotenuse.value = true;
        isaAngle.value = false;
      } else if (iscHypotenuse.value) {
        isbCathet.value = true;
        iscHypotenuse.value = false;
      } else if (isbCathet.value) {
        isaCathet.value = true;
        isbCathet.value = false;
      }
    }
  }

  @override
  void onInit() {
    showSnack(TranslateHelper.enterTwoParameters);

    clearAll();
    super.onInit();
  }
}
