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
  stdout.write("");
}
