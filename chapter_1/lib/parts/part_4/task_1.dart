import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
2. Напишите приложение, позволяющее пользователю вводить Map<int,
int> и число А. Удалите все элементы с ключами которые кратны А, потом
вычислите сумму всех значений и выведите в терминал полученный
результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите ключи таблицы из чисел: ");
  List<int> keys =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите значения таблицы из чисел: ");
  List<int> values =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите число А: ");
  int integerA = int.parse(stdin.readLineSync()!);

  Map<int, int> map = Map.fromIterables(keys, values);

  map.removeWhere((key, value) => key % integerA == 0);

  int sumValues = map.values.reduce((sum, e) => sum + e);

  stdout.writeln(map);
  stdout.writeln("Сумма значений: $sumValues");
}
