import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
14. Напишите приложение, позволяющее пользователю вводить
целочисленное множество и число A. Удалите из множества значение A,
после чего уменьшите хранящиеся в нем значения на А и посчитайте сумму
элементов. Выведите в терминал полученный результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите целочисленное множество: ");
  Set<int> set =
      Set.from(stdin.readLineSync()!.split(" ").map((e) => int.parse(e)));

  stdout.write("Введите число A: ");
  int integerA = int.parse(stdin.readLineSync()!);

  set.remove(integerA);
  set = set.map((e) => e - integerA).toSet();

  int sum = set.reduce((sum, e) => sum + e);

  stdout.writeln(set);
  stdout.writeln("Сумма элементов: $sum");
}
