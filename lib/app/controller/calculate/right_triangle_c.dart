import 'package:calc_triangle/app/ui/widgets/numpad/key_symbol.dart';

import 'package:calc_triangle/app/utils/utils_string.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';

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

//начальное значение при запуске
  var isAcathet = true.obs;
  //сразу записываем
  var knownParam = <int, RightTriangle>{
    1: RightTriangle.aCathet,
  }.obs;

  var isBcathet = false.obs;
  var isChypotenuse = false.obs;
  var isAangle = false.obs;
  var isBangle = false.obs;

  void setknownParam(RightTriangle param) {
    printt.i("----knownParam----");
    printt.i("knownParam[1] ${knownParam[1]}");
    printt.i("knownParam[2] ${knownParam[2]}");
    printt.i("knownParam[3] ${knownParam[3]}");


    if (knownParam[1] == null) {
      knownParam[1] = param;
     
    }
    if (knownParam[2] == null) {
      knownParam[2] = param;
    
    }

    knownParam[3] = param;
    knownParam[1] = knownParam[2]!;
    knownParam[2] = knownParam[3]!;
    if (knownParam[2] == knownParam[1]) return;

  }

  void addKey(KeySymbol keySymbol) {
    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;

    if (isAcathet.value) {
      setknownParam(RightTriangle.aCathet);
      oldInput = aCathet.value;

      // если две точки возврат
      if (UtilsString.isTwoDecimal(oldInput + newInput)) return;

      // при вводе удаляю стартовый символ
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);

      aCathet.value = sumInput;
    } else if (isBcathet.value) {
      setknownParam(RightTriangle.bCathet);
      oldInput = bCathet.value;

      if (UtilsString.isTwoDecimal(oldInput + newInput)) return;

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);
      bCathet.value = sumInput;
    } else if (isChypotenuse.value) {
      setknownParam(RightTriangle.cHypotenuse);
      oldInput = cHypotenuse.value;

      if (UtilsString.isTwoDecimal(oldInput + newInput)) return;

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);
      cHypotenuse.value = sumInput;
    } else if (isAangle.value) {
      setknownParam(RightTriangle.aAngle);
      oldInput = aAngle.value;

      if (UtilsString.isTwoDecimal(oldInput + newInput)) return;

      // удаляю знак угла
      oldInput = UtilsString.removeLastCharacter(oldInput);

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      // если начинается ввод с точки
      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);

      if (isAngleLess90(sumInput, 'Угол α должен быть меньше 90°')) return;

      aAngle.value = sumInput + "°";
    } else if (isBangle.value) {
      setknownParam(RightTriangle.bAngle);
      oldInput = bAngle.value;

// если две точки возврат
      if (UtilsString.isTwoDecimal(oldInput + newInput)) return;

// удаляю знак угла
      oldInput = UtilsString.removeLastCharacter(oldInput);
      //удаляю начальное значение при вводе
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = UtilsString.addZeroIsFirstDecimal(sumInput);

      if (isAngleLess90(sumInput, 'Угол β должен быть меньше 90°')) return;

      bAngle.value = sumInput + "°";
    }

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
        'aCathet ${isAcathet.value} \nbCathet ${isBcathet.value} \ncHypotenuse ${isChypotenuse.value} \naAngle ${isAangle.value} \nbAngle ${isBangle.value}');
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
    if (isAcathet.value) {
      aCathet.value = _startLengthValue;
    } else if (isBcathet.value) {
      bCathet.value = _startLengthValue;
    } else if (isChypotenuse.value) {
      cHypotenuse.value = _startLengthValue;
    } else if (isAangle.value) {
      aAngle.value = _startAngleValue;
    } else if (isBangle.value) {
      bAngle.value = _startAngleValue;
    }
  }

  void backspace() {
    _printElements();

    String oldInput;
    String newInput;

// взависимости от активного ввода
    if (isAcathet.value) {
      oldInput = aCathet.value;
      newInput = UtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      aCathet.value = newInput;
    } else if (isBcathet.value) {
      oldInput = bCathet.value;
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      bCathet.value = newInput;
    } else if (isChypotenuse.value) {
      oldInput = cHypotenuse.value;
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      cHypotenuse.value = newInput;
    } else if (isAangle.value) {
      oldInput = aAngle.value;

      if (UtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = UtilsString.removeLastCharacter(oldInput);
      }
      newInput = UtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      aAngle.value = newInput + '°';
    } else if (isBangle.value) {
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
      if (isAcathet.value) {
        isBcathet.value = true;
        isAcathet.value = false;
      } else if (isBcathet.value) {
        isChypotenuse.value = true;
        isBcathet.value = false;
      } else if (isChypotenuse.value) {
        isAangle.value = true;
        isChypotenuse.value = false;
      } else if (isAangle.value) {
        isBangle.value = true;
        isAangle.value = false;
      } else if (isBangle.value) {
        isAcathet.value = true;
        isBangle.value = false;
      }
    } else {
      if (isAcathet.value) {
        isBangle.value = true;
        isAcathet.value = false;
      } else if (isBangle.value) {
        isAangle.value = true;
        isBangle.value = false;
      } else if (isAangle.value) {
        isChypotenuse.value = true;
        isAangle.value = false;
      } else if (isChypotenuse.value) {
        isBcathet.value = true;
        isChypotenuse.value = false;
      } else if (isBcathet.value) {
        isAcathet.value = true;
        isBcathet.value = false;
      }
    }
  }
}
