import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/shared_components/numpad/key.dart';
import 'package:calc_triangle/app/shared_components/numpad/key_symbol.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/utils/app_convert.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';

import 'package:calc_triangle/app/utils/logger.dart';
import 'package:calc_triangle/app/utils/validation_utils.dart';

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

// late WelcomeController c = Get.find();

class RightTriangleController extends GetxController {
  static RightTriangleController get to => Get.find<RightTriangleController>();

  static const startAngleValue = '0°';
  static const startLengthValue = '0';

  var activeParamMap = <int, RightTriangle>{}.obs;

  var aAngle = startAngleValue.obs;
  var aCathet = startLengthValue.obs;
  var bAngle = startAngleValue.obs;
  var bCathet = startLengthValue.obs;
  var cHypotenuse = startLengthValue.obs;
  var hHeight = startLengthValue.obs;
  var kCompCside = startLengthValue.obs;
  var mCompCside = startLengthValue.obs;

  var area = "".obs;
  var perimeter = "".obs;

  var aAngleD = 0.0;
  var aCathetD = 0.0;
  var bAngleD = 0.0;
  var bCathetD = 0.0;
  var cHypotenuseD = 0.0;
  var hHeightD = 0.0;
  var kCompCsideD = 0.0;
  var mCompCsideD = 0.0;

  var isDeg = true.obs;
  var isaAngle = false.obs;
  var isaCathet = false.obs;
  var isbAngle = false.obs;
  var isbCathet = false.obs;
  var iscHypotenuse = false.obs;
  var ishHeight = false.obs;
  var iskCompCside = false.obs;
  var ismCompCside = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isActiveImageInfo = false.obs;

  //что  бы не сбрасывать в методе
  RightTriangle paramLenght = RightTriangle.empty;

  int precisionResult = 0;

  @override
  void onReady() {
    log.i(' right onReady');
    // closeStreem();
    clearAll();
    // precisionResult = GlobalServ.to.precisionResult.value;
    showSnack(TranslateHelper.enterTwoParameters);

    super.onReady();
  }

  @override
  void onInit() {
    log.i(' right onInit');
    super.onInit();
  }

  @override
  void onClose() {
    log.i(' right onClose');
    // closeStreem();

    clearAll();
    super.onClose();
  }

  void closeStreem() {
    aAngle.close();

    aCathet.close();
    bAngle.close();
    bCathet.close();
    cHypotenuse.close();
    hHeight.close();
    kCompCside.close();
    mCompCside.close();

    isDeg.close();
    isaAngle.close();
    isaCathet.close();
    isbAngle.close();
    isbCathet.close();
    iscHypotenuse.close();
    ishHeight.close();
    iskCompCside.close();
    ismCompCside.close();
  }

  void clickKey(KeySymbol keySymbol) {
    log.v('start click ${keySymbol.value}');
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
      log.e('return max value');
      showSnack('max value');
      return;
    }

    // если две точки возврат
    if (isTwoDecimalPointRightTriangle(keySymbol)) {
      log.e('isTwoDecimalPointRightTriangle');

      return;
    }
    if (isAngleOver90(keySymbol)) {
      log.e('isAngleOver90');
      showSnack(TranslateHelper.messageAngleOver90);

      return;
    }

    String newInput = keySymbol.value;
    String oldInput;
    String sumInput;
    log.v('start input');
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
    log.v('end input');
    setActiveParam();
    showMessage();

    if (isActiveOneParamEmpty()) return;

    initValue();
    setActiveParam();
    calculate();
    showMessage();

    printElements();
    log.v('end click ${keySymbol.value}');
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
    if (isaCathet.value) {
      if (ValidationUtils.isTwoDecimalPoint(aCathet.value + keySymbol.value)) {
        return true;
      }
    } else if (isbCathet.value) {
      if (ValidationUtils.isTwoDecimalPoint(bCathet.value + keySymbol.value)) {
        return true;
      }
    } else if (iscHypotenuse.value) {
      if (ValidationUtils.isTwoDecimalPoint(
          cHypotenuse.value + keySymbol.value)) {
        return true;
      }
    } else if (ishHeight.value) {
      if (ValidationUtils.isTwoDecimalPoint(hHeight.value + keySymbol.value)) {
        return true;
      }
    } else if (ismCompCside.value) {
      if (ValidationUtils.isTwoDecimalPoint(
          mCompCside.value + keySymbol.value)) {
        return true;
      }
    } else if (iskCompCside.value) {
      if (ValidationUtils.isTwoDecimalPoint(
          kCompCside.value + keySymbol.value)) {
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
    log.v('start initValue');

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
      log.e('initValue error to double');
      resetValue();
      resetActiveParam();
    }
    // }
  }

  void calcMKCompCsideKnowAcatAangChypo() {
    mCompCsideD = aCathetD * cos(AppConvert.toRadian(aAngleD));
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);

    kCompCsideD = cHypotenuseD - mCompCsideD;
    kCompCside.value =
        AppUtilsNumber.getFormatNumber(kCompCsideD, precisionResult);
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
    hHeightD = aCathetD * sin(AppConvert.toRadian(aAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowBcatChypo() {
    bAngleD = AppConvert.toDegree(acos(bCathetD / cHypotenuseD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcBangKnowAcatBcatChypo() {
    bAngleD = AppConvert.toDegree(acos(
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
    bCathetD = aCathetD * tan(AppConvert.toRadian(aAngleD));
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcBcatKnowAcatBang() {
    bCathetD = aCathetD / tan(AppConvert.toRadian(bAngleD));
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcAcatKnowBcatAang() {
    aCathetD = bCathetD / tan(AppConvert.toRadian(aAngleD));
    aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);
  }

  void calcAangKnowHheiAcat() {
    aAngleD = AppConvert.toDegree(asin(hHeightD / aCathetD));
    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcBangKnowHheibcat() {
    bAngleD = AppConvert.toDegree(asin(hHeightD / bCathetD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAcatKnowBcatBang() {
    aCathetD = bCathetD * tan(AppConvert.toRadian(bAngleD));
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

  void calcHheiKnowBcatMcomp() {
    hHeightD = sqrt(pow(bCathetD, 2) - pow(mCompCsideD, 2));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcHheiKnowAcatMcomp() {
    hHeightD = sqrt(pow(aCathetD, 2) - pow(mCompCsideD, 2));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowHheiBcat() {
    // ok
    bAngleD = AppConvert.toDegree(asin(hHeightD / bCathetD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAangKnowHheiMcomp() {
    aAngleD = AppConvert.toDegree(atan(hHeightD / mCompCsideD));
    aAngle.value =
        AppUtilsNumber.getFormatNumber(aAngleD, precisionResult) + "°";
  }

  void calcBangKnowHheiKcomp() {
    bAngleD = AppConvert.toDegree(atan(hHeightD / kCompCsideD));
    bAngle.value =
        AppUtilsNumber.getFormatNumber(bAngleD, precisionResult) + "°";
  }

  void calcAcatKnowHheiAang() {
    aCathetD = hHeightD / (sin(AppConvert.toRadian(aAngleD)));
    aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);
  }

  void calcBcatKnowHheiBang() {
    bCathetD = hHeightD / (sin(AppConvert.toRadian(bAngleD)));
    bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);
  }

  void calcMcompKnowChypKcomp() {
    mCompCsideD = cHypotenuseD - kCompCsideD;
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);
  }

  void calcKcompKnowChypMcomp() {
    kCompCsideD = cHypotenuseD - mCompCsideD;
    kCompCside.value =
        AppUtilsNumber.getFormatNumber(kCompCsideD, precisionResult);
  }

  void calchHeightKnowAangMcomp() {
    hHeightD = mCompCsideD * tan(AppConvert.toRadian(aAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calchHeightKnowBangKcomp() {
    hHeightD = kCompCsideD * tan(AppConvert.toRadian(bAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcAreaKnowAcatBcat() {
    area.value = AppUtilsNumber.getFormatNumber(
        0.5 * aCathetD * bCathetD, precisionResult);
  }

  void calcPerimKnowAcatBcatChyp() {
    perimeter.value = AppUtilsNumber.getFormatNumber(
        aCathetD + bCathetD + cHypotenuseD, precisionResult);
  }

  void calculate() {
    log.i('start calculate');
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

    RightTriangle param1;
    RightTriangle param2;

    // ==========================================
    // aCat bCat ==OK
    // ==========================================
    param1 = RightTriangle.aCathet;
    param2 = RightTriangle.bCathet;
    if (isBeParam(param1, param2)) {
      calcChypoKnowAcatBcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // aCat cHyp ==OK
    // ==========================================
    param1 = RightTriangle.aCathet;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      calcBcatKnowChypAcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // aCat aAng ==OK
    // ==========================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.aCathet;
    if (isBeParam(param1, param2)) {
      calcBangleKnowAang();
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // aCat bAng ==OK
    // ==========================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.aCathet;
    if (isBeParam(param1, param2)) {
      calcBcatKnowAcatBang();
      calcChypoKnowAcatBcat();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // aCat mSideC ==OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.aCathet;
    if (isBeParam(param1, param2)) {
      calcHheiKnowAcatMcomp();
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcChypoKnowAcatBcat();
      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // aCat hHeight ==OK
    //================================================
    param1 = RightTriangle.hHeight;
    param2 = RightTriangle.aCathet;
    if (isBeParam(param1, param2)) {
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }
    // ==========================================
    // bCat cHyp ==OK
    // ==========================================
    param1 = RightTriangle.bCathet;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      calcAcatKnowChypBcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // bCat aAng ==OK
    // ==========================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.bCathet;
    if (isBeParam(param1, param2)) {
      calcAcatKnowBcatAang();
      calcChypoKnowAcatBcat();
      calcBangleKnowAang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // bCat bAng ==OK
    // ==========================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.bCathet;
    if (isBeParam(param1, param2)) {
      calcAcatKnowBcatBang();
      calcChypoKnowAcatBcat();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // bCat kSideC ==OK
    // ==========================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.bCathet;
    if (isBeParam(param1, param2)) {
      calcHheiKnowBcatKcomp();
      calcBangKnowHheiBcat();
      calcAangKnowBang();
      calcAcatKnowBcatAang();

      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }
    // ==========================================
    // bCat hHeight ==OK
    // ==========================================
    param1 = RightTriangle.bCathet;
    param2 = RightTriangle.hHeight;
    if (isBeParam(param1, param2)) {
      calcBangKnowHheibcat();
      calcAangKnowBang();
      calcAcatKnowBcatAang();

      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }
    // ==========================================
    // cHyp aAng ==OK
    // ==========================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      aCathetD = cHypotenuseD * cos(AppConvert.toRadian(aAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bCathetD = cHypotenuseD * sin(AppConvert.toRadian(aAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      calcBangleKnowAang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    // ==========================================
    // cHyp bAng ==OK
    // ==========================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      aCathetD = cHypotenuseD * sin(AppConvert.toRadian(bAngleD));
      aCathet.value = AppUtilsNumber.getFormatNumber(aCathetD, precisionResult);

      bCathetD = cHypotenuseD * cos(AppConvert.toRadian(bAngleD));
      bCathet.value = AppUtilsNumber.getFormatNumber(bCathetD, precisionResult);

      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // cHyp mSideC ==OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      calcKcompKnowChypMcomp();
      calcAcatKnowChypMcomp();
      calcHheiKnowAcatMcomp();
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // cHyp kSideC ==OK
    //================================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      calcMcompKnowChypKcomp();
      calcAcatKnowChypMcomp();
      calcHheiKnowAcatMcomp();
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // aAng mSideC ==OK
    //================================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.mCompCside;
    if (isBeParam(param1, param2)) {
      calcBangleKnowAang();
      calchHeightKnowAangMcomp();

      calcAcatKnowHheiAang();

      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // aAng kSideC ==OK
    //================================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.kCompCside;
    if (isBeParam(param1, param2)) {
      calcBangleKnowAang();
      calchHeightKnowBangKcomp();

      calcAcatKnowHheiAang();

      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // aAng hHeight ==OK
    //================================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.hHeight;
    if (isBeParam(param1, param2)) {
      calcBangleKnowAang();
      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }
    //================================================
    // bAng kSideC ==OK
    //================================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.kCompCside;
    if (isBeParam(param1, param2)) {
      calcAangKnowBang();
      calchHeightKnowBangKcomp();
      calcAcatKnowHheiAang();
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // bAng mSideC ==OK
    //================================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.mCompCside;
    if (isBeParam(param1, param2)) {
      calcAangKnowBang();
      calchHeightKnowAangMcomp();
      calcAcatKnowHheiAang();
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // bAng hHeight ==OK
    //================================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.hHeight;
    if (isBeParam(param1, param2)) {
      calcAangKnowBang();

      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }
    //================================================
    // mSideC kSideC =OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.kCompCside;
    if (isBeParam(param1, param2)) {
      hHeightD = sqrt(mCompCsideD * kCompCsideD);
      hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);

      cHypotenuseD = kCompCsideD + mCompCsideD;
      cHypotenuse.value =
          AppUtilsNumber.getFormatNumber(cHypotenuseD, precisionResult);

      calcAcatKnowChypMcomp();
      calcBcatKnowChypKcomp();

      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // mSideC hHeight ==OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.hHeight;
    if (isBeParam(param1, param2)) {
      calcAangKnowHheiMcomp();
      calcBangleKnowAang();
      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();

      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

    //================================================
    // kSideC hHeight ==OK
    //================================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.hHeight;
    if (isBeParam(param1, param2)) {
      calcBangKnowHheiKcomp();
      calcAangKnowBang();
      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();

      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
    }

// проверка если цифры не числа
    checkIfNaN();
    printElements();
    log.i('end calculate');
  }

  void checkIfNaN() {
    if (ValidationUtils.isNumberNanAndInfinity(aCathetD)) {
      aCathet.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bCathetD)) {
      bCathet.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(cHypotenuseD)) {
      cHypotenuse.value = startLengthValue;
    }

    if (ValidationUtils.isNumberNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(mCompCsideD)) {
      mCompCside.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(kCompCsideD)) {
      kCompCside.value = startLengthValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(aAngleD)) {
      aAngle.value = startAngleValue;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bAngleD)) {
      bAngle.value = startAngleValue;
    }
  }

  void setActiveParam() {
    log.v(
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

    log.v(
        'end active param ${activeParamMap[1]}  ${activeParamMap[2]} ${activeParamMap[3]}');
  }

  bool isBeParam(
    RightTriangle param1,
    RightTriangle param2,
  ) {
    if (activeParamMap.containsValue(param1) &&
        activeParamMap.containsValue(param2)) {
      return true;
    }
    return false;
  }

  void showMessage() {
    RightTriangle param1;
    RightTriangle param2;

    log.v('start show message');

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

    if (isBeParam(RightTriangle.kCompCside, RightTriangle.bCathet)) {
      if (!(kCompCsideD < bCathetD)) {
        showSnack('${TranslateHelper.messageCmoreK}${bCathet.value}');
        return;
      }
    }

    if (isBeParam(RightTriangle.mCompCside, RightTriangle.aCathet)) {
      if (!(aCathetD > mCompCsideD)) {
        showSnack('${TranslateHelper.messageAmoreM}${mCompCside.value}');
        return;
      }
    }
    if (isBeParam(RightTriangle.mCompCside, RightTriangle.cHypotenuse)) {
      if (!(cHypotenuseD > mCompCsideD)) {
        showSnack('${TranslateHelper.messageCmoreM}${mCompCside.value}');
        return;
      }
    }

    if (isBeParam(RightTriangle.kCompCside, RightTriangle.cHypotenuse)) {
      if (!(cHypotenuseD > kCompCsideD)) {
        showSnack('${TranslateHelper.messageCmoreK}${kCompCside.value}');
        return;
      }
    }

    if (isBeParam(RightTriangle.hHeight, RightTriangle.aCathet)) {
      if (!(hHeightD < aCathetD)) {
        showSnack('${TranslateHelper.messageAmoreH}${aCathet.value}');
        return;
      }
    }
    if (isBeParam(RightTriangle.hHeight, RightTriangle.bCathet)) {
      if (!(bCathetD > hHeightD)) {
        showSnack('${TranslateHelper.messageBmoreH}${bCathet.value}');
        return;
      }
    }

//если гипотенуза меньше

    if (isBeParam(RightTriangle.cHypotenuse, RightTriangle.aCathet) ||
        isBeParam(RightTriangle.cHypotenuse, RightTriangle.bCathet)) {
      if (cHypotenuseD < aCathetD || cHypotenuseD < bCathetD) {
        showSnack(TranslateHelper.messageHypotenuseGreaterCathetus);

        return;
      }
    }

//если угол больше 90
    if (90 <= aAngleD || 90 <= bAngleD) {
      showSnack(TranslateHelper.messageAngleOver90);

      return;
    }

    //================================================
    // TODO  cHyp hHeight //not found formula
    //================================================
    param1 = RightTriangle.hHeight;
    param2 = RightTriangle.cHypotenuse;
    if (isBeParam(param1, param2)) {
      showSnack(TranslateHelper.messageFormulaNotFound);
      return;
    }

    // ==========================================
    // bCat mSideC // not found formula
    // ==========================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.bCathet;
    if (isBeParam(param1, param2)) {
      showSnack(TranslateHelper.messageFormulaNotFound);
      return;
    }
    //================================================
    // aCat kSideC //не могу найти формулу
    //================================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.aCathet;
    if (isBeParam(param1, param2)) {
      showSnack(TranslateHelper.messageFormulaNotFound);
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
    log.v('''printElements
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
    aAngle.value = AppConvert.convertDMStoDeg(aAngle.value, precisionResult);
    bAngle.value = AppConvert.convertDMStoDeg(bAngle.value, precisionResult);
  }

  void convertDegToDMS() {
// если мы в минутах то переводим углы
    aAngle.value = AppConvert.convertDegToDMS(aAngleD, precisionResult);
    bAngle.value = AppConvert.convertDegToDMS(bAngleD, precisionResult);
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
      oldInput = mCompCside.value;
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

/*  void calcBangKnowHheiBcat() {
   bAngleD = AppConvert.toDegree(asin(hHeightD / bCathetD));
    bAngle.value = AppUtilsNumber.getFormatNumber(
            bAngleD, precisionResult) +
        "°";
  }
 */
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
