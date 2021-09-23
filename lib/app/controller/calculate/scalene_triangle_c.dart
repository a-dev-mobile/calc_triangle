import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key_symbol.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/main.dart';
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
    static ScaleneTriangleController get to => Get.find<ScaleneTriangleController>();

  static const startAngleValue = '0°';
  static const startLengthValue = '0';

  var activeParamMap = <int, ScaleneTriangle>{}.obs;

  var aAngle = startAngleValue.obs;
  var bAngle = startAngleValue.obs;
  var yAngle = startAngleValue.obs;
  var aSide = startLengthValue.obs;
  var bSide = startLengthValue.obs;
  var cSide = startLengthValue.obs;
  var hHeight = startLengthValue.obs;

  var area = "".obs;
  var perimeter = "".obs;

  var aAngleD = 0.0;
  var bAngleD = 0.0;
  var yAngleD = 0.0;
  var aSideD = 0.0;
  var bSideD = 0.0;
  var cSideD = 0.0;
  var hHeightD = 0.0;

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
  var paramLenght = ScaleneTriangle.empty;

  int precisionResult = 0;

  void clickKey(KeySymbol keySymbol) {
    printt.v('start click ${keySymbol.value}');
    printElements();
    // showMessage();

    if (keySymbol == Keys.next) {
      nextElement();
      // showMessage();
      return;
    }

    if (keySymbol == Keys.prev) {
      prevElement();
      // showMessage();
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
      initValue();
      setActiveParam();
      calculate();
      showMessage();

      return;
    }

    if (ifMaxNumbeEnter()) {
      printt.e('return max value');
      showMessage();
      return;
    }

    // если две точки возврат
    if (isTwoDecimalPointRightTriangle(keySymbol)) {
      printt.e('isTwoDecimalPointRightTriangle');

      return;
    }

    

    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;
    printt.v('start input');
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
    printElements();
    printt.v('end input');
    setActiveParam();
    showMessage();



    initValue();
    setActiveParam();
    calculate();
    showMessage();

    printElements();
    printt.v('end click ${keySymbol.value}');
  }

  void printElements() {
    printt.v('''printElements
        ${activeParamMap[1]} ${activeParamMap[2]}

        $aSideD ${aSide.value} aSide 
        $bSide ${bSide.value} bSide 
        $cSide ${cSide.value} cSide 
        $hHeightD ${hHeight.value} Height
        $aAngleD ${aAngle.value} aAngle 
        $bAngleD ${bAngle.value} bAngle
        $yAngleD ${yAngle.value} yAngle
       ''');
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
    if (isaSide.value) {
      if (AppUtilsString.isTwoDecimalPoint(aSide.value + keySymbol.value)) {
        return true;
      }
    } else if (isbSide.value) {
      if (AppUtilsString.isTwoDecimalPoint(bSide.value + keySymbol.value)) {
        return true;
      }
    } else if (iscSide.value) {
      if (AppUtilsString.isTwoDecimalPoint(cSide.value + keySymbol.value)) {
        return true;
      }
    } else if (ishHeight.value) {
      if (AppUtilsString.isTwoDecimalPoint(hHeight.value + keySymbol.value)) {
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
    } else if (isyAngle.value) {
      if (AppUtilsString.isTwoDecimalPoint(yAngle.value + keySymbol.value)) {
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
    printt.v('start initValue');

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
      printt.e('initValue error to double');
      resetValue();
      resetActiveParam();
    }
    // }
  }

  void calculate() {
    printt.i('start calculate');
    printElements();

// проверка если цифры не числа
    checkIfNaN();
    printElements();
    printt.i('end calculate');
  }

  void checkIfNaN() {
    if (AppUtilsNumber.isNanAndInfinity(aSideD)) {
      aSide.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(bSideD)) {
      bSide.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(cSideD)) {
      cSide.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
    }

    if (AppUtilsNumber.isNanAndInfinity(aAngleD)) {
      aAngle.value = startAngleValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(bAngleD)) {
      bAngle.value = startAngleValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(yAngleD)) {
      yAngle.value = startAngleValue;
    }
  }

  void setActiveParam() {
    printt.v(
        'start active param ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]} ${activeParamMap[4]}');
    var paramAll = ScaleneTriangle.empty;

    if (isaSide.value) {
      if (aSide.value == startLengthValue) {
        resetActiveParam();
        return;
      }

      paramAll = ScaleneTriangle.aSide;
      paramLenght = ScaleneTriangle.aSide;
    } else if (isbSide.value) {
      if (bSide.value == startLengthValue) {
        resetActiveParam();
        return;
      }

      paramAll = ScaleneTriangle.bSide;
      paramLenght = ScaleneTriangle.bSide;
    } else if (iscSide.value) {
      if (cSide.value == startLengthValue) {
        resetActiveParam();
        return;
      }

      paramAll = ScaleneTriangle.cSide;
      paramLenght = ScaleneTriangle.cSide;
    } else if (ishHeight.value) {
      if (hHeight.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramAll = ScaleneTriangle.hHeight;
      paramLenght = ScaleneTriangle.hHeight;
    } else if (isaAngle.value) {
      if (aAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramAll = ScaleneTriangle.aAngle;
    } else if (isbAngle.value) {
      if (bAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramAll = ScaleneTriangle.bAngle;
    } else if (isyAngle.value) {
      if (yAngle.value == startAngleValue) {
        resetActiveParam();
        return;
      }
      paramAll = ScaleneTriangle.yAngle;
    }

    activeParamMap[4] = paramAll;

    if (activeParamMap[1] == activeParamMap[2] ||
        activeParamMap[2] != activeParamMap[3]) {
      activeParamMap[1] = activeParamMap[2]!;
      activeParamMap[2] = activeParamMap[3]!;
    }

// если активные углы то сбрасываем один выбор до последнй длины
    if (isActiveParamAngles()) {
      activeParamMap[1] = paramLenght;
    }

    printt.v(
        'end active param ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]} ${activeParamMap[4]}');
  }

  bool isBeParam(
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
    endSnack();
    // showSnack('OK');
  }

  bool isActiveParamAngles() {
    bool condition1 = activeParamMap.containsValue(ScaleneTriangle.aAngle);
    bool condition2 = activeParamMap.containsValue(ScaleneTriangle.bAngle);
    bool condition3 = activeParamMap.containsValue(ScaleneTriangle.yAngle);

    if (condition1 && condition2 && condition3) {
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
    aAngle.value = AppUtilsNumber.convertDMStoDeg(
        aAngle.value, SettingContrl.to.getStoragePrecisionResults());
    bAngle.value = AppUtilsNumber.convertDMStoDeg(
        bAngle.value, SettingContrl.to.getStoragePrecisionResults());
    yAngle.value = AppUtilsNumber.convertDMStoDeg(
        yAngle.value, SettingContrl.to.getStoragePrecisionResults());
  }

  void convertDegToDMS() {
// если мы в минутах то переводим углы
    aAngle.value =
        AppUtilsNumber.convertDegToDMS(aAngleD, SettingContrl.to.getStoragePrecisionResults());
    bAngle.value =
        AppUtilsNumber.convertDegToDMS(bAngleD, SettingContrl.to.getStoragePrecisionResults());
    yAngle.value =
        AppUtilsNumber.convertDegToDMS(bAngleD, SettingContrl.to.getStoragePrecisionResults());
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
    }
    if (iscSide.value) {
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
    printt.v(' start clearAll');
    printElements();
    resetValue();

    resetActiveInput();
    resetActiveParam();

    printElements();
    printt.v(' end clearAll');
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
