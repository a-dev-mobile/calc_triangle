import 'package:calc_triangle/app/constants/const_string.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';
import 'package:calc_triangle/app/utils/logger.dart';
import 'package:get/get.dart';

const int maxNumberStartCalcBeforeAd = 3;

class SelectShapeController extends GetxController {
  static SelectShapeController get to => Get.find<SelectShapeController>();

  int numberStartCalc = 0;
  bool isStartAd = false;
  void incrNumberStartCalc() {
    numberStartCalc = numberStartCalc + 1;
    log.i('numberStartCalc $numberStartCalc');
    //обнуляем счетчик
    isStartAd = false;
    if (numberStartCalc >= maxNumberStartCalcBeforeAd) {
      isStartAd = true;
      numberStartCalc = 0;
    }

    LocalStorage().setItemInt(ConstString.keyNumberStartCalc, numberStartCalc);
  }

  @override
  Future<void> onInit() async {
    //если первый запуск init or read from locale
    firstStartApp();

    super.onInit();
  }

  Future<void> firstStartApp() async {
    if (GlobalServ.to.isFirstStartApp) {
      LocalStorage().setItemInt(
        ConstString.keyNumberStartCalc,
        numberStartCalc,
      );
    } else {
      numberStartCalc = await LocalStorage().getItemInt(
        ConstString.keyNumberStartCalc,
      );
    }
  }
}
