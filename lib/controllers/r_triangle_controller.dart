import 'package:calc_triangle/pages/r_triangle_page.dart';
import 'package:calc_triangle/utils/key_symbol.dart';
import 'package:get/get.dart';

class RtriangleController extends GetxController {
  var inputSymbols = ''.obs;
  var selectedElement = RighTrianglePage.startElement.obs;
  RxInt selectedIndex = 0.obs;

  void addKey(KeySymbol keySymbol) {
    inputSymbols.value = inputSymbols.value + keySymbol.value;
  }

  void nextElement() {
    int oldIndex = selectedElement.value.index;
    int widgetlength = RighTrianglePage.textSupportList.length;
    int newIndex = oldIndex++;

    print('oldIndex $oldIndex');
    print('newIndex $newIndex');

//обнуляем если превышает кол widgets
    if (newIndex > widgetlength - 1) {
      newIndex = RighTrianglePage.startElement.index;
    }
// устанавливаем выбранный элемент фигуры
    selectedElement.value = RightTriangelElement.values[newIndex];
  }
}
