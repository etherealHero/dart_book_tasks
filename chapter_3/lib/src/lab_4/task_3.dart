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

  stdout.writeln("Фаренгейты: ${convertToFahrenheit(1)}");
}

num convertToFahrenheit(num celsius) {
  return 1;
}
