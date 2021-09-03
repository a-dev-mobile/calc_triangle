import 'calculator_key.dart';

enum KeyType { function, operator, integer }

class KeySymbol {
  final String value;

  const KeySymbol(this.value);

  static final List<KeySymbol> _functions = [
    Keys.clear,
    Keys.backspase,
    Keys.toggleImage,
  ];
  static final List<KeySymbol> _operators = [
    Keys.next,
    Keys.prev,
  ];
  @override
  String toString() => value;

  bool get isOperator => _operators.contains(this);
  bool get isFunction => _functions.contains(this);
  bool get isInteger => !isOperator && !isFunction;

  KeyType get type => isFunction
      ? KeyType.function
      : (isOperator ? KeyType.operator : KeyType.integer);
}
