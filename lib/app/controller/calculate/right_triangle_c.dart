import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
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

  var activeParamMap = <int, RightTriangle>{}.obs;

  //начальное значение при запуске
  var isaCathet = false.obs;
  var isbCathet = false.obs;
  var iscHypotenuse = false.obs;
  var isaAngle = false.obs;
  var isbAngle = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;

  static const startLengthValue = '0';
  static const startAngleValue = '0°';

  int numberDigitsAfterPoint = c.precisionResult.value;

  //сразу записываем

  // void _resetActiveParam() {
  //   activeParamMap.value = <int, RightTriangle>{
  //     1: RightTriangle.aCathet,
  //     2: RightTriangle.aCathet,
  //   };
  // }
  void _resetActiveParam() {
    activeParamMap.value = <int, RightTriangle>{
      1: RightTriangle.empty,
      2: RightTriangle.empty,
    };
  }

  void _resetActiveInput() {
//начальное значение при запуске
    isaCathet.value = true;
    isbCathet.value = false;
    iscHypotenuse.value = false;
    isaAngle.value = false;
    isbAngle.value = false;
  }

  void calculate() {
    RightTriangle activeParm2 = activeParamMap[2]!;
    bool conditionOne = false;
    bool conditionTwo = false;

    String aCathetS = aCathet.value;
    String bCathetS = bCathet.value;
    String bAngleS = bAngle.value;
    String cHypotenuseS = cHypotenuse.value;
    String aAngleS = aAngle.value;

    double aCathetD = double.parse(aCathetS);
    double bCathetD = double.parse(bCathetS);
    double cHypotenuseD = double.parse(cHypotenuseS);
    double bAngleD = double.parse(AppUtilsString.removeLastCharacter(bAngleS));
    double aAngleD = double.parse(AppUtilsString.removeLastCharacter(aAngleS));

    double calc;

    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bAngle);

    // проверка если последние введенные данные - углы
    checkIfActiveParamAngles(conditionOne, conditionTwo);

    //find bAngle

    conditionOne = activeParm2 == RightTriangle.aAngle;
    if (conditionOne) {
      calc = 90 - aAngleD;
      bAngle.value =
          AppUtilsString.getFormatNumber(calc, numberDigitsAfterPoint) + "°";
    }
    //find aAngle
    conditionTwo = activeParm2 == RightTriangle.bAngle;
    if (conditionTwo) {
      calc = 90 - bAngleD;
      aAngle.value =
          AppUtilsString.getFormatNumber(calc, numberDigitsAfterPoint) + "°";
    }
    // знаем а угол и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value =
          AppUtilsString.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      bCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value =
          AppUtilsString.getFormatNumber(bCathetD, numberDigitsAfterPoint);
    }

    // знаем b угол и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.bAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value =
          AppUtilsString.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      bCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value =
          AppUtilsString.getFormatNumber(bCathetD, numberDigitsAfterPoint);
    }

    // знаем а угол и a катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.aCathet);
    if (conditionOne && conditionTwo) {
      bCathetD = aCathetD * tan(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value =
          AppUtilsString.getFormatNumber(bCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsString.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }
// знаем b угол и a катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.bAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.aCathet);
    if (conditionOne && conditionTwo) {
      bCathetD = aCathetD / tan(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value =
          AppUtilsString.getFormatNumber(bCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsString.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }

    // знаем b угол и b катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.bAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bCathet);
    if (conditionOne && conditionTwo) {
      aCathetD = bCathetD * tan(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value =
          AppUtilsString.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsString.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }

    // знаем а угол и b катет--
    conditionOne = activeParamMap.containsValue(RightTriangle.aAngle);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bCathet);
    if (conditionOne && conditionTwo) {
      aCathetD = bCathetD / tan(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value =
          AppUtilsString.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsString.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);
    }

    //знаем а катет и в катет --
    conditionOne = activeParamMap.containsValue(RightTriangle.aCathet);
    conditionTwo = activeParamMap.containsValue(RightTriangle.bCathet);
    if (conditionOne && conditionTwo) {
      printt.v('//знаем а катет и в катет --');
      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsString.getFormatNumber(cHypotenuseD, numberDigitsAfterPoint);

      bAngleD = acos(
          (pow(bCathetD, 2) + pow(cHypotenuseD, 2) - pow(aCathetD, 2)) /
              (2 * bCathetD * cHypotenuseD));
      bAngle.value = AppUtilsString.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), numberDigitsAfterPoint) +
          "°";

      aAngleD = acos(
          (pow(aCathetD, 2) + pow(cHypotenuseD, 2) - pow(bCathetD, 2)) /
              (2 * aCathetD * cHypotenuseD));
      aAngle.value = AppUtilsString.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), numberDigitsAfterPoint) +
          "°";
    }

    //знаем а катет и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.aCathet);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      if (cHypotenuseD <= aCathetD) {
        showSnack(TranslateHelper.messageHypotenuseGreaterCathetus);
        return;
      }
      // находим гипотенузу
      bCathetD = sqrt(pow(cHypotenuseD, 2) - pow(aCathetD, 2));
      bCathet.value =
          AppUtilsString.getFormatNumber(bCathetD, numberDigitsAfterPoint);

      bAngleD = asin(aCathetD / cHypotenuseD);
      bAngle.value = AppUtilsString.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), numberDigitsAfterPoint) +
          "°";

      aAngleD = acos(aCathetD / cHypotenuseD);
      aAngle.value = AppUtilsString.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), numberDigitsAfterPoint) +
          "°";
    }

    //знаем b катет и гипотенузу--
    conditionOne = activeParamMap.containsValue(RightTriangle.bCathet);
    conditionTwo = activeParamMap.containsValue(RightTriangle.cHypotenuse);
    if (conditionOne && conditionTwo) {
      if (cHypotenuseD <= bCathetD) {
        showSnack(TranslateHelper.messageHypotenuseGreaterCathetus);
        return;
      } else {
        endSnack();
      }

      aCathetD = sqrt(pow(cHypotenuseD, 2) - pow(bCathetD, 2));
      aCathet.value =
          AppUtilsString.getFormatNumber(aCathetD, numberDigitsAfterPoint);

      bAngleD = acos(bCathetD / cHypotenuseD);
      bAngle.value = AppUtilsString.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), numberDigitsAfterPoint) +
          "°";

      aAngleD = asin(bCathetD / cHypotenuseD);
      aAngle.value = AppUtilsString.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), numberDigitsAfterPoint) +
          "°";
    }

    printt.i(
        'aCathetS $aCathetS bCathetS $bCathetS cHypotenuseS $cHypotenuseS aAngleS $aAngleS bAngleS $bAngleS');
    printt.i(
        'aCathetD $aCathetD bCathetD $bCathetD cHypotenuseD $cHypotenuseD aAngleD $aAngleD bAngleD $bAngleD');

// проверка если цифры не числа
    if (AppUtilsNumber.isDoublesNanAndInfinity(
        [aCathetD, bCathetD, cHypotenuseD, bAngleD, aAngleD])) {
      printt.i('clear');
      _resetValue();
      // _resetActiveParam();
    }
  }

  void checkIfActiveParamAngles(bool conditionOne, bool conditionTwo) {
    if (conditionOne && conditionTwo) {
      bCathet.value = startLengthValue;
      aCathet.value = startLengthValue;
      cHypotenuse.value = startLengthValue;
      showSnack(TranslateHelper.enterValueSides);
    } else {
      endSnack();
    }
  }

  void setActiveParam() {
    RightTriangle param = RightTriangle.aCathet;

    if (isaCathet.value) {
      param = RightTriangle.aCathet;
    } else if (isbCathet.value) {
      param = RightTriangle.bCathet;
    } else if (iscHypotenuse.value) {
      param = RightTriangle.cHypotenuse;
    } else if (isaAngle.value) {
      param = RightTriangle.aAngle;
    } else if (isbAngle.value) {
      param = RightTriangle.bAngle;
    }

    activeParamMap[3] = param;

    if (activeParamMap[1] == activeParamMap[2] ||
        activeParamMap[2] != activeParamMap[3]) {
      activeParamMap[1] = activeParamMap[2]!;
      activeParamMap[2] = activeParamMap[3]!;
    }

    // если активные параметры углы и ли параметры одинаковы показыва. snack
    if (activeParamMap[1] == activeParamMap[2]) {
      showSnack(TranslateHelper.enterTwoParameters);
    } else {
      endSnack();
    }

    printt.v('activeParamMap');
    printt.v(activeParamMap[1]);
    printt.v(activeParamMap[2]);
  }

  bool _isMaxNumberAfterPoint(String value) {
    return AppUtilsString.isMoreAccuracy(
        value, ConstNumber.maxNumberAfterPoint);
  }

  bool _isMaxNumberInput(String value) {
    double number = double.parse(value);
    if (number > ConstNumber.maxValueInput) {
      return true;
    }
    return false;
  }

  void checkMaxNumberAndNumberAfterPoint() {
    String value;

    if (isaCathet.value) {
      value = aCathet.value;
      if (_isMaxNumberInput(value) || _isMaxNumberAfterPoint(value)) {
        aCathet.value = AppUtilsString.removeLastCharacter(value);
      }
    } else if (isbCathet.value) {
      value = bCathet.value;
      if (_isMaxNumberInput(value) || _isMaxNumberAfterPoint(value)) {
        bCathet.value = AppUtilsString.removeLastCharacter(value);
      }
    } else if (iscHypotenuse.value) {
      value = cHypotenuse.value;
      if (_isMaxNumberInput(value) || _isMaxNumberAfterPoint(value)) {
        cHypotenuse.value = AppUtilsString.removeLastCharacter(value);
      }
    } else if (isaAngle.value) {
      value = AppUtilsString.removeLastCharacter(aAngle.value);
      if (_isMaxNumberInput(value) || _isMaxNumberAfterPoint(value)) {
        aAngle.value = AppUtilsString.removeLastCharacter(value) + "°";
      }
    } else if (isbAngle.value) {
      value = AppUtilsString.removeLastCharacter(bAngle.value);
      if (_isMaxNumberInput(value) || _isMaxNumberAfterPoint(value)) {
        bAngle.value = AppUtilsString.removeLastCharacter(value) + "°";
      }
    }
  }

  void addKey(KeySymbol keySymbol) {


    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;

    if (isaCathet.value) {
      oldInput = aCathet.value;

      // если две точки возврат
      if (AppUtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      aCathet.value = sumInput;
    } else if (isbCathet.value) {
      oldInput = bCathet.value;

      if (AppUtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);
      bCathet.value = sumInput;
    } else if (iscHypotenuse.value) {
      oldInput = cHypotenuse.value;

      if (AppUtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);
      cHypotenuse.value = sumInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      if (AppUtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      // удаляю знак угла
      oldInput = AppUtilsString.removeLastCharacter(oldInput);

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      // если начинается ввод с точки
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      if (isAngleLess90(sumInput, TranslateHelper.messageAngleLess90)) return;

      aAngle.value = sumInput + "°";
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

// если две точки возврат
      if (AppUtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

// удаляю знак угла
      oldInput = AppUtilsString.removeLastCharacter(oldInput);
      //удаляю начальное значение при вводе
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      if (isAngleLess90(sumInput, TranslateHelper.messageAngleLess90)) return;

      bAngle.value = sumInput + "°";
    }
    checkMaxNumberAndNumberAfterPoint();
    setActiveParam();
    calculate();
    _printElements();
  }

  bool isAngleLess90(String angle, String message) {
    var calc = double.parse(angle);
    if (calc >= 90) {
      showSnack(message);
      return true;
    } else {
      endSnack();

      return false;
    }

    //
    // if (calc >= 90) {
    //   if (!Get.isSnackbarOpen!) {
    //     Get.snackbar(
    //       "",
    //       "",
    //       messageText: Center(child: Text(message)),
    //       titleText: Container(),
    //       snackPosition: SnackPosition.BOTTOM,
    //       icon: const Icon(Icons.info),
    //       borderRadius: 20,
    //       duration: const Duration(seconds: 4),
    //       forwardAnimationCurve: Curves.easeOutBack,
    //     );
    //   }
    //   return true;
    // } else {
    //   return false;
    // }
  }

  void endSnack() {
    isActiveSnackBar.value = false;
  }

  void showSnack(String message) {
    isActiveSnackBar.value = true;
    messageSnackBar.value = message;

    // if (!Get.isSnackbarOpen!) {
    //   Get.snackbar(
    //     "",
    //     "",
    //     messageText: Center(child: Text(message)),
    //     titleText: Container(),
    //     snackPosition: SnackPosition.TOP,
    //     icon: const Icon(Icons.info),
    //     borderRadius: 20,
    //     duration: const Duration(seconds: 4),
    //     forwardAnimationCurve: Curves.easeOutBack,
    //   );
    // }
  }

  void _printElements() {
    // printt.i(
    //     'aCathet ${aCathet.value} bCathet ${bCathet.value} cHypotenuse ${cHypotenuse.value} aAngle ${aAngle.value} bAngle ${bAngle.value}');
    printt.i(
        'aCathet ${isaCathet.value} bCathet ${isbCathet.value} cHypotenuse ${iscHypotenuse.value} aAngle ${isaAngle.value} bAngle ${isbAngle.value}');
    printt.i("activeParam [1] ${activeParamMap[1]} [1] ${activeParamMap[2]}");
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
    _printElements();

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
    //обновляем измененные параметры

    // _resetActiveParam();
    setActiveParam();

    calculate();
        restartActiveParamIfZeroValue();
    // if (aAngle.value == _startAngleValue || bAngle.value == _startAngleValue) {
    //   _resetValue();
    // }
  }

  void clearAll() {
    //устанавливаем начальные значения
    _resetValue();

    _resetActiveInput();
    _resetActiveParam();
  }

  void _resetValue() {
    showSnack(TranslateHelper.enterTwoParameters);

    //устанавливаем начальные значения
    aCathet.value = startLengthValue;
    bCathet.value = startLengthValue;
    cHypotenuse.value = startLengthValue;
    aAngle.value = startAngleValue;
    bAngle.value = startAngleValue;
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

    _resetActiveParam();
    _resetActiveInput();
    super.onInit();
  }
}
