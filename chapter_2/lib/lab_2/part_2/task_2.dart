import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
3. Пользователь вводит Map<int, String>. Используя шаблон выведите
его в терминал, если удовлетворяет следующим условиям: длина < 5,
имеется ключ со значением 999 или 666. Иначе выведите текст «Pattern no
matched».
""", execute);

void execute(List<String> arguments) {
  Map<int, String> map;

  stdout.write("Введите ключи мапы через пробел числами: ");
  String? keysRaw = stdin.readLineSync();

  if (keysRaw == null ||
      keysRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return ClientMessage().errorInputData();
  }

  stdout.write("Введите значения мапы через пробел числами: ");
  String? valuesRaw = stdin.readLineSync();

  if (valuesRaw == null ||
      valuesRaw.split(" ").length != keysRaw.split(" ").length) {
    return ClientMessage().errorInputData();
  }

  map = Map.fromIterables(
      keysRaw.split(" ").map((e) => int.parse(e)), valuesRaw.split(" "));

  if (map.keys.toList() case List<int> keys
      when keys.length < 5 && (keys.contains(999) || keys.contains(666))) {
    stdout.writeln(map);
  } else {
    stdout.writeln("Pattern no matched");
  }
}
