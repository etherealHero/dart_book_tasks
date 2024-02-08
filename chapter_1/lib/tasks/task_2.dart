import 'dart:io';

import 'package:chapter_1/shared.dart';

var task = Task("""
1. Напишите приложение, позволяющее пользователю вводить список
вещественных значений. Выведите в терминал его размер, значения
первого и последнего элемента.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите элементы списка через пробел: ");
  String? doublesRaw = stdin.readLineSync();
  List<double?> doubles =
      List.from(doublesRaw!.split(' ').map((e) => double.tryParse(e)));

  doubles.removeWhere((e) => e == null);

  print("Размер списка вещественных значений: ${doubles.length}");
  print("Первый элемент: ${doubles.first}");
  print("Последний элемент: ${doubles.last}");
}
