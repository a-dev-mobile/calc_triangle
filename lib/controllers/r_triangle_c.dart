// ignore_for_file: avoid_print

import 'package:calc_triangle/pages/right_triangle/right_triangle_p.dart';
import 'package:calc_triangle/utils/key_symbol.dart';
import 'package:calc_triangle/utils/string_u.dart';
import 'package:get/get.dart';

class RtriangleController extends GetxController {
  var selectedElement = RighTrianglePage.startElement.obs;

  var aCathet = _startLengthValue.obs;
  var bCathet = _startLengthValue.obs;
  var cHypotenuse = _startLengthValue.obs;
  var aAngle = _startAngleValue.obs;
  var bAngle = _startAngleValue.obs;

  static const _startLengthValue = '0';
  static const _startAngleValue = '0°';

//начальное значение при запуске
  var isAcathet = true.obs;
  var isBcathet = false.obs;
  var isChypotenuse = false.obs;
  var isAangle = false.obs;
  var isBangle = false.obs;

  void addKey(KeySymbol keySymbol) {
    _printElements();

    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;

    if (isAcathet.value) {
      oldInput = aCathet.value;
      // при вводе удаляю стартовый символ
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      aCathet.value = sumInput;
    } else if (isBcathet.value) {
      oldInput = bCathet.value;
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;
      bCathet.value = sumInput;
    } else if (isChypotenuse.value) {
      oldInput = cHypotenuse.value;
      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      cHypotenuse.value = sumInput;
    } else if (isAangle.value) {
      oldInput = aAngle.value;
// удаляю знак угла
      oldInput = StringUtils.removeLastCharacter(oldInput);

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput + '°';
      aAngle.value = sumInput;
    } else if (isBangle.value) {
      oldInput = bAngle.value;

      oldInput = StringUtils.removeLastCharacter(oldInput);

      oldInput == _startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput + '°';
      bAngle.value = sumInput;
    }
  }

  void _printElements() {
    print('aCathet ${aCathet.value}');
    print('bCathet ${bCathet.value}');
    print('cHypotenuse ${cHypotenuse.value}');
    print('aAngle ${aAngle.value}');
    print('bAngle ${bAngle.value}');
  }

  void nextElement() {
    // переключение вперед между widgets
    _isNext(true);
  }

  void prevElement() {
    // переключение  между widgets
    _isNext(false);
  }

  void backspase() {
    _printElements();

    String oldInput;
    String newInput;

// взависимости от астивного ввода
    if (isAcathet.value) {
      oldInput = aCathet.value;
      newInput = StringUtils.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      aCathet.value = newInput;
    } else if (isBcathet.value) {
      oldInput = bCathet.value;
      newInput = StringUtils.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      bCathet.value = newInput;
    } else if (isChypotenuse.value) {
      oldInput = cHypotenuse.value;
      newInput = StringUtils.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      cHypotenuse.value = newInput;
    } else if (isAangle.value) {
      oldInput = aAngle.value;

      if (StringUtils.getLastCharacter(oldInput) == '°') {
        oldInput = StringUtils.removeLastCharacter(oldInput);
      }
      newInput = StringUtils.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = _startLengthValue;
      }
      aAngle.value = newInput + '°';
    } else if (isBangle.value) {
      oldInput = bAngle.value;

      if (StringUtils.getLastCharacter(oldInput) == '°') {
        oldInput = StringUtils.removeLastCharacter(oldInput);
      }
      newInput = StringUtils.removeLastCharacter(oldInput);

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

    isAcathet.value = true;
    isBcathet.value = false;
    isChypotenuse.value = false;
    isAangle.value = false;
    isBangle.value = false;
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
