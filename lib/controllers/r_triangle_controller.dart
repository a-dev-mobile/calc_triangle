import 'package:calc_triangle/utils/key_symbol.dart';
import 'package:get/get.dart';

class RtriangleController extends GetxController {
  static RtriangleController get to => Get.find(); // add this line

  var inputSymbols = "".obs;

  var minSize = 0.0.obs;

  void addKey(KeySymbol keySymbol) {
    inputSymbols.value = keySymbol.value;
  }
}
