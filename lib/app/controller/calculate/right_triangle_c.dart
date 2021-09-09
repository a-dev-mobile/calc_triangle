import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key_symbol.dart';

import 'package:calc_triangle/app/utils/utils_string.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';

enum RightTriangle {
  aCathet,
  bCathet,
  cHypotenuse,
  aAngle,
  bAngle,
}

class RightTriangleController extends GetxController {
  var aCathet = _startLengthValue.obs;
  var bCathet = _startLengthValue.obs;
  var cHypotenuse = _startLengthValue.obs;
  var aAngle = _startAngleValue.obs;
  var bAngle = _startAngleValue.obs;

  static const _startLengthValue = '0';
  static const _startAngleValue = '0°';

  int numberDigitsAfterPoint = AppUtils.getPrecisionResults();

//начальное значение при запуске
  var isaCathet = true.obs;
  //сразу записываем
  var activeParam = <int, RightTriangle>{
    1: RightTriangle.aCathet,
    2: RightTriangle.aCathet,
  }.obs;

  var isbCathet = false.obs;
  var iscHypotenuse = false.obs;
  var isaAngle = false.obs;
  var isbAngle = false.obs;

  void calculate() {
    RightTriangle first = activeParam[1]!;
    RightTriangle second = activeParam[2]!;

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
    printt.i(
        'aCathetD $aCathetD bCathetD $bCathetD cHypotenuseD $cHypotenuseD aAngleD $aAngleD bAngleD $bAngleD');
    // if (first == second) return;
    double calc;

    if (second == RightTriangle.aAngle) {
      calc = 90 - aAngleD;
      bAngle.value =
          AppUtilsString.getFormatNumber(calc, numberDigitsAfterPoint) + "°";
    }

    if (second == RightTriangle.bAngle) {
      calc = 90 - bAngleD;
      aAngle.value =
          AppUtilsString.getFormatNumber(calc, numberDigitsAfterPoint) + "°";
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

    activeParam[3] = param;

    if (activeParam[1] == activeParam[2] || activeParam[2] != activeParam[3]) {
      activeParam[1] = activeParam[2]!;
      activeParam[2] = activeParam[3]!;
    }
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
      if (UtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      // при вводе удаляю стартовый символ
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);

      aCathet.value = sumInput;
    } else if (isbCathet.value) {
      oldInput = bCathet.value;

      if (UtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);
      bCathet.value = sumInput;
    } else if (iscHypotenuse.value) {
      oldInput = cHypotenuse.value;

      if (UtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);
      cHypotenuse.value = sumInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      if (UtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

      // удаляю знак угла
      oldInput = UtilsString.removeLastCharacter(oldInput);

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      // если начинается ввод с точки
      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);

      if (isAngleLess90(sumInput, 'Угол α должен быть меньше 90°')) return;

      aAngle.value = sumInput + "°";
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

// если две точки возврат
      if (UtilsString.isTwoDecimalPoint(oldInput + newInput)) return;

// удаляю знак угла
      oldInput = UtilsString.removeLastCharacter(oldInput);
      //удаляю начальное значение при вводе
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);

      if (isAngleLess90(sumInput, 'Угол β должен быть меньше 90°')) return;

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
      if (!Get.isSnackbarOpen!) {
        Get.snackbar(
          "",
          "",
          messageText: Center(child: Text(message)),
          titleText: Container(),
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.info),
          borderRadius: 20,
          duration: const Duration(seconds: 4),
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
      return true;
    } else {
      return false;
    }
  }

  void _printElements() {
    printt.i(
        'aCathet ${aCathet.value} bCathet ${bCathet.value} cHypotenuse ${cHypotenuse.value} aAngle ${aAngle.value} bAngle ${bAngle.value}');
    printt.i(
        'aCathet ${isaCathet.value} \nbCathet ${isbCathet.value} \ncHypotenuse ${iscHypotenuse.value} \naAngle ${isaAngle.value} \nbAngle ${isbAngle.value}');
    printt.i("activeParam [1] ${activeParam[1]} [1] ${activeParam[2]}");
  }

  void nextElement() {
    // переключение вперед между widgetsbackspace
    _isNext(true);
  }

  void prevElement() {
    // переключение  между widgets
    _isNext(false);
  }

  void longBackspace() {
// взависимости от активного ввода
    if (isaCathet.value) {
      aCathet.value = _startLengthValue;
    } else if (isbCathet.value) {
      bCathet.value = _startLengthValue;
    } else if (iscHypotenuse.value) {
      cHypotenuse.value = _startLengthValue;
    } else if (isaAngle.value) {
      aAngle.value = _startAngleValue;
    } else if (isbAngle.value) {
      bAngle.value = _startAngleValue;
    }
    calculate();
  }

  void backspace() {
    _printElements();

    String oldInput;
    String newInput;

// взависимости от активного ввода
    if (isaCathet.value) {
      oldInput = aCathet.value;
      newInput = UtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      aCathet.value = newInput;
    } else if (isbCathet.value) {
      oldInput = bCathet.value;
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      bCathet.value = newInput;
    } else if (iscHypotenuse.value) {
      oldInput = cHypotenuse.value;
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      cHypotenuse.value = newInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      if (UtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = UtilsString.removeLastCharacter(oldInput);
      }
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      aAngle.value = newInput + '°';
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

      if (UtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = UtilsString.removeLastCharacter(oldInput);
      }
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      bAngle.value = newInput + '°';
    }
    //обновляем измененные параметры
    setActiveParam();
    calculate();
  }

  void clear() {
    //устанавливаем начальные значения
    aCathet.value = _startLengthValue;
    bCathet.value = _startLengthValue;
    cHypotenuse.value = _startLengthValue;
    aAngle.value = _startAngleValue;
    bAngle.value = _startAngleValue;
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
}
