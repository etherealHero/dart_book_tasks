/*
Для возведения в степень и т.д. используйте библиотеку
dart:math, добавив в начало файла с кодом: «import
'dart:math';»;

Во всех заданиях необходимо предусмотреть проверку на
правильность вводимых данных с клавиатуры.
*/
import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
1. Пользователь вводит с клавиатуры 3 значения: val1, val2, val3. Найдите
их сумму и выведите полученный результат в терминал.
""", execute);

void execute(List<String> arguments) {
  num val1, val2, val3;

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

  stdout.write("Введите значение val3: ");
  String? val3Raw = stdin.readLineSync();

  if (val3Raw != null && num.tryParse(val3Raw) != null) {
    val3 = num.parse(val3Raw);
  } else {
    return ClientMessage().errorInputData();
  }

  stdout.writeln("Сумма: ${val1 + val2 + val3}");
}
