abstract class UtilsString {
  static String removeLastCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0, str.length - 1);
    }

    // print('old $str new $result');

    return result;
  }

  static String getLastCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(str.length - 1);
    }

    return result;
  }

  static String getFirstCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0);
    }

    return result;
  }

  static bool isTwoDecimal(String text) {
    var i = text.split('.').length;
    if (i > 2) {
      return true;
    } else {
      return false;
    }
  }

  static String addZeroIsFirstDecimal(String text) {
    if (UtilsString.getFirstCharacter(text) == '.') {
      return text = '0' + text;
    } else {
      return text;
    }
  }
}
