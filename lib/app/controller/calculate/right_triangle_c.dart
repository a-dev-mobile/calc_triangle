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

  double aCathetD = 0.0;
  double bCathetD = 0.0;
  double cHypotenuseD = 0.0;
  double hHeightD = 0.0;
  double mCompCsideD = 0;
  double kCompCsideD = 0;
  double bAngleD = 0.0;
  double aAngleD = 0.0;

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
    if (isAngleOver90(keySymbol)) {
      printt.e('isAngleOver90');
      showSnack(TranslateHelper.messageAngleOver90);

      return;
    }

    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;
    printt.v('start input');
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
    printElements();
    printt.v('end input');
    setActiveParam();
    showMessage();

    if (isActiveOneParamEmpty()) return;

    initValue();
    setActiveParam();
    calculate();
    showMessage();

    printElements();
    printt.v('end click ${keySymbol.value}');
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
    printt.v('start initValue');

    if (isDeg.isFalse) {
      convertDMSToDeg();
    }

    // if (isValueChange()) {
    try {
      if (activeParamMap.containsValue(RightTriangle.aCathet)) {
        aCathetD = double.parse(aCathet.value);
      }

      if (activeParamMap.containsValue(RightTriangle.bCathet)) {
        bCathetD = double.parse(bCathet.value);
      }

      if (activeParamMap.containsValue(RightTriangle.cHypotenuse)) {
        cHypotenuseD = double.parse(cHypotenuse.value);
      }

      if (activeParamMap.containsValue(RightTriangle.hHeight)) {
        hHeightD = double.parse(hHeight.value);
      }

      if (activeParamMap.containsValue(RightTriangle.mCompCside)) {
        mCompCsideD = double.parse(mCompCside.value);
      }
      if (activeParamMap.containsValue(RightTriangle.kCompCside)) {
        kCompCsideD = double.parse(kCompCside.value);
      }

      if (activeParamMap.containsValue(RightTriangle.aAngle)) {
        aAngleD =
            double.parse(AppUtilsString.removeLastCharacter(aAngle.value));
      }

      if (activeParamMap.containsValue(RightTriangle.bAngle)) {
        bAngleD =
            double.parse(AppUtilsString.removeLastCharacter(bAngle.value));
      }
    } catch (e) {
      printt.e('initValue error to double');
      resetValue();
      resetActiveParam();
    }
    // }
  }

  void calcMKCompCsideKnowAcatAangChypo() {
    kCompCsideD = aCathetD * cos(AppUtilsNumber.toRadian(aAngleD));
    kCompCside.value =
        AppUtilsNumber.getFormatNumber(kCompCsideD, precisionResult);

    mCompCsideD = cHypotenuseD - kCompCsideD;
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);
  }

  void calcBangleKnowAang() {
    bAngleD = 90 - aAngleD;
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAangKnowBang() {
    aAngleD = 90 - bAngleD;
    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calchHeightKnowAcatAangl() {
    hHeightD = aCathetD * sin(AppUtilsNumber.toRadian(aAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowBcatChypo() {
    bAngleD = AppUtilsNumber.toDegree(acos(bCathetD / cHypotenuseD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcBangKnowAcatBcatChypo() {
    bAngleD = AppUtilsNumber.toDegree(acos(
        (pow(bCathetD, 2) + pow(cHypotenuseD, 2) - pow(aCathetD, 2)) /
            (2 * bCathetD * cHypotenuseD)));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcChypoKnowAcatBcat() {
    cHypotenuseD = sqrt(pow(aCathetD, 2) + pow(bCathetD, 2));
    cHypotenuse.value =
        AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);
  }

  void calcBcatKnowChypAcat() {
    bCathetD = sqrt(pow(cHypotenuseD, 2) - pow(aCathetD, 2));
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcAcatKnowChypBcat() {
    aCathetD = sqrt(pow(cHypotenuseD, 2) - pow(bCathetD, 2));
    aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);
  }

  void calcBcatKnowAcatAang() {
    bCathetD = aCathetD * tan(AppUtilsNumber.toRadian(aAngleD));
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcBcatKnowAcatBang() {
    bCathetD = aCathetD / tan(AppUtilsNumber.toRadian(bAngleD));
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcAcatKnowBcatAang() {
    aCathetD = bCathetD / tan(AppUtilsNumber.toRadian(aAngleD));
    aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);
  }

/*  void calcBangKnowHheiBcat() {
   bAngleD = AppUtilsNumber.toDegree(asin(hHeightD / bCathetD));
    bAngle.value = AppUtilsNumber.getFormatNumber(
            bAngleD, precisionResult) +
        "°";
  }
 */

  void calcAangKnowHheiAcat() {
    aAngleD = AppUtilsNumber.toDegree(asin(hHeightD / aCathetD));
    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcBangKnowHheibcat() {
    bAngleD = AppUtilsNumber.toDegree(asin(hHeightD / bCathetD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAcatKnowBcatBang() {
    aCathetD = bCathetD * tan(AppUtilsNumber.toRadian(bAngleD));
    aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);
  }

  void calcBcatKnowChypKcomp() {
    bCathetD = sqrt(cHypotenuseD * kCompCsideD);
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcAcatKnowChypMcomp() {
    aCathetD = sqrt(cHypotenuseD * mCompCsideD);
    aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);
  }

  void calcHheiKnowBcatKcomp() {
    hHeightD = sqrt(pow(bCathetD, 2) - pow(kCompCsideD, 2));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowHheiBcat() {
    // ok
    bAngleD = AppUtilsNumber.toDegree(asin(hHeightD / bCathetD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcMcompKnowChypKcomp() {
    mCompCsideD = cHypotenuseD - kCompCsideD;
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);
  }

  void calculate() {
    printt.i('start calculate');
    printElements();
    RightTriangle activeParm2 = activeParamMap[2]!;
    bool conditionOne = false;
    bool conditionTwo = false;

    //find aAngle
    conditionOne = activeParm2 == RightTriangle.aAngle;
    if (conditionOne) calcBangleKnowAang();

    //find bAngle
    conditionTwo = activeParm2 == RightTriangle.bAngle;
    if (conditionTwo) calcAangKnowBang();

    RightTriangle paramKnow1;
    RightTriangle paramKnow2;

    // ==========================================
    // aCat bCat ==OK
    // ==========================================
    paramKnow1 = RightTriangle.aCathet;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcChypoKnowAcatBcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // aCat cHyp ==OK
    // ==========================================
    paramKnow1 = RightTriangle.aCathet;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcBcatKnowChypAcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // aCat aAng ==OK
    // ==========================================
    paramKnow1 = RightTriangle.aAngle;
    paramKnow2 = RightTriangle.aCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // aCat bAng ==OK
    // ==========================================
    paramKnow1 = RightTriangle.bAngle;
    paramKnow2 = RightTriangle.aCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcBcatKnowAcatBang();
      calcChypoKnowAcatBcat();
      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }
// aCat mSideC

    //================================================
    // aCat kSideC
    //================================================
    paramKnow1 = RightTriangle.hHeight;
    paramKnow2 = RightTriangle.aCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcAangKnowHheiAcat();
      // calcBangleKnowAang();
      // calcBcatKnowAcatAang();
      // calcChypoKnowAcatBcat();
      // calcMKCompCsideKnowAcatAangChypo();
    }
// aCat hHeight

    // ==========================================
    // bCat cHyp ==OK
    // ==========================================
    paramKnow1 = RightTriangle.bCathet;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      calcAcatKnowChypBcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // bCat aAng ==OK
    // ==========================================
    paramKnow1 = RightTriangle.aAngle;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcAcatKnowBcatAang();
      calcChypoKnowAcatBcat();
      calcBangleKnowAang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // bCat bAng ==OK
    // ==========================================
    paramKnow1 = RightTriangle.bAngle;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      calcAcatKnowBcatBang();

      calcChypoKnowAcatBcat();
      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // bCat mSideC
    // ==========================================
    paramKnow1 = RightTriangle.mCompCside;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {}

    // ==========================================
    // bCat kSideC ==OK
    // ==========================================
    paramKnow1 = RightTriangle.kCompCside;
    paramKnow2 = RightTriangle.bCathet;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);
    if (conditionOne && conditionTwo) {
      calcHheiKnowBcatKcomp();
      calcBangKnowHheiBcat();
      calcAangKnowBang();
      calcAcatKnowBcatAang();
      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();
    }
    // ==========================================
    // bCat hHeight
    // ==========================================
    paramKnow1 = RightTriangle.bCathet;
    paramKnow2 = RightTriangle.hHeight;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      calcBangKnowHheibcat();
      // calcAangKnowBang();
      // calcAcatKnowBcatAang();
      // calcChypoKnowAcatBcat();
      // calcMKCompCsideKnowAcatAangChypo();
    }
    // ==========================================
    // cHyp aAng
    // ==========================================
    paramKnow1 = RightTriangle.aAngle;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(aAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(aAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      calcBangleKnowAang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

    // ==========================================
    // cHyp bAng
    // ==========================================
    paramKnow1 = RightTriangle.bAngle;
    paramKnow2 = RightTriangle.cHypotenuse;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      aCathetD = cHypotenuseD * sin(AppUtilsNumber.toRadian(bAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bCathetD = cHypotenuseD * cos(AppUtilsNumber.toRadian(bAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      calcAangKnowBang();
      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();
    }

// cHyp mSideC
// cHyp kSideC
// cHyp hHeight
// aAng bAng
// aAng mSideC
// aAng kSideC
// aAng hHeight
// bAng mSideC
// bAng kSideC
// bAng hHeight

    //================================================
    // mSideC kSideC
    //================================================
    paramKnow1 = RightTriangle.mCompCside;
    paramKnow2 = RightTriangle.kCompCside;
    conditionOne = activeParamMap.containsValue(paramKnow1);
    conditionTwo = activeParamMap.containsValue(paramKnow2);

    if (conditionOne && conditionTwo) {
      hHeightD = sqrt(mCompCsideD * kCompCsideD);
      hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);

      cHypotenuseD = kCompCsideD + mCompCsideD;
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);

      calcAcatKnowChypMcomp();
      calcBcatKnowChypKcomp();

      calcBangKnowBcatChypo();
      calcAangKnowBang();
    }

// mSideC hHeight
// kSideC hHeight

// проверка если цифры не числа
    checkIfNaN();
    printElements();
    printt.i('end calculate');
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
    printt.v(
        'start active param ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]}');
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
        'end active param ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]}');
  }

  void showMessage() {
    printt.v('start show message');
    // если есть пустой параметр
    if (isActiveOneParamEmpty()) {
      showSnack(TranslateHelper.enterOneParameters);
      return;
    }

    if (isActiveParamAngles()) {
      showSnack(TranslateHelper.messageEnterValueSides);
      return;
    }
    if (isActiveTwoParamEmpty()) {
      showSnack(TranslateHelper.enterTwoParameters);
      return;
    }

    if (!(kCompCsideD < bCathetD)) {
      showSnack('Component k must be < b = ${bCathet.value}');
      return;
    }

    if (!(hHeightD < aCathetD)) {
      showSnack('Height h must be < a = ${aCathet.value}');
      return;
    }

    if (!(hHeightD < bCathetD)) {
      showSnack('Height h must be < b = ${bCathet.value}');
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

  bool isActiveOneParamEmpty() {
    if (activeParamMap[1] == RightTriangle.empty &&
            activeParamMap[2] != RightTriangle.empty ||
        activeParamMap[2] == RightTriangle.empty &&
            activeParamMap[1] != RightTriangle.empty) {
      return true;
    }
    return false;
  }

  bool isActiveTwoParamEmpty() {
    if (activeParamMap[1] == RightTriangle.empty &&
        activeParamMap[2] == RightTriangle.empty) {
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

  void printElements() {
    printt.v('''printElements
        ${activeParamMap[1]} ${activeParamMap[2]}

        $aCathetD ${aCathet.value} aCathet 
        $bCathetD ${bCathet.value} bCathet 
        $cHypotenuseD ${cHypotenuse.value} cHypotenuse 
        $hHeightD ${hHeight.value} Height
        $mCompCsideD ${mCompCside.value} mCompCside
        $kCompCsideD ${kCompCside.value} kCompCside
        $aAngleD ${aAngle.value} aAngle 
        $bAngleD ${bAngle.value} bAngle
       ''');
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
