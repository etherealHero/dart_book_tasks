import 'dart:io';
import 'dart:math';
import '/src/shared.dart';

var task = Task("""
2. Пользователь вводит с клавиатуры целочисленный список. Напишите
рекурсивную функцию, возвращающую минимальное значение из списка.
Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите целочисленный список: ");
  String? listRaw = stdin.readLineSync();

  if (listRaw == null ||
      listRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return stdmsg.raiseError();
  }

  List<int> list = listRaw.split(" ").map((e) => int.parse(e)).toList();

  stdout.writeln(
      "Минимальное значение из списка: ${getMinValueOfList(list, list.length - 1, list[list.length - 1])}");
}

int getMinValueOfList(List<int> list, int n, int current) {
  return n > 0
      ? getMinValueOfList(list, n - 1, min(current, list[n - 1]))
      : current;
}
