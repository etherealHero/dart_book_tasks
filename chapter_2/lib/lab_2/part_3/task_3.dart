import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
9. Пользователь вводит с клавиатуры 2 значения (x и y). Определите в
какой четверти находится точка с полученной координатой и выведите ее
в терминал (1, 2, 3 или 4). Реализуйте 2 версии программы с разными
подходами (if и switch).
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите x и y через пробел: ");
  String? coordRaw = stdin.readLineSync();

  if (coordRaw == null ||
      coordRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return ClientMessage().errorInputData();
  }

  var [int x, int y] =
      coordRaw.split(" ").toList().map((e) => int.parse(e)).toList();

  if (x >= 0 && y >= 0) {
    stdout.writeln("I");
  } else if (x < 0 && y >= 0) {
    stdout.writeln("II");
  } else if (x < 0 && y < 0) {
    stdout.writeln("III");
  } else if (x > 0 && y < 0) {
    stdout.writeln("IV");
  }

  stdout.writeln(switch ((x, y)) {
    (int x, int y) when x >= 0 && y >= 0 => "I",
    (int x, int y) when x < 0 && y >= 0 => "II",
    (int x, int y) when x < 0 && y < 0 => "III",
    (int x, int y) when x > 0 && y < 0 => "IV",
    _ => "Неверные входные данные"
  });
}
