import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
6. Пользователь вводит Map<String, int>. Используя шаблон выведите
его в терминал, если удовлетворяет следующим условиям: имеется ключ со
значением «Key» и произведение всех хранимых значений больше 38.
Иначе выведите текст «Pattern no matched».
""", execute);

void execute(List<String> arguments) {
  Map<String, int> map;

  stdout.write("Введите ключи мапы через пробел числами: ");
  String? keysRaw = stdin.readLineSync();

  if (keysRaw == null || keysRaw.isEmpty) {
    return ClientMessage().errorInputData();
  }

  stdout.write("Введите значения мапы через пробел числами: ");
  String? valuesRaw = stdin.readLineSync();

  if (valuesRaw == null ||
      valuesRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return ClientMessage().errorInputData();
  }

  map = Map.fromIterables(
      keysRaw.split(" "), valuesRaw.split(" ").map((e) => int.parse(e)));

  if (map case {'Key': int num}
      when map.values.reduce((mult, _) => mult * num) > 38) {
    stdout.writeln(map);
  } else {
    stdout.writeln("Pattern no matched");
  }
}
