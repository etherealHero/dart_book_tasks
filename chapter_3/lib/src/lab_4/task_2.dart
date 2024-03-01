import 'dart:io';
import '/src/shared.dart';

var task = Task("""
2. Пользователь вводит с клавиатуры целочисленный список. Напишите
функцию, которая возвращает произведение элементов списка.
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

  stdout.writeln("Произведение чисел: ${getMultiplyOfList(list)}");
}

int getMultiplyOfList(List<int> list) {
  return list.reduce((mult, e) => mult * e);
}
