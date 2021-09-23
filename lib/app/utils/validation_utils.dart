class ValidationUtils {
  static bool isEmailValid(String email) {
    if ((email.trim().isEmpty)) {
      return false;
    }

    RegExp regExp = RegExp(
        r"^[\w!#$%&’*+/=?`{|}~^-]+(?:\.[\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]+$");
    return regExp.hasMatch(email);
  }

  static bool isTwoDecimalPoint(String text) {
    var i = text.split('.').length;
    if (i > 2) {
      return true;
    } else {
      return false;
    }
  }

  static bool isListNanAndInfinity(List<double> listDouble) {
    for (var item in listDouble) {
      if (isNumberNanAndInfinity(item)) {
        return true;
      }
    }
    return false;
  }

  static bool isNumberNanAndInfinity(double value) {
    if (value.isNaN || value.isInfinite) {
      return true;
    }
    return false;
  }

  static bool isMoreAccuracy(String value, int declaredAccuracy) {
    //если не содержит точку то возврат
    if (!value.contains('.')) return false;

    int i = value.length - (value.toString().indexOf('.') + 1);
    // logger.i('accuracy $i > $declaredAccuracy');

    if (i > declaredAccuracy) return true;

    return false;
  }

  static bool isValueNullOrEmpty(String value) {
    return (value.trim().isEmpty);
  }

  static bool isMobileNumberValid(String mobileNumber, int checkLength) {
    if ((mobileNumber.trim().isEmpty)) {
      return false;
    }

    return (mobileNumber.trim().length == checkLength);
  }
}
