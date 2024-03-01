import 'dart:io';
import '/src/shared.dart';

var task = Task("""
15. Пользователь вводит с клавиатуры число вещественное число,
представляющее собой значение температуры в градусах Цельсия.
Напишите функцию для его перевода в градусы Фаренгейта. Полученный
результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите цельсий: ");
  String? celsiusRaw = stdin.readLineSync();

  if (celsiusRaw == null || num.tryParse(celsiusRaw) == null) {
    return stdmsg.raiseError();
  }

  num celsius = num.parse(celsiusRaw);

  stdout.writeln("Фаренгейты: ${convertToFahrenheit(celsius)}");
}

num convertToFahrenheit(num celsius) {
  return celsius * 9 / 5 + 32;
}
