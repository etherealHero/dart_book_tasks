import 'package:database_5_5/src/i_attribute.dart';

enum AcsessLevel {
  strudent('S'),
  teacher('T'),
  admin('A');

  final String text;
  const AcsessLevel(this.text);

  static AcsessLevel fromString(String value) {
    return switch (value) {
      'T' => AcsessLevel.teacher,
      'A' => AcsessLevel.admin,
      _ => AcsessLevel.strudent
    };
  }

  @override
  String toString() {
    return text;
  }
}

enum UserTableFields {
  id('id'),
  nickname('nickname'),
  yearOfBirth('yearOfBirth'),
  email('email'),
  phone('phone'),
  acsessLevel('acsessLevel'),
  passwordHash('passwordHash');

  final String text;
  const UserTableFields(this.text);

  @override
  String toString() {
    return text;
  }
}

class User implements IAttribute {
  final int _id;
  String _nickname;
  int _yearOfBirth;
  String _email;
  String _phone;
  AcsessLevel _acsessLevel;
  String _passwordHash;

  User({
    required int id,
    required String nickname,
    required int yearOfBirth,
    required String email,
    required String phone,
    required String acsessLevel,
    required String passwordHash,
  })  : _id = id,
        _nickname = nickname,
        _yearOfBirth = yearOfBirth,
        _email = email,
        _phone = phone,
        _acsessLevel = AcsessLevel.fromString(
          acsessLevel.toUpperCase(),
        ),
        _passwordHash = passwordHash;

  int get id => _id;
  String get nickname => _nickname;
  int get yearOfBirth => _yearOfBirth;
  String get email => _email;
  String get phone => _phone;
  AcsessLevel get acsessLevel => _acsessLevel;
  String get passwordHash => _passwordHash;

  @override
  bool change(String attribute, String value) {
    switch (attribute) {
      case '_nickname':
        _nickname = value;
      case '_yearOfBirth':
        _yearOfBirth = int.parse(value);
      case '_email':
        _email = value;
      case '_phone':
        _phone = value;
      case '_acsessLevel':
        _acsessLevel = AcsessLevel.fromString(value);
      case '_passwordHash':
        _passwordHash = value;
      default:
        return false;
    }
    return true;
  }

  @override
  bool check(String attribute, String value) {
    return switch (attribute) {
      'id' => _id == int.parse(value),
      'nickname' => _nickname == value,
      'yearOfBirth' => _yearOfBirth == int.parse(value),
      'email' => _email == value,
      'phone' => _phone == value,
      'acsessLevel' => _acsessLevel.text == value,
      'passwordHash' => _passwordHash == value,
      _ => false
    };
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    buffer.write('User(id: $_id, nickname: $_nickname), ');
    buffer.write('yearOfBirth: $_yearOfBirth, email: $_email, ');
    buffer.write('phone: $_phone, acsessLevel: $_acsessLevel, ');
    buffer.write('passwodHash: $_passwordHash), ');
    return buffer.toString();
  }
}
