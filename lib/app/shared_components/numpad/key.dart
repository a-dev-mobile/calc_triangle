import 'key_symbol.dart';

abstract class Keys {
  static KeySymbol empty = const KeySymbol('');
  static KeySymbol clearAll = const KeySymbol('C');
  static KeySymbol backspace = const KeySymbol('←');

  static KeySymbol next = const KeySymbol('↑');
  static KeySymbol prev = const KeySymbol('↓');
  static KeySymbol deg = const KeySymbol('°');
  static KeySymbol degMinSec = const KeySymbol('°′″');
  // static KeySymbol convert = const KeySymbol('°');
  static KeySymbol decimal = const KeySymbol('.');

  static KeySymbol zero = const KeySymbol('0');
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
}
