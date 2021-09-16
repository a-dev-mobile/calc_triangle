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
  hHeight,
  kCompCside,
  mCompCside,
  aAngle,
  bAngle,
  empty,
}

late WelcomeController c = Get.find();

class RightTriangleController extends GetxController {
  var aCathet = startLengthValue.obs;
  var bCathet = startLengthValue.obs;
  var cHypotenuse = startLengthValue.obs;
  var hHeight = startLengthValue.obs;
  var kCompCside = startLengthValue.obs;
  var mCompCside = startLengthValue.obs;

  var aAngle = startAngleValue.obs;
  var bAngle = startAngleValue.obs;

  var activeParamMap = <int, RightTriangle>{}.obs;

  //init varable
  var isaCathet = false.obs;
  var isbCathet = false.obs;
  var ishHeight = false.obs;
  var iskCompCside = false.obs;
  var ismCompCside = false.obs;
  var iscHypotenuse = false.obs;
  var isaAngle = false.obs;
  var isbAngle = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isDeg = true.obs;

  static const startLengthValue = '0';
  static const startAngleValue = '0°';

  int precisionResult = c.precisionResult.value;

  String aCathetS = "";
  String bCathetS = "";
  String bAngleS = "";
  String cHypotenuseS = "";
  String hHeightS = "";
  String mCompCsideS = "";
  String kCompCsideS = "";
  String aAngleS = "";

  double aCathetD = 0;
  double bCathetD = 0;
  double cHypotenuseD = 0;
  double hHeightD = 0;
  double mCompCsideD = 0;
  double kCompCsideD = 0;
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
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      hHeight.value = sumInput;
    } else if (ismCompCside.value) {
      oldInput = mCompCside.value;
      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      mCompCside.value = sumInput;
    } else if (iskCompCside.value) {
      oldInput = kCompCside.value;
      // при вводе удаляю стартовый символ
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;

      sumInput = oldInput + newInput;
      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      kCompCside.value = sumInput;
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
    printt.i('calculate');
    initValue();
    setActiveParam();

    calculate();
    showMessage();
    return;
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
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
    } else if (ishHeight.value) {
      if (AppUtilsString.isTwoDecimalPoint(hHeight.value + keySymbol.value)) {
        return true;
      }
    } else if (ismCompCside.value) {
      if (AppUtilsString.isTwoDecimalPoint(
          mCompCside.value + keySymbol.value)) {
        return true;
      }
    } else if (iskCompCside.value) {
      if (AppUtilsString.isTwoDecimalPoint(
          kCompCside.value + keySymbol.value)) {
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
    ishHeight.value = false;
    iskCompCside.value = false;
    ismCompCside.value = false;
    isaAngle.value = false;
    isbAngle.value = false;
  }

  void initValue() {
    // printt.v('initValue');

    if (isDeg.isFalse) {
      convertDMSToDeg();
    }
    aCathetS = aCathet.value;
    bCathetS = bCathet.value;
    bAngleS = bAngle.value;
    cHypotenuseS = cHypotenuse.value;
    hHeightS = hHeight.value;
    mCompCsideS = mCompCside.value;
    kCompCsideS = kCompCside.value;
    aAngleS = aAngle.value;

    try {
      aCathetD = double.parse(aCathetS);
      bCathetD = double.parse(bCathetS);
      cHypotenuseD = double.parse(cHypotenuseS);
      hHeightD = double.parse(hHeightS);
      mCompCsideD = double.parse(mCompCsideS);
      kCompCsideD = double.parse(kCompCsideS);
      bAngleD = double.parse(AppUtilsString.removeLastCharacter(bAngleS));
      aAngleD = double.parse(AppUtilsString.removeLastCharacter(aAngleS));
    } catch (e) {
      printt.e('error to double');
      resetValue();
      resetActiveParam();
    }
    printt.v(
        'initValue\n$aCathetD $aCathetS aCathet \n$bCathetD $bCathetS bCathet \n$cHypotenuseD $cHypotenuseS cHypotenuse \n$aAngleD $aAngleS aAngle \n$bAngleD $bAngleS bAngle');
  }

  void calcCompCside() {
    kCompCsideD = aCathetD * cos(AppUtilsNumber.toRadian(aAngleD));
    kCompCside.value =
        AppUtilsNumber.getFormatNumber(kCompCsideD, precisionResult);

    mCompCsideD = cHypotenuseD - kCompCsideD;
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);
  }

  void calcbAngle() {
    bAngleD = 90 - aAngleD;
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcaAngle() {
    printt.i('calc bAngle = $bAngleD');
    aAngleD = 90 - bAngleD;
    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calchHeight() {
    hHeightD = aCathetD * sin(AppUtilsNumber.toRadian(aAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calculate() {
    initValue();
    RightTriangle activeParm2 = activeParamMap[2]!;
    bool conditionOne = false;
    bool conditionTwo = false;

    //find aAngle
    conditionOne = activeParm2 == RightTriangle.aAngle;
    if (conditionOne) calcbAngle();

    //find bAngle
    conditionTwo = activeParm2 == RightTriangle.bAngle;
    if (conditionTwo) calcaAngle();

    RightTriangle paramKnow1;
    RightTriangle paramKnow2;
    // ==========================================
    // знаем а угол и гипотенузу--
    paramKnow1 = RightTriangle.aAngle;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
     
     
     
     
      calcbAngle();
      calchHeight();
      calcCompCside();
    }

    // ==========================================
    // знаем b угол и гипотенузу--
    paramKnow1 = RightTriangle.bAngle;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
      calcaAngle();
      calchHeight();
      calcCompCside();
    }
    // ==========================================
    // знаем а угол и a катет--
    paramKnow1 = RightTriangle.aAngle;
    paramKnow2 = RightTriangle.aCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      bCathetD = aCathetD * tan(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);
      calcbAngle();
      calchHeight();
      calcCompCside();
    }
    // ==========================================
    // знаем b угол и a катет--
    paramKnow1 = RightTriangle.bAngle;
    paramKnow2 = RightTriangle.aCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      bCathetD = aCathetD / tan(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);
      calcaAngle();
      calchHeight();
      calcCompCside();
    }
    // ==========================================
    // знаем b угол и b катет--
    paramKnow1 = RightTriangle.bAngle;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      aCathetD = bCathetD * tan(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);

      calcaAngle();

      calchHeight();
      calcCompCside();
    }
    // ==========================================
    // знаем а угол и b катет--
    paramKnow1 = RightTriangle.aAngle;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      aCathetD = bCathetD / tan(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);

      calcbAngle();
      calchHeight();
      calcCompCside();
    }
    // ==========================================
    //знаем а катет и в катет --
    paramKnow1 = RightTriangle.aCathet;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      // находим гипотенузу
      cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);

      bAngleD = acos(
          (pow(bCathetD, 2) + pow(cHypotenuseD, 2) - pow(aCathetD, 2)) /
              (2 * bCathetD * cHypotenuseD));
      bAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), precisionResult) +
          "°";
      printt.i('bAngleD = $bAngleD');
      calcaAngle();

      calchHeight();
      calcCompCside();
    }
// ==========================================
    //знаем а катет и гипотенузу--
    paramKnow1 = RightTriangle.aCathet;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      // находим гипотенузу
      bCathetD = sqrt(pow(cHypotenuseD, 2) - pow(aCathetD, 2));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      bAngleD = asin(aCathetD / cHypotenuseD);
      bAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), precisionResult) +
          "°";

      // calcaAngle();

 aAngleD = 90 - bAngleD;
    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";


      calchHeight();
      calcCompCside();
    }
    // ==========================================
    //знаем b катет и гипотенузу--
    paramKnow1 = RightTriangle.bCathet;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      aCathetD = sqrt(pow(cHypotenuseD, 2) - pow(bCathetD, 2));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bAngleD = acos(bCathetD / cHypotenuseD);
      bAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(bAngleD), precisionResult) +
          "°";

      calcaAngle();

      calchHeight();
      calcCompCside();
    }

//================================================

    //знаем m и к части гипотенузы
    conditionOne = activeParamMap.containsValue(RightTriangle.mCompCside);
    conditionTwo = activeParamMap.containsValue(RightTriangle.kCompCside);
    if (conditionOne && conditionTwo) {
      //расчет высоты треугольника
      hHeightD = sqrt(mCompCsideD + kCompCsideD);
      hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
      // расчет гипотезузы
      cHypotenuseD = kCompCsideD + mCompCsideD;
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);

      // расчет сторона А

      aCathetD = sqrt(cHypotenuseD * mCompCsideD);

      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      // расчет сторона b
      bCathetD = sqrt(cHypotenuseD * kCompCsideD);

      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
    }

    //================================================

    //know h и a side
    paramKnow1 = RightTriangle.hHeight;
    paramKnow2 = RightTriangle.aCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      aAngleD = sin(hHeightD / aCathetD);
      aAngle.value = AppUtilsNumber.getFormatNumber(
              AppUtilsNumber.toDegree(aAngleD), precisionResult) +
          "°";
    }
// проверка если цифры не числа
    checkIfNaN();
  }

  void checkIfNaN() {
    if (AppUtilsNumber.isNanAndInfinity(aCathetD)) {
      aCathet.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(bCathetD)) {
      bCathet.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(cHypotenuseD)) {
      cHypotenuse.value = startLengthValue;
    }

    if (AppUtilsNumber.isNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(mCompCsideD)) {
      mCompCside.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(kCompCsideD)) {
      kCompCside.value = startLengthValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(aAngleD)) {
      aAngle.value = startAngleValue;
    }
    if (AppUtilsNumber.isNanAndInfinity(bAngleD)) {
      bAngle.value = startAngleValue;
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
    } else if (ishHeight.value) {
      if (hHeight.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.hHeight;
      paramLenght = RightTriangle.hHeight;
    } else if (ismCompCside.value) {
      if (mCompCside.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.mCompCside;
      paramLenght = RightTriangle.mCompCside;
    } else if (iskCompCside.value) {
      if (kCompCside.value == startLengthValue) {
        resetActiveParam();
        return;
      }
      paramAll = RightTriangle.kCompCside;
      paramLenght = RightTriangle.kCompCside;
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
    printt.v('start convert param ${activeParamMap[1]}  ${activeParamMap[2]}');
    if (activeParamMap[1] == activeParamMap[2] ||
        activeParamMap[2] != activeParamMap[3]) {
      activeParamMap[1] = activeParamMap[2]!;
      activeParamMap[2] = activeParamMap[3]!;
    }

    printt.v('end convert param ${activeParamMap[1]}  ${activeParamMap[2]}');

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
    if (cHypotenuseD < aCathetD || cHypotenuseD < bCathetD) {
      showSnack(TranslateHelper.messageHypotenuseGreaterCathetus);

      return;
    }

//если угол больше 90
    if (90 <= aAngleD || 90 <= bAngleD) {
      showSnack(TranslateHelper.messageAngleOver90);

      return;
    }

    endSnack();
    // showSnack('OK');
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
    } else if (ishHeight.value) {
      value = hHeight.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (iskCompCside.value) {
      value = kCompCside.value;
      if (isMaxNumberInput(value) || isMaxNumberAfterPoint(value)) {
        return true;
      }
    } else if (ismCompCside.value) {
      value = mCompCside.value;
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
    // printt.i(
    // 'print\n\nactiveParam  ${activeParamMap[1]} ${activeParamMap[2]}\naCathetS $aCathetS   bCathetS $bCathetS cHypotenuseS $cHypotenuseS aAngleS $aAngleS bAngleS $bAngleS\naCathetD $aCathetD   bCathetD $bCathetD cHypotenuseD $cHypotenuseD aAngleD $aAngleD bAngleD $bAngleD\nisaCathet ${isaCathet.value} isbCathet ${isbCathet.value} iscHypotenuse ${iscHypotenuse.value} isaAngle ${isaAngle.value} isbAngle ${isbAngle.value}');
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

    if (activeParamMap[1] == RightTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }
    if (activeParamMap[2] == RightTriangle.hHeight &&
        hHeight.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }

    if (activeParamMap[1] == RightTriangle.kCompCside &&
        kCompCside.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }
    if (activeParamMap[2] == RightTriangle.kCompCside &&
        kCompCside.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }
    if (activeParamMap[1] == RightTriangle.mCompCside &&
        mCompCside.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }
    if (activeParamMap[2] == RightTriangle.mCompCside &&
        mCompCside.value == startLengthValue) {
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

  void convertDMSToDeg() {
    aAngle.value = AppUtilsNumber.convertDMStoDeg(
        aAngle.value, AppUtils.getPrecisionResults());
    bAngle.value = AppUtilsNumber.convertDMStoDeg(
        bAngle.value, AppUtils.getPrecisionResults());
  }

  void convertDegToDMS() {
// если мы в минутах то переводим углы
    aAngle.value =
        AppUtilsNumber.convertDegToDMS(aAngleD, AppUtils.getPrecisionResults());
    bAngle.value =
        AppUtilsNumber.convertDegToDMS(bAngleD, AppUtils.getPrecisionResults());
  }

  void clickConvertDeg() {
    isDeg.value = !(isDeg.value);

    isDeg.value ? convertDMSToDeg() : convertDegToDMS();
  }

  void longBackspace() {
// взависимости от активного ввода
    if (isaCathet.value) {
      aCathet.value = startLengthValue;
    } else if (isbCathet.value) {
      bCathet.value = startLengthValue;
    } else if (iscHypotenuse.value) {
      cHypotenuse.value = startLengthValue;
    } else if (ishHeight.value) {
      hHeight.value = startLengthValue;
    } else if (ismCompCside.value) {
      mCompCside.value = startLengthValue;
    } else if (iskCompCside.value) {
      kCompCside.value = startLengthValue;
    } else if (isaAngle.value) {
      aAngle.value = startAngleValue;
    } else if (isbAngle.value) {
      bAngle.value = startAngleValue;
    }
    initValue();
    setActiveParam();
    calculate();
    showMessage();

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
    } else if (iskCompCside.value) {
      oldInput = kCompCside.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      kCompCside.value = newInput;
    } else if (ismCompCside.value) {
      oldInput = kCompCside.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        newInput = startLengthValue;
      }
      mCompCside.value = newInput;
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
    }
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
    hHeight.value = startLengthValue;
    kCompCside.value = startLengthValue;
    mCompCside.value = startLengthValue;
    aAngle.value = startAngleValue;
    bAngle.value = startAngleValue;

    aCathetD = bCathetD = cHypotenuseD =
        hHeightD = kCompCsideD = mCompCsideD = bAngleD = aAngleD = 0;
    isDeg.value = true;
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

/* 
enum RightTriangle {
  aCathet,
  bCathet,
  cHypotenuse,
  hHeight,
  kCompCside,
  mCompCside,
  aAngle,
  bAngle,
  empty,
}

var values = RightTriangle.values;
Map<RightTriangle, bool> paramets = {};

void main(List<String> arguments) {


  resetParam();

  paramets[RightTriangle.bAngle] = true;
  printParam();
  resetParam();
  paramets[RightTriangle.cHypotenuse] = true;
  printParam();

  return;
}

void resetParam() {
  for (int i = 0; i < values.length - 1; i++) {
    paramets[values[i]] = false;
  }
}

void printParam() {
  for (var item in paramets.entries) {
    print('${item.key}  ${item.value}');
  }
    print('');
}

List<dynamic> getListWithoutLastVal(List val) {
  List list = [];

  for (var item in val) {
    list.add(item);
  }

  return list;
}


 */
