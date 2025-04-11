import 'package:get/get.dart';

import 'languages/en.dart';
import 'languages/ru.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
    'en': en,
    'ru': ru,
  };
}
