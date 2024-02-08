import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
1. Напишите приложение, позволяющее пользователю вводить Map<int,
String> и число А. Удалите все элементы с ключами, значения которых
кратны А и выведите в терминал полученный результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите ключи через пробел: ");
  List<String> keysRaw = stdin.readLineSync()!.split(' ');
  bool keysContainsNull = keysRaw.map((e) => int.tryParse(e)).contains(null);

  if (keysContainsNull) return ClientMessage().errorInputData();

  List<int> keys = keysRaw.map((e) => int.parse(e)).toList();

  if (keys.isEmpty) return ClientMessage().errorInputData();

  stdout.write("Введите ключи через пробел: ");
  String? valuesRaw = stdin.readLineSync();
  List<String> values = valuesRaw!.split(' ');

  if (values.isEmpty || values.length != keys.length) {
    return ClientMessage().errorInputData();
  }

  Map<int, String> map = Map.fromIterables(keys, values);

  stdout.write("Введите число А: ");
  String? numARaw = stdin.readLineSync();

  if (int.tryParse(numARaw!) == null) {
    return ClientMessage().errorInputData();
  }

  map.removeWhere((key, value) => key % int.parse(numARaw) == 0);
  print(map);
}
