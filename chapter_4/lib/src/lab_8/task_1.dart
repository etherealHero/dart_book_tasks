/*
Каждое задание должно сопровождаться минимум пятью
тестами и содержать хотя бы одно исключение.
*/
import 'dart:io';
import 'package:chapter_4/src/lab_8/task_1/date.dart';

import '/src/shared.dart';

var task = Task("""
2. Создайте класс Date, который будет представлять дату (год, месяц и
день) и перегружать операторы для сравнения дат.
""", execute);

void execute(List<String> arguments) {
  var date1 = Date(year: 24, month: 3, day: 10);
  var date2 = Date(year: 2024, month: 3, day: 12);
  var date3 = Date(year: 24, month: 3, day: 10);

  try {
    Date(year: 24, month: 30, day: 10);
  } on ArgumentError catch (e) {
    stdout.writeln(e);
  }

  try {
    Object obj = 'lorem';

    stdout.writeln("Дата 1 равна Дате 2: ${date1 > obj}");
  } on DateCompareException catch (e) {
    stdout.writeln(e);
  }

  stdout.writeln("Дата 1: $date1");
  stdout.writeln("Дата 2: $date2");
  stdout.writeln("Дата 3: $date3");

  stdout.writeln("Дата 1 равна Дате 2: ${date1 == date2}");

  stdout.writeln("Дата 1 больше Даты 2: ${date1 > date2}");
  stdout.writeln("Дата 2 больше Даты 1: ${date2 > date1}");

  stdout.writeln("Дата 1 меньше Даты 2: ${date1 < date2}");
  stdout.writeln("Дата 2 меньше Даты 1: ${date2 < date1}");

  stdout.writeln("Дата 1 больше или равна Дате 2: ${date1 >= date2}");
  stdout.writeln("Дата 2 больше или равна Дате 1: ${date2 >= date1}");
  stdout.writeln("Дата 1 меньше или равна Дате 2: ${date1 <= date2}");
  stdout.writeln("Дата 2 меньше или равна Дате 1: ${date2 <= date1}");

  stdout.writeln("Дата 1 равна Дате 3: ${date1 == date3}");

  stdout.writeln("Дата 1 больше Даты 3: ${date1 > date3}");
  stdout.writeln("Дата 3 больше Даты 1: ${date3 > date1}");

  stdout.writeln("Дата 1 меньше Даты 3: ${date1 < date3}");
  stdout.writeln("Дата 3 меньше Даты 1: ${date3 < date1}");

  stdout.writeln("Дата 1 больше или равна Дате 3: ${date1 >= date3}");
  stdout.writeln("Дата 3 больше или равна Дате 1: ${date3 >= date1}");
  stdout.writeln("Дата 1 меньше или равна Дате 3: ${date1 <= date3}");
  stdout.writeln("Дата 3 меньше или равна Дате 1: ${date3 <= date1}");
}
