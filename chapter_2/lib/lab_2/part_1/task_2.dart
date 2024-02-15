import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
2. Пользователь вводит с клавиатуры 2 значения val1, val2. Посчитайте
их произведение и выведите полученный результат в терминал.
""", execute);

void execute(List<String> arguments) {
  num val1, val2;

  stdout.write("Введите значение val1: ");
  String? val1Raw = stdin.readLineSync();

  if (val1Raw != null && num.tryParse(val1Raw) != null) {
    val1 = num.parse(val1Raw);
  } else {
    return ClientMessage().errorInputData();
  }

  stdout.write("Введите значение val2: ");
  String? val2Raw = stdin.readLineSync();

  if (val2Raw != null && num.tryParse(val2Raw) != null) {
    val2 = num.parse(val2Raw);
  } else {
    return ClientMessage().errorInputData();
  }

  stdout.writeln("Произведение: ${val1 * val2}");
}
