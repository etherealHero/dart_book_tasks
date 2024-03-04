import 'dart:io';
import '/src/shared.dart';

var task = Task("""
14. Пользователь вводит с клавиатуры целочисленный список и число n.
Напишите рекурсивную функцию возвращающую сумму элементов списка,
кратных n. Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите целочисленный список: ");
  String? listRaw = stdin.readLineSync();

  if (listRaw == null ||
      listRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return stdmsg.raiseError();
  }

  List<int> list = listRaw.split(" ").map((e) => int.parse(e)).toList();

  stdout.writeln("Введите число N: ");
  String? nRaw = stdin.readLineSync();

  if (nRaw == null || int.tryParse(nRaw) == null) {
    return stdmsg.raiseError();
  }

  int n = int.parse(nRaw);

  stdout.writeln(
      "Сумма элементов списка, кратных N: ${sumOfListWhereMultiplyByInt(list, n)}");
}

int sumOfListWhereMultiplyByInt(List<int> list, int multiplyParameter) {
  return switch (list) {
    List<int> list when list.isEmpty => 0,
    List<int> list when list[0] % multiplyParameter == 0 =>
      list[0] + sumOfListWhereMultiplyByInt(list.sublist(1), multiplyParameter),
    _ => sumOfListWhereMultiplyByInt(list.sublist(1), multiplyParameter),
  };
}
