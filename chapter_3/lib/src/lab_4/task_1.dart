/*
Во всех заданиях необходимо предусмотреть проверку на
правильность вводимых данных с клавиатуры;
Каждое задание на функции должно сопровождаться
минимум тремя тестами;
ЗАПРЕЩЕНО использовать рекурсию.
*/
import 'dart:io';
import '/src/shared.dart';

var task = Task("""
1. Пользователь вводит с клавиатуры целочисленный список. Напишите
функцию, которая возвращает его максимальное значение. Полученный
результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите целочисленный список: ");
  String? listRaw = stdin.readLineSync();

  if (listRaw == null ||
      listRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return stdmsg.raiseError();
  }

  List<int> list = listRaw.split(" ").map((e) => int.parse(e)).toList();

  if (list.isEmpty) return stdmsg.raiseError();

  stdout.writeln("Максимальное число: ${getMaxValueOfList(list)}");
  // stdout.writeln("Максимальное число: ${getMaxValueOfList(list)}");
}

int getMaxValueOfList(List<int> list) {
  int maxValue = list[0];

  for (var value in list) {
    if (value > maxValue) maxValue = value;
  }

  return maxValue;
}
