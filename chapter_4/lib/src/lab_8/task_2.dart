import 'dart:io';
import 'package:chapter_4/src/lab_8/task_2/mystring.dart';

import '/src/shared.dart';

var task = Task("""
9. Реализуйте класс MyString, представляющий строку, но хранящий ее
элементы в списке. Перегрузите операторы + для конкатенации строк.
Также перегрузите операторы ==, >, < для лексикографического сравнения
строк. Реализуйте доступ к символам строки по индексу.
""", execute);

void execute(List<String> arguments) {
  var str1 = MyString("lorem");
  var str2 = MyString("ipsum");
  var str3 = MyString("lorem");
  var str4 = MyString("est");

  stdout.writeln("1) $str1 2) $str2 3) $str3 4) $str4");
  stdout.writeln("Первая строка, нулевой индекс: ${str1[0]}");

  try {
    str1[100];
  } on RangeError catch (e) {
    stdout.writeln(e);
  }

  try {
    str1 + "lorem";
  } on ArgumentError catch (e) {
    stdout.writeln(e);
  }

  stdout.writeln("Сложение 1ой и 2ой строки: ${str1 + str2}");

  stdout.writeln("1ая строка равна 2ой строке: ${str1 == str2}");
  stdout.writeln("1ая строка равна 3ей строке: ${str1 == str3}");

  stdout.writeln("1ая строка больше 3ей строки: ${str1 > str3}");
  stdout.writeln("4ая строка меньше 1ой строки: ${str4 < str1}");

  stdout.writeln("1ая строка больше 2ой строки: ${str1 > str2}");
}
