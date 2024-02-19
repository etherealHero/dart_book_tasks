import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
1. Напишите две версии программы (c if и switch), которая считывает
целое число (месяц) и выводит в терминал сезон, к которому этот месяц
относится (Зима, Лето, Осень, Весна, Ошибка ввода!).
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите номер месяца: ");
  String? monthNumberRaw = stdin.readLineSync();
  int monthNumber;

  if (monthNumberRaw == null || int.tryParse(monthNumberRaw) == null) {
    return ClientMessage().errorInputData();
  }

  monthNumber = int.parse(monthNumberRaw);

  if (monthNumber case int mn when mn == 12 || mn == 1 || mn == 2) {
    stdout.writeln("Зима");
  } else if (monthNumber case int mn when mn == 3 || mn == 4 || mn == 5) {
    stdout.writeln("Весна");
  } else if (monthNumber case int mn when mn == 6 || mn == 7 || mn == 8) {
    stdout.writeln("Лето");
  } else if (monthNumber case int mn when mn == 9 || mn == 10 || mn == 11) {
    stdout.writeln("Осень");
  } else {
    ClientMessage().errorInputData();
  }

  stdout.writeln(switch (monthNumber) {
    12 || 1 || 2 => "Зима",
    3 || 4 || 5 => "Весна",
    6 || 7 || 8 => "Лето",
    9 || 10 || 11 => "Осень",
    _ => "Неверные входные данные"
  });
}
