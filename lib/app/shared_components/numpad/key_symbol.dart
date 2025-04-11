import 'key.dart';

enum KeyType { function, choice, integer, convert }

class KeySymbol {
  final String value;

  const KeySymbol(this.value);

  static final List<KeySymbol> _functions = <KeySymbol>[
    Keys.clearAll,
    Keys.backspace,
  ];
  static final List<KeySymbol> _choice = <KeySymbol>[Keys.next, Keys.prev];
  static final List<KeySymbol> _convert = <KeySymbol>[Keys.deg, Keys.degMinSec];
  @override
  String toString() => value;

  bool get isChoice => _choice.contains(this);

  bool get isFunction => _functions.contains(this);
  bool get isConvert => _convert.contains(this);

  bool get isInteger => !isChoice && !isFunction && !isConvert;

  KeyType get type =>
      isFunction
          ? KeyType.function
          : (isChoice
              ? KeyType.choice
              : (isConvert ? KeyType.convert : KeyType.integer));
}
