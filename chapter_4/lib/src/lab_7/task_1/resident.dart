class Person {
  final String name;

  static final _personMap = <String, Person>{};

  Person._fromName(this.name);

  factory Person(String name) {
    String ident = name.toLowerCase();
    return _personMap.putIfAbsent(ident, () => Person._fromName(name));
  }

  @override
  String toString() => name;
}
