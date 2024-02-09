import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
16. Напишите приложение, позволяющее пользователю вводить список
целочисленных значений и число A. Сформируйте множество, значения
элементов которого > A и вычислите сумму его элементов. Выведите в
терминал полученный результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите список целочисленных значений: ");
  List<int> integers =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите число А: ");
  int integerA = int.parse(stdin.readLineSync()!);

  Set<int> set = Set.from(integers.where((e) => e > integerA));

  int sum = set.reduce((sum, e) => sum + e);

  stdout.writeln(set);
  stdout.writeln("Сумма элементов: $sum");
}
