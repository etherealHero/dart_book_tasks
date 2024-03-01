import 'dart:io';
import '/src/shared.dart';

var task = Task("""
2. Пользователь вводит с клавиатуры целочисленный список. Напишите
функцию, которая возвращает произведение элементов списка.
Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите целочисленный список: ");

  stdout.write("Произведение чисел: ${getMultiplyOfList([])}");
}

int getMultiplyOfList(List<int> list) {
  return 1;
}
