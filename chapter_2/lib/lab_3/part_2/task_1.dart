/*
Примечание: для представления десятичного числа в двоичном
формате используйте метод .toRadixString(2) у переменной типа int.
Обратите внимание на то, что отрицательные значения хранятся в доп.
коде. В случае, если для вас тема битовых операций в новинку, можно
посмотреть мое видео на ютубе с примерами на Python и применить
полученные знания для решения задач на Dart
(https://youtu.be/HUTJvGyZask).
*/
import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
1. Пользователь вводит с клавиатуры положительное число. Определите,
установлен ли у него третий бит справа в 1. Если нет, то установите и
выведите полученный результат в двоичном формате в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите положительное число: ");
  String? numRaw = stdin.readLineSync();

  if (numRaw == null || int.tryParse(numRaw) == null) {
    return ClientMessage().errorInputData();
  }

  stdout.writeln(switch (int.parse(numRaw)) {
    int n when (n & 4) == 4 =>
      "Третий бит справа установлен в 1: ${n.toRadixString(2)}",
    int n when (n & 4) != 4 =>
      "Третий бит справа не установлен в 1, исправляем: ${(n | 4).toRadixString(2)}",
    _ => "Неверные входные данные"
  });
}
