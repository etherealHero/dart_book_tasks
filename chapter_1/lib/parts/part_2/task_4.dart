import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
4. Напишите приложение, позволяющее пользователю вводить список
вещественных значений и два числа (например a и b). Программа должна
вставить число «a» на позицию «b». Выведите в терминал полученный
результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите список вещественных значений: ");
  List<num> numbers =
      stdin.readLineSync()!.split(" ").map((e) => num.parse(e)).toList();

  stdout.write("Введите число А: ");
  num integerA = num.parse(stdin.readLineSync()!);

  stdout.write("Введите число B: ");
  int integerB = int.parse(stdin.readLineSync()!);

  numbers.insert(integerB, integerA);
  stdout.writeln(numbers);
}
