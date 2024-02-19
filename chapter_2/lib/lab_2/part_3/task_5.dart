import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
17. Пользователь вводит с клавиатуры значение температуры в градусах
Цельсия 36.6с или в градусах Фаренгейта 36.6f. Если температура была
введена в градусах Цельсия, то конвертируйте ее в градусы Фаренгейта,
либо наоборот и выведите полученный результат в терминал. Реализуйте 2
версии программы с разными подходами (if и switch).
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите темпиратуру: ");
  String? tempRaw = stdin.readLineSync();

  if (tempRaw == null || !tempRaw.contains(RegExp(r"\d+\.\d+[cf]"))) {
    return ClientMessage().errorInputData();
  }

  String temp = tempRaw;

  if (temp.endsWith("f")) {
    stdout
        .writeln((num.parse(temp.substring(0, temp.length - 1)) - 32) * 5 / 9);
  } else {
    stdout
        .writeln((num.parse(temp.substring(0, temp.length - 1)) * 9 / 5) + 32);
  }

  stdout.writeln(switch (temp) {
    String t when t.endsWith("f") =>
      (num.parse(temp.substring(0, temp.length - 1)) - 32) * 5 / 9,
    String t when t.endsWith("c") =>
      (num.parse(temp.substring(0, temp.length - 1)) * 9 / 5) + 32,
    _ => "Неверные входные данные"
  });
}
