import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
2. Напишите приложение, позволяющее пользователю вводить список
целочисленных значений и число A, на которое необходимо увеличить
значения элементов списка, после чего добавить A в конец списка.
Выведите в терминал полученный результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите список целочисленных значений: ");
  List<int> integers =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите число А: ");
  int integerA = int.parse(stdin.readLineSync()!);

  integers = integers.map((e) => e + integerA).toList();
  integers.add(integerA);

  stdout.writeln(integers);
}
