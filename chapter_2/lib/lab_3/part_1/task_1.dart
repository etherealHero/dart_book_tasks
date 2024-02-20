import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
1. Пользователь вводит с клавиатуры список вещественных значений.
Используя цикл for, for-in и while найдите сумму его элементов и
выведите полученный результат в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите список вещественных значений: ");
  String? numsRaw = stdin.readLineSync();

  if (numsRaw == null ||
      numsRaw.split(" ").indexWhere((e) => double.tryParse(e) == null) != -1) {
    return ClientMessage().errorInputData();
  }

  List<double> nums = numsRaw.split(" ").map((e) => double.parse(e)).toList();

  double sumFor = 0;
  for (var i = 0; i < nums.length; i++) {
    sumFor += nums[i];
  }

  double sumForIn = 0;
  for (var num in nums) {
    sumForIn += num;
  }

  double sumWhile = 0;
  int i = 0;
  while (i < nums.length) {
    sumWhile += nums[i];
    i++;
  }

  stdout.writeln("sumFor: $sumFor, sumForIn: $sumForIn, sumWhile: $sumWhile");
}
