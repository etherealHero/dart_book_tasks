class MyString {
  final List<String> _str;

  MyString(String str) : _str = str.split("");

  MyString operator +(Object other) {
    if (other is! MyString) {
      throw ArgumentError.value(
        other.runtimeType,
        "Ожидался экземпеляр MyString() к конкатенации",
      );
    }

    return MyString(_str.join("") + other._str.join(""));
  }

  @override
  bool operator ==(Object other) {
    if (other is! MyString) return false;

    return _str.join("") == other._str.join("");
  }

  bool operator >(Object other) => _compareMyString(this, other);
  bool operator <(Object other) => _compareMyString(other, this);

  String operator [](int index) => switch (_str.asMap().containsKey(index)) {
        true => _str[index],
        false => throw RangeError.index(
            index,
            _str,
            "Индекс не входит в диапазон",
          ),
      };

  @override
  String toString() {
    return _str.join("");
  }

  @override
  int get hashCode => _str.hashCode;

  bool _compareMyString(Object firstMyString, Object secondMyString) {
    if (secondMyString is! MyString || firstMyString is! MyString) {
      throw ArgumentError.value(
        secondMyString,
        "Неверный тип операнда. "
        "Ожидался операнд типа MyString()",
      );
    }

    if (firstMyString._str.length > secondMyString._str.length) return true;
    if (firstMyString._str.length < secondMyString._str.length) return false;

    for (var i = 0; i < firstMyString._str.length; i++) {
      if (firstMyString[i].compareTo(secondMyString._str[i]) > 0) return true;
      if (firstMyString[i].compareTo(secondMyString._str[i]) < 0) return false;
    }

    return false;
  }
}
