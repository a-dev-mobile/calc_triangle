// ignore_for_file: non_constant_identifier_names

import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/numpad/key.dart';
import 'package:calc_triangle/app/shared_components/numpad/key_symbol.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/utils/app_convert.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/utils/app_utils_map.dart';

import 'package:calc_triangle/app/utils/logger.dart';
import 'package:calc_triangle/app/utils/validation_utils.dart';

import 'dart:math';
import 'package:get/get.dart';

enum RightTriangle {
  aSide,
  bSide,
  cSide,
  hHeight,
  kCompCside,
  mCompCside,
  aAngle,
  bAngle,
  empty,
}

class RightTriangleController extends GetxController {
  static RightTriangleController get to => Get.find<RightTriangleController>();

  static const startAngleValue = '0°';
  static const startLengthValue = '0';

  var activeParamMap = <int, RightTriangle>{}.obs;

  var aSide = startLengthValue.obs;
  var bSide = startLengthValue.obs;
  var cSide = startLengthValue.obs;
  var hHeight = startLengthValue.obs;
  var kCompCside = startLengthValue.obs;
  var mCompCside = startLengthValue.obs;
  var aAngle = startAngleValue.obs;
  var bAngle = startAngleValue.obs;

  double aSideD = 0.0;
  double bSideD = 0.0;
  double cSideD = 0.0;
  double hHeightD = 0.0;
  double kCompCsideD = 0.0;
  double mCompCsideD = 0.0;
  double aAngleD = 0.0;
  double bAngleD = 0.0; /////////////////////////////
  var area = "".obs;
  var perimeter = "".obs;
  var xSPoint = "".obs;
  var ySPoint = "".obs;
/////////////////////////////
  double areaD = 0.0;
  double perimeterD = 0.0;
  double xSPointD = 0.0;
  double ySPointD = 0.0;
/////////////////////////////

  var mA = "".obs;
  var mB = "".obs;
  var mC = "".obs;
  double mAd = 0.0;
  double mBd = 0.0;
  double mCd = 0.0;
/////////////////////////////

  var lA = "".obs;
  var lB = "".obs;
  var lC = "".obs;
  double lAd = 0.0;
  double lBd = 0.0;
  double lCd = 0.0;

  //// Radius of the inscribed circle
  var rInscribed = "".obs;
  var xr = "".obs;
  var yr = "".obs;
  double rd = 0.0;
  double xrd = 0.0;
  double yrd = 0.0;

  var Rcircum = "".obs;
  var xR = "".obs;
  var yR = "".obs;
  double Rd = 0.0;
  double xRd = 0.0;
  double yRd = 0.0;

/////////////////////////////
  var isDeg = true.obs;
  var isaAngle = false.obs;
  var isaSide = false.obs;
  var isbAngle = false.obs;
  var isbSide = false.obs;
  var iscSide = false.obs;
  var ishHeight = false.obs;
  var iskCompCside = false.obs;
  var ismCompCside = false.obs;

  var isActiveSnackBar = false.obs;
  var messageSnackBar = ''.obs;
  var isActiveImageInfo = false.obs;

  //что  бы не сбрасывать в методе
  var paramLastLenght = RightTriangle.empty;

  late int precisionResult;
  String message = "";
  bool isNotFormula = false;
  @override
  void onInit() {
    clearAll();
    showMessage();
    super.onInit();
  }

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

    //если нажалти на конвертацию
    if (keySymbol == Keys.deg || keySymbol == Keys.degMinSec) {
      clickConvertDeg();
      return;
    }

    //если у нас углы в минутах при нажатие любой кнопки далее очищаем ввод
    if (isDeg.isFalse) {
      resetAllValue();
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
    if (isAngleOver90(keySymbol)) {
      log.e('isAngleOver90');
      showSnack(TranslateHelper.messageAngleOver90);

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
    } else if (isbSide.value) {
      oldInput = bSide.value;

      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);
      bSide.value = sumInput;
    } else if (iscSide.value) {
      oldInput = cSide.value;

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

      aAngle.value = "$sumInput°";
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

      // удаляю знак угла
      oldInput = AppUtilsString.removeLastCharacter(oldInput);
      //удаляю начальное значение при вводе
      oldInput == startLengthValue ? oldInput = '' : oldInput = oldInput;
      sumInput = oldInput + newInput;

      sumInput = AppUtilsString.addZeroIsFirstDecimal(sumInput);

      bAngle.value = "$sumInput°";
    }

    log.v('end input');
    // setActiveParam();
    // showMessage();

    // if (isActiveOneParamEmpty()) return;

    setActiveParam();
    log.v(
        '1 ${activeParamMap[1]} 2 ${activeParamMap[2]}  click end active param');

    initValue();
    calculate();
    showMessage();

    printElements();
    log.w('end click ${keySymbol.value}');
  }

  void printElements() {
    log.v('''printElements
        ${activeParamMap[1]} ${activeParamMap[2]}

        $aSideD | ${aSide.value} aCathet 
        $bSideD | ${bSide.value} bCathet 
        $cSideD | ${cSide.value} cHypotenuse 
        $hHeightD | ${hHeight.value} Height
        $mCompCsideD | ${mCompCside.value} mCompCside
        $kCompCsideD | ${kCompCside.value} kCompCside
        $aAngleD | ${aAngle.value} aAngle 
        $bAngleD | ${bAngle.value} bAngle
       ''');
  }

  bool isTwoDecimalPointRightTriangle(KeySymbol keySymbol) {
    if (isaSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(aSide.value + keySymbol.value)) {
        return true;
      }
    } else if (isbSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(bSide.value + keySymbol.value)) {
        return true;
      }
    } else if (iscSide.value) {
      if (ValidationUtils.isTwoDecimalPoint(cSide.value + keySymbol.value)) {
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

  void resetActiveParams() {
    activeParamMap.value = <int, RightTriangle>{
      1: RightTriangle.empty,
      2: RightTriangle.empty,
    };
  }

  void resetActiveInput() {
//начальное значение при запуске
    isaSide.value = true;
    isbSide.value = false;
    iscSide.value = false;
    ishHeight.value = false;
    iskCompCside.value = false;
    ismCompCside.value = false;
    isaAngle.value = false;
    isbAngle.value = false;
  }

  void initValue() {
    log.w('start initValue');

    if (isDeg.isFalse) {
      convertDMSToDeg();
    }

    // if (isValueChange()) {
    try {
      if (activeParamMap.containsValue(RightTriangle.aSide)) {
        aSideD = double.parse(aSide.value);
      }

      if (activeParamMap.containsValue(RightTriangle.bSide)) {
        bSideD = double.parse(bSide.value);
      }

      if (activeParamMap.containsValue(RightTriangle.cSide)) {
        cSideD = double.parse(cSide.value);
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
      resetAllValue();
      resetActiveParams();
    }
    // }
  }

  void calcMKCompCsideKnowAcatAangChypo() {
    mCompCsideD = aSideD * cos(AppConvert.toRadian(aAngleD));
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);

    kCompCsideD = cSideD - mCompCsideD;
    kCompCside.value =
        AppUtilsNumber.getFormatNumber(kCompCsideD, precisionResult);
  }

  void calcBangleKnowAang() {
    bAngleD = 90 - aAngleD;
    bAngle.value =
        "${AppUtilsNumber.getFormatNumber(bAngleD, precisionResult)}°";
  }

  void calcAangKnowBang() {
    aAngleD = 90 - bAngleD;
    aAngle.value =
        "${AppUtilsNumber.getFormatNumber(aAngleD, precisionResult)}°";
  }

  void calchHeightKnowAcatAangl() {
    hHeightD = aSideD * sin(AppConvert.toRadian(aAngleD));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowBcatChypo() {
    bAngleD = AppConvert.toDegree(acos(bSideD / cSideD));
    bAngle.value =
        "${AppUtilsNumber.getFormatNumber(bAngleD, precisionResult)}°";
  }

  void calcBangKnowAcatBcatChypo() {
    bAngleD = AppConvert.toDegree(acos(
        (pow(bSideD, 2) + pow(cSideD, 2) - pow(aSideD, 2)) /
            (2 * bSideD * cSideD)));
    bAngle.value =
        "${AppUtilsNumber.getFormatNumber(bAngleD, precisionResult)}°";
  }

  void calcChypoKnowAcatBcat() {
    cSideD = sqrt(pow(aSideD, 2) + pow(bSideD, 2));
    cSide.value = AppUtilsNumber.getFormatNumber(cSideD, precisionResult);
  }

  void calcBcatKnowChypAcat() {
    bSideD = sqrt(pow(cSideD, 2) - pow(aSideD, 2));
    bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcAcatKnowChypBcat() {
    aSideD = sqrt(pow(cSideD, 2) - pow(bSideD, 2));
    aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcBcatKnowAcatAang() {
    bSideD = aSideD * tan(AppConvert.toRadian(aAngleD));
    bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcBcatKnowAcatBang() {
    bSideD = aSideD / tan(AppConvert.toRadian(bAngleD));
    bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcAcatKnowBcatAang() {
    aSideD = bSideD / tan(AppConvert.toRadian(aAngleD));
    aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcAangKnowHheiAcat() {
    aAngleD = AppConvert.toDegree(asin(hHeightD / aSideD));
    aAngle.value =
        "${AppUtilsNumber.getFormatNumber(aAngleD, precisionResult)}°";
  }

  void calcBangKnowHheibcat() {
    bAngleD = AppConvert.toDegree(asin(hHeightD / bSideD));
    bAngle.value =
        "${AppUtilsNumber.getFormatNumber(bAngleD, precisionResult)}°";
  }

  void calcAcatKnowBcatBang() {
    aSideD = bSideD * tan(AppConvert.toRadian(bAngleD));
    aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcBcatKnowChypKcomp() {
    bSideD = sqrt(cSideD * kCompCsideD);
    bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcAcatKnowChypMcomp() {
    aSideD = sqrt(cSideD * mCompCsideD);
    aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcHheiKnowBcatKcomp() {
    hHeightD = sqrt(pow(bSideD, 2) - pow(kCompCsideD, 2));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcHheiKnowBcatMcomp() {
    hHeightD = sqrt(pow(bSideD, 2) - pow(mCompCsideD, 2));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcHheiKnowAcatMcomp() {
    hHeightD = sqrt(pow(aSideD, 2) - pow(mCompCsideD, 2));
    hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);
  }

  void calcBangKnowHheiBcat() {
    // ok
    bAngleD = AppConvert.toDegree(asin(hHeightD / bSideD));
    bAngle.value =
        "${AppUtilsNumber.getFormatNumber(bAngleD, precisionResult)}°";
  }

  void calcAangKnowHheiMcomp() {
    aAngleD = AppConvert.toDegree(atan(hHeightD / mCompCsideD));
    aAngle.value =
        "${AppUtilsNumber.getFormatNumber(aAngleD, precisionResult)}°";
  }

  void calcBangKnowHheiKcomp() {
    bAngleD = AppConvert.toDegree(atan(hHeightD / kCompCsideD));
    bAngle.value =
        "${AppUtilsNumber.getFormatNumber(bAngleD, precisionResult)}°";
  }

  void calcAcatKnowHheiAang() {
    aSideD = hHeightD / (sin(AppConvert.toRadian(aAngleD)));
    aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);
  }

  void calcBcatKnowHheiBang() {
    bSideD = hHeightD / (sin(AppConvert.toRadian(bAngleD)));
    bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);
  }

  void calcMcompKnowChypKcomp() {
    mCompCsideD = cSideD - kCompCsideD;
    mCompCside.value =
        AppUtilsNumber.getFormatNumber(mCompCsideD, precisionResult);
  }

  void calcKcompKnowChypMcomp() {
    kCompCsideD = cSideD - mCompCsideD;
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
    area.value =
        AppUtilsNumber.getFormatNumber(0.5 * aSideD * bSideD, precisionResult);
  }

  void calcPerimKnowAcatBcatChyp() {
    perimeter.value = AppUtilsNumber.getFormatNumber(
        aSideD + bSideD + cSideD, precisionResult);
  }

  void calcSubResultKnowAsideBsideCsideAangl() async {
    calcYsPointKnowCsideAang();
    calcXsPointKnowAsideCsideAang();
    calcMedianKnowAsideBsideCside();
    calcBisectorKnowAsideBsideCside();
    //внут круг
    calcRIncenterKnowAsideBsideCside();
    //внеш круг
    calcRCircumCenterKnowChypo();
    calcXSRCircumCenterKnowAside();
    calcYSrIncenter();
    //last
    calcXSrIncenterKnowAsideAanglBangl();
    calcYSRCircumCenterKnowRradAside();
  }

  void calcXsPointKnowAsideCsideAang() {
    xSPointD = aSideD / 3;

    xSPoint.value = AppUtilsNumber.getFormatNumber(xSPointD, precisionResult);
  }

  void calcYsPointKnowCsideAang() {
    ySPointD = bSideD / 3;
    ySPoint.value = AppUtilsNumber.getFormatNumber(ySPointD, precisionResult);
  }

  void calcMedianKnowAsideBsideCside() {
    mAd =
        0.5 * (sqrt(2 * pow(cSideD, 2) + 2 * pow(bSideD, 2) - pow(aSideD, 2)));
    mBd =
        0.5 * (sqrt(2 * pow(cSideD, 2) + 2 * pow(aSideD, 2) - pow(bSideD, 2)));
    mCd =
        0.5 * (sqrt(2 * pow(aSideD, 2) + 2 * pow(bSideD, 2) - pow(cSideD, 2)));

    mA.value = AppUtilsNumber.getFormatNumber(mAd, precisionResult);
    mB.value = AppUtilsNumber.getFormatNumber(mBd, precisionResult);
    mC.value = AppUtilsNumber.getFormatNumber(mCd, precisionResult);
  }

  void calcBisectorKnowAsideBsideCside() {
    lCd = (sqrt(aSideD *
            bSideD *
            (cSideD + bSideD + aSideD) *
            (aSideD + bSideD - cSideD))) /
        (aSideD + bSideD);
    lBd = (sqrt(cSideD *
            aSideD *
            (cSideD + bSideD + aSideD) *
            (cSideD + aSideD - bSideD))) /
        (cSideD + aSideD);
    lAd = (sqrt(cSideD *
            bSideD *
            (cSideD + bSideD + aSideD) *
            (cSideD + bSideD - aSideD))) /
        (cSideD + bSideD);
    lA.value = AppUtilsNumber.getFormatNumber(lAd, precisionResult);
    lB.value = AppUtilsNumber.getFormatNumber(lBd, precisionResult);
    lC.value = AppUtilsNumber.getFormatNumber(lCd, precisionResult);
  }

  void calcRIncenterKnowAsideBsideCside() {
    double m = 0;

    m = (aSideD + bSideD + cSideD) / 2;

    rd = sqrt(((m - aSideD) * (m - bSideD) * (m - cSideD)) / m);

    rInscribed.value = AppUtilsNumber.getFormatNumber(rd, precisionResult);
  }

  void calcRCircumCenterKnowChypo() {
    // Rd = bSideD / 2 * (sin(AppConvert.toRadian(aAngleD)));
    Rd = cSideD / 2;
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
    xrd = (tan(AppConvert.toRadian(aAngleD / 2))) *
        aSideD /
        (tan(AppConvert.toRadian(90 / 2)) +
            tan(AppConvert.toRadian(aAngleD / 2)));

    xr.value = AppUtilsNumber.getFormatNumber(xrd, precisionResult);
  }

  void calcYSRCircumCenterKnowRradAside() {
    yRd = sqrt(pow(Rd, 2) - (pow(aSideD, 2) / 4));

    yR.value = AppUtilsNumber.getFormatNumber(yRd, precisionResult);
  }

  void calculate() {
    if (isOnlyOneParamEmpty()) return;
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
    param1 = RightTriangle.aSide;
    param2 = RightTriangle.bSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcChypoKnowAcatBcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // aCat cHyp ==OK
    // ==========================================
    param1 = RightTriangle.aSide;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcBcatKnowChypAcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // aCat aAng ==OK
    // ==========================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.aSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangleKnowAang();
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // aCat bAng ==OK
    // ==========================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.aSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcBcatKnowAcatBang();
      calcChypoKnowAcatBcat();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // aCat mSideC ==OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.aSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcHheiKnowAcatMcomp();
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcChypoKnowAcatBcat();
      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // aCat hHeight ==OK
    //================================================
    param1 = RightTriangle.hHeight;
    param2 = RightTriangle.aSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }
    // ==========================================
    // bCat cHyp ==OK
    // ==========================================
    param1 = RightTriangle.bSide;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcAcatKnowChypBcat();
      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // bCat aAng ==OK
    // ==========================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.bSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcAcatKnowBcatAang();
      calcChypoKnowAcatBcat();
      calcBangleKnowAang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // bCat bAng ==OK
    // ==========================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.bSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcAcatKnowBcatBang();
      calcChypoKnowAcatBcat();
      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // bCat kSideC ==OK
    // ==========================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.bSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcHheiKnowBcatKcomp();
      calcBangKnowHheiBcat();
      calcAangKnowBang();
      calcAcatKnowBcatAang();

      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }
    // ==========================================
    // bCat hHeight ==OK
    // ==========================================
    param1 = RightTriangle.bSide;
    param2 = RightTriangle.hHeight;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangKnowHheibcat();
      calcAangKnowBang();
      calcAcatKnowBcatAang();

      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }
    // ==========================================
    // cHyp aAng ==OK
    // ==========================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      aSideD = cSideD * cos(AppConvert.toRadian(aAngleD));
      aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);

      bSideD = cSideD * sin(AppConvert.toRadian(aAngleD));
      bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);

      calcBangleKnowAang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    // ==========================================
    // cHyp bAng ==OK
    // ==========================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      aSideD = cSideD * sin(AppConvert.toRadian(bAngleD));
      aSide.value = AppUtilsNumber.getFormatNumber(aSideD, precisionResult);

      bSideD = cSideD * cos(AppConvert.toRadian(bAngleD));
      bSide.value = AppUtilsNumber.getFormatNumber(bSideD, precisionResult);

      calcAangKnowBang();

      calchHeightKnowAcatAangl();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // cHyp mSideC ==OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcKcompKnowChypMcomp();
      calcAcatKnowChypMcomp();
      calcHheiKnowAcatMcomp();
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // cHyp kSideC ==OK
    //================================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      calcMcompKnowChypKcomp();
      calcAcatKnowChypMcomp();
      calcHheiKnowAcatMcomp();
      calcAangKnowHheiAcat();
      calcBangleKnowAang();
      calcBcatKnowAcatAang();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // aAng mSideC ==OK
    //================================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.mCompCside;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangleKnowAang();
      calchHeightKnowAangMcomp();

      calcAcatKnowHheiAang();

      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // aAng kSideC ==OK
    //================================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.kCompCside;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangleKnowAang();
      calchHeightKnowBangKcomp();

      calcAcatKnowHheiAang();

      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // aAng hHeight ==OK
    //================================================
    param1 = RightTriangle.aAngle;
    param2 = RightTriangle.hHeight;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangleKnowAang();
      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }
    //================================================
    // bAng kSideC ==OK
    //================================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.kCompCside;
    if (isAvailableTwoParams(param1, param2)) {
      calcAangKnowBang();
      calchHeightKnowBangKcomp();
      calcAcatKnowHheiAang();
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // bAng mSideC ==OK
    //================================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.mCompCside;
    if (isAvailableTwoParams(param1, param2)) {
      calcAangKnowBang();
      calchHeightKnowAangMcomp();
      calcAcatKnowHheiAang();
      calcBcatKnowAcatAang();
      calcChypoKnowAcatBcat();
      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // bAng hHeight ==OK
    //================================================
    param1 = RightTriangle.bAngle;
    param2 = RightTriangle.hHeight;
    if (isAvailableTwoParams(param1, param2)) {
      calcAangKnowBang();

      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();
      calcMKCompCsideKnowAcatAangChypo();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }
    //================================================
    // mSideC kSideC =OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.kCompCside;
    if (isAvailableTwoParams(param1, param2)) {
      hHeightD = sqrt(mCompCsideD * kCompCsideD);
      hHeight.value = AppUtilsNumber.getFormatNumber(hHeightD, precisionResult);

      cSideD = kCompCsideD + mCompCsideD;
      cSide.value = AppUtilsNumber.getFormatNumber(cSideD, precisionResult);

      calcAcatKnowChypMcomp();
      calcBcatKnowChypKcomp();

      calcBangKnowBcatChypo();
      calcAangKnowBang();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // mSideC hHeight ==OK
    //================================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.hHeight;
    if (isAvailableTwoParams(param1, param2)) {
      calcAangKnowHheiMcomp();
      calcBangleKnowAang();
      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();

      calcKcompKnowChypMcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // kSideC hHeight ==OK
    //================================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.hHeight;
    if (isAvailableTwoParams(param1, param2)) {
      calcBangKnowHheiKcomp();
      calcAangKnowBang();
      calcBcatKnowHheiBang();
      calcAcatKnowHheiAang();
      calcChypoKnowAcatBcat();

      calcMcompKnowChypKcomp();

      calcAreaKnowAcatBcat();
      calcPerimKnowAcatBcatChyp();
      calcSubResultKnowAsideBsideCsideAangl();
    }

    //================================================
    // TODO  cHyp hHeight //not found formula
    //================================================
    param1 = RightTriangle.hHeight;
    param2 = RightTriangle.cSide;
    if (isAvailableTwoParams(param1, param2)) {
      isNotFormula = true;
    }

    // ==========================================
    // bCat mSideC // not found formula
    // ==========================================
    param1 = RightTriangle.mCompCside;
    param2 = RightTriangle.bSide;
    if (isAvailableTwoParams(param1, param2)) {
      isNotFormula = true;
    }
    //================================================
    // aCat kSideC //не могу найти формулу
    //================================================
    param1 = RightTriangle.kCompCside;
    param2 = RightTriangle.aSide;
    if (isAvailableTwoParams(param1, param2)) {
      isNotFormula = true;
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
    if (ValidationUtils.isNumberNanAndInfinity(bSideD)) {
      bSide.value = startLengthValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(cSideD)) {
      cSide.value = startLengthValue;
      isNan = true;
    }

    if (ValidationUtils.isNumberNanAndInfinity(hHeightD)) {
      hHeight.value = startLengthValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(mCompCsideD)) {
      mCompCside.value = startLengthValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(kCompCsideD)) {
      kCompCside.value = startLengthValue;
      isNan = true;
    }

    if (ValidationUtils.isNumberNanAndInfinity(aAngleD)) {
      aAngle.value = startAngleValue;
      isNan = true;
    }
    if (ValidationUtils.isNumberNanAndInfinity(bAngleD)) {
      bAngle.value = startAngleValue;
      isNan = true;
    }
    return isNan;
  }

  void moveEmptyValueToStartInParameters() {
    activeParamMap.addAll(AppUtilsMap.moveValue(
            oldMap: activeParamMap,
            moveValue: RightTriangle.empty,
            isPositionStart: true)
        .cast<int, RightTriangle>());
  }

  void moveValueToEndInParameters(var value) {
    activeParamMap.addAll(AppUtilsMap.moveValue(
            oldMap: activeParamMap, moveValue: value, isPositionStart: false)
        .cast<int, RightTriangle>());
  }

// если значение при удалении равно 0 то обнуляем активный параметр
  bool isInputStartValue() {
    bool activeInput;
    String valueActiveInput;

    activeInput = isaSide.value;
    valueActiveInput = aSide.value;
    RightTriangle oldValue;
    var newValue = RightTriangle.empty;

    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = RightTriangle.aSide;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }

    activeInput = isbSide.value;
    valueActiveInput = bSide.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = RightTriangle.bSide;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }
    activeInput = iscSide.value;
    valueActiveInput = cSide.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = RightTriangle.cSide;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }

    activeInput = ishHeight.value;
    valueActiveInput = hHeight.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = RightTriangle.hHeight;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }
    activeInput = ismCompCside.value;
    valueActiveInput = mCompCside.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = RightTriangle.mCompCside;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }

    activeInput = iskCompCside.value;
    valueActiveInput = kCompCside.value;
    if (activeInput && valueActiveInput == startLengthValue) {
      oldValue = RightTriangle.kCompCside;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }

    activeInput = isaAngle.value;
    valueActiveInput = aAngle.value;
    if (activeInput && valueActiveInput == startAngleValue) {
      oldValue = RightTriangle.aAngle;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }

    activeInput = isbAngle.value;
    valueActiveInput = bAngle.value;
    if (activeInput && valueActiveInput == startAngleValue) {
      oldValue = RightTriangle.bAngle;

      activeParamMap.value = AppUtilsMap.updateValues(
              oldMap: activeParamMap, oldValue: oldValue, newValue: newValue)
          .cast<int, RightTriangle>();

      return true;
    }

    return false;
  }

  void setActiveParam() {
    log.v('1 ${activeParamMap[1]} 2 ${activeParamMap[2]}  start active param');

    RightTriangle paramActive = RightTriangle.empty;

    if (isInputStartValue()) return;

    if (isaSide.value) {
      paramActive = RightTriangle.aSide;
      paramLastLenght = RightTriangle.aSide;
    } else if (isbSide.value) {
      paramActive = RightTriangle.bSide;
      paramLastLenght = RightTriangle.bSide;
    } else if (iscSide.value) {
      paramActive = RightTriangle.cSide;
      paramLastLenght = RightTriangle.cSide;
    } else if (ishHeight.value) {
      paramActive = RightTriangle.hHeight;
      paramLastLenght = RightTriangle.hHeight;
    } else if (ismCompCside.value) {
      paramActive = RightTriangle.mCompCside;
      paramLastLenght = RightTriangle.mCompCside;
    } else if (iskCompCside.value) {
      paramActive = RightTriangle.kCompCside;
      paramLastLenght = RightTriangle.kCompCside;
    } else if (isaAngle.value) {
      paramActive = RightTriangle.aAngle;
    } else if (isbAngle.value) {
      paramActive = RightTriangle.bAngle;
    }
    moveEmptyValueToStartInParameters();
    //если уже есть данный параметр переместить его наверх
    if (isAvailableOneParam(paramActive)) {
      moveValueToEndInParameters(paramActive);
      return;
    }
    //если последний параметр похож на активный
    if (activeParamMap[2] == paramActive) return;

    if (activeParamMap[2] != RightTriangle.empty) {
      activeParamMap[1] = activeParamMap[2]!;
    }

    activeParamMap[2] = paramActive;
  }

  bool isAvailableOneParam(
    RightTriangle param1,
  ) {
    if (activeParamMap.containsValue(param1)) {
      return true;
    }
    return false;
  }

  bool isAvailableTwoParams(
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
    double result = 0.0;

    log.w('start showMessage');

    if (isNotFormula) {
      log.w('isNotFormula');
      showSnack(TranslateHelper.messageFormulaNotFound);
      isNotFormula = false;
      return;
    }

    // если активные углы то сбрасываем один выбор до последнй длины
    if (isActiveParamAngles()) {
      showSnack(TranslateHelper.messageEnterAnyLength);
      return;
    }

    // если есть пустой параметр
    if (isOnlyTwoParamEmpty()) {
      showSnack(TranslateHelper.enterTwoParameters);
      return;
    }
    if (isOnlyOneParamEmpty()) {
      showSnack(TranslateHelper.enterOneParameters);
      return;
    }

    if (isAvailableTwoParams(
      RightTriangle.kCompCside,
      RightTriangle.bSide,
    )) {
      if (iskCompCside.value) {
        result = bSideD;
        if (!(kCompCsideD < result)) {
          showSnack(
              '${TranslateHelper.component} k ${TranslateHelper.must_be} < b = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (isbSide.value) {
        result = kCompCsideD;
        if (!(bSideD > result)) {
          showSnack(
              'Side b ${TranslateHelper.must_be} > k = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }

    if (isAvailableTwoParams(
      RightTriangle.mCompCside,
      RightTriangle.aSide,
    )) {
      if (isaSide.value) {
        result = mCompCsideD;
        if (!(aSideD > result)) {
          showSnack(
              '${TranslateHelper.side} a ${TranslateHelper.must_be} > m = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }

      if (ismCompCside.value) {
        result = aSideD;
        if (!(mCompCsideD < result)) {
          showSnack(
              '${TranslateHelper.component} m ${TranslateHelper.must_be} < a = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }
    if (isAvailableTwoParams(
      RightTriangle.mCompCside,
      RightTriangle.cSide,
    )) {
      if (iscSide.value) {
        result = mCompCsideD;
        if (!(cSideD > result)) {
          showSnack(
              '${TranslateHelper.side} с ${TranslateHelper.must_be} > m = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (ismCompCside.value) {
        result = cSideD;
        if (!(mCompCsideD < result)) {
          showSnack(
              '${TranslateHelper.component} m ${TranslateHelper.must_be} < c = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }

    if (isAvailableTwoParams(
      RightTriangle.kCompCside,
      RightTriangle.cSide,
    )) {
      if (iscSide.value) {
        result = kCompCsideD;
        if (!(cSideD > result)) {
          showSnack(
              '${TranslateHelper.side} с ${TranslateHelper.must_be} > k = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (iskCompCside.value) {
        result = cSideD;
        if (!(kCompCsideD < result)) {
          showSnack(
              '${TranslateHelper.component} k ${TranslateHelper.must_be} < c = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }

    if (isAvailableTwoParams(
      RightTriangle.hHeight,
      RightTriangle.aSide,
    )) {
      if (isaSide.value) {
        result = hHeightD;
        if (!(aSideD > result)) {
          showSnack(
              '${TranslateHelper.side} a ${TranslateHelper.must_be} > h = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (ishHeight.value) {
        result = aSideD;
        if (!(hHeightD < result)) {
          showSnack(
              '${TranslateHelper.height} h ${TranslateHelper.must_be} < a = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }
    if (isAvailableTwoParams(
      RightTriangle.hHeight,
      RightTriangle.bSide,
    )) {
      if (isbSide.value) {
        result = hHeightD;
        if (!(bSideD > result)) {
          showSnack(
              '${TranslateHelper.side} b ${TranslateHelper.must_be} > h = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (ishHeight.value) {
        result = bSideD;
        if (!(hHeightD < result)) {
          showSnack(
              '${TranslateHelper.height} h ${TranslateHelper.must_be} < b = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }
    if (isAvailableTwoParams(
      RightTriangle.hHeight,
      RightTriangle.cSide,
    )) {
      if (iscSide.value) {
        result = hHeightD * 2;
        if (!(cSideD >= result)) {
          showSnack(
              '${TranslateHelper.side} c ${TranslateHelper.must_be} ≥ 2h = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (ishHeight.value) {
        result = cSideD / 2;
        if (!(hHeightD <= result)) {
          showSnack(
              '${TranslateHelper.height} h ${TranslateHelper.must_be} ≤ с/2 = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }
//если гипотенуза меньше
    if (isAvailableTwoParams(
      RightTriangle.aSide,
      RightTriangle.cSide,
    )) {
      if (isaSide.value) {
        result = cSideD;
        if (!(aSideD < result)) {
          showSnack(
              '${TranslateHelper.side} a ${TranslateHelper.must_be} < c = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (iscSide.value) {
        result = aSideD;
        if (!(cSideD > result)) {
          showSnack(
              '${TranslateHelper.side} c ${TranslateHelper.must_be} > a = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }

//если гипотенуза меньше
    if (isAvailableTwoParams(
      RightTriangle.bSide,
      RightTriangle.cSide,
    )) {
      if (isbSide.value) {
        result = cSideD;
        if (!(bSideD < result)) {
          showSnack(
              '${TranslateHelper.side} b ${TranslateHelper.must_be} < c = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
      if (iscSide.value) {
        result = bSideD;
        if (!(cSideD > result)) {
          showSnack(
              '${TranslateHelper.side} c ${TranslateHelper.must_be} > b = ${AppUtilsNumber.getFormatNumber(result, precisionResult)}');
          return;
        }
      }
    }

//если угол больше 90
    if (90 <= aAngleD || 90 <= bAngleD) {
      showSnack(TranslateHelper.messageAngleOver90);

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

  bool isAngleOver90(KeySymbol keySymbol) {
    String newInput = keySymbol.value;
    initValue();
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

  bool isOnlyOneParamEmpty() {
    if (activeParamMap[1] == RightTriangle.empty &&
            activeParamMap[2] != RightTriangle.empty ||
        activeParamMap[2] == RightTriangle.empty &&
            activeParamMap[1] != RightTriangle.empty) {
      return true;
    }
    return false;
  }

  bool isOnlyTwoParamEmpty() {
    if (activeParamMap[1] == RightTriangle.empty &&
        activeParamMap[2] == RightTriangle.empty) {
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

  bool ifMaxNumberEnter() {
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

  void nextElement() {
    // переключение вперед между widgets backspace

    _isNext(true);
  }

  void restartActiveParamIfZeroValue() {
    if (activeParamMap[1] == RightTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.aSide &&
        aSide.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }

    if (activeParamMap[1] == RightTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.bSide &&
        bSide.value == startLengthValue) {
      activeParamMap[2] = RightTriangle.empty;
    }

    if (activeParamMap[1] == RightTriangle.cSide &&
        cSide.value == startLengthValue) {
      activeParamMap[1] = RightTriangle.empty;
    }

    if (activeParamMap[2] == RightTriangle.cSide &&
        cSide.value == startLengthValue) {
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
    if (isaSide.value) {
      aSide.value = startLengthValue;
    } else if (isbSide.value) {
      bSide.value = startLengthValue;
    } else if (iscSide.value) {
      cSide.value = startLengthValue;
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
    log.v(
        '1 ${activeParamMap[1]} 2 ${activeParamMap[2]}  longBackspace active param  ');

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
    } else if (isbSide.value) {
      oldInput = bSide.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        bSideD = 0;

        newInput = startLengthValue;

        resetNotActiveValue();
      }
      bSide.value = newInput;
    } else if (iscSide.value) {
      oldInput = cSide.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        cSideD = 0;

        newInput = startLengthValue;

        resetNotActiveValue();
      }
      cSide.value = newInput;
    } else if (iskCompCside.value) {
      oldInput = kCompCside.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        kCompCsideD = 0;

        newInput = startLengthValue;

        resetNotActiveValue();
      }
      kCompCside.value = newInput;
    } else if (ismCompCside.value) {
      oldInput = mCompCside.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      //если пусто устанавливаем стартовое значение
      if (newInput.isEmpty) {
        mCompCsideD = 0;

        newInput = startLengthValue;

        resetNotActiveValue();
      }
      mCompCside.value = newInput;
    } else if (ishHeight.value) {
      oldInput = hHeight.value;
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        hHeightD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      hHeight.value = newInput;
    } else if (isaAngle.value) {
      oldInput = aAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);

      if (newInput.isEmpty) {
        aAngleD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      aAngle.value = '$newInput°';
    } else if (isbAngle.value) {
      oldInput = bAngle.value;

      if (AppUtilsString.getLastCharacter(oldInput) == '°') {
        oldInput = AppUtilsString.removeLastCharacter(oldInput);
      }
      newInput = AppUtilsString.removeLastCharacter(oldInput);
      if (newInput.isEmpty) {
        bAngleD = 0;
        newInput = startLengthValue;
        resetNotActiveValue();
      }
      bAngle.value = '$newInput°';
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
    bSide.value = startLengthValue;
    cSide.value = startLengthValue;
    hHeight.value = startLengthValue;
    kCompCside.value = startLengthValue;
    mCompCside.value = startLengthValue;
    aAngle.value = startAngleValue;
    bAngle.value = startAngleValue;

    perimeter.value = startLengthValue;
    area.value = startLengthValue;
    xSPoint.value = startLengthValue;
    ySPoint.value = startLengthValue;

    hHeightD = 0;

    aAngleD = 0;
    bAngleD = 0;
    areaD = 0;
    perimeterD = 0;

    aSideD = bSideD =
        cSideD = hHeightD = kCompCsideD = mCompCsideD = bAngleD = aAngleD = 0;

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

    if (!isAvailableOneParam(RightTriangle.aSide)) {
      aSide.value = startLengthValue;
      aSideD = 0;
    }
    if (!isAvailableOneParam(RightTriangle.bSide)) {
      bSide.value = startLengthValue;
      bSideD = 0;
    }
    if (!isAvailableOneParam(RightTriangle.cSide)) {
      cSide.value = startLengthValue;
      cSideD = 0;
    }
    if (!isAvailableOneParam(RightTriangle.hHeight)) {
      hHeight.value = startLengthValue;
      hHeightD = 0;
    }

    if (!isAvailableOneParam(RightTriangle.mCompCside)) {
      mCompCside.value = startLengthValue;
      mCompCsideD = 0;
    }

    if (!isAvailableOneParam(RightTriangle.kCompCside)) {
      kCompCside.value = startLengthValue;
      kCompCsideD = 0;
    }

    if (!isAvailableOneParam(RightTriangle.aAngle)) {
      aAngle.value = startAngleValue;
      aAngleD = 0;
    }
    if (!isAvailableOneParam(RightTriangle.bAngle)) {
      bAngle.value = startAngleValue;
      bAngleD = 0;
    }
  }

  void _isNext(bool isNext) {
    if (isNext) {
      if (isaSide.value) {
        isaAngle.value = true;
        isaSide.value = false;
      } else if (isaAngle.value) {
        ishHeight.value = true;
        isaAngle.value = false;
      } else if (ishHeight.value) {
        ishHeight.value = false;
        isbAngle.value = true;
      } else if (isbAngle.value) {
        isbAngle.value = false;
        isbSide.value = true;
      } else if (isbSide.value) {
        isbSide.value = false;
        iskCompCside.value = true;
      } else if (iskCompCside.value) {
        iskCompCside.value = false;
        iscSide.value = true;
      } else if (iscSide.value) {
        iscSide.value = false;
        ismCompCside.value = true;
      } else if (ismCompCside.value) {
        ismCompCside.value = false;
        isaSide.value = true;
      }
    } else {
      if (isaSide.value) {
        ismCompCside.value = true;
        isaSide.value = false;
      } else if (ismCompCside.value) {
        iscSide.value = true;
        ismCompCside.value = false;
      } else if (iscSide.value) {
        iscSide.value = false;
        iskCompCside.value = true;
      } else if (iskCompCside.value) {
        iskCompCside.value = false;
        isbSide.value = true;
      } else if (isbSide.value) {
        isbSide.value = false;
        isbAngle.value = true;
      } else if (isbAngle.value) {
        isbAngle.value = false;
        ishHeight.value = true;
      } else if (ishHeight.value) {
        ishHeight.value = false;
        isaAngle.value = true;
      } else if (isaAngle.value) {
        isaAngle.value = false;
        isaSide.value = true;
      }
    }
  }

  @override
  void onClose() {
    clearAll();
    super.onClose();
  }
}
