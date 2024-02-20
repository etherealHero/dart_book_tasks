import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
2. Пользователь вводит с клавиатуры список целочисленных значений.
Используя цикл for, for-in и while найдите среднеарифметическое
значение списка и выведите полученный результат в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите список целочисленных значений: ");
  String? numsRaw = stdin.readLineSync();

  if (numsRaw == null ||
      numsRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return ClientMessage().errorInputData();
  }

  List<int> nums = numsRaw.split(" ").map((e) => int.parse(e)).toList();

  double avgFor = 0;
  for (var i = 0; i < nums.length; i++) {
    avgFor += nums[i];
  }
  avgFor = avgFor / nums.length;

  double avgForIn = 0;
  for (var num in nums) {
    avgForIn += num;
  }
  avgForIn = avgForIn / nums.length;

  double avgWhile = 0;
  int i = 0;
  while (i < nums.length) {
    avgWhile += nums[i];
    i++;
  }
  avgWhile = avgWhile / nums.length;

  stdout.writeln("avgFor: $avgFor, avgForIn: $avgForIn, avgWhile: $avgWhile");
}
