import 'dart:io';
import '/src/shared.dart';

var task = Task("""
17. Пользователь вводит с клавиатуры строку, содержащую символы в
различном регистре. Напишите функцию, возвращающую количество
прописных букв. Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите строку: ");

  stdout.writeln("Количество прописных букв: ${countUpperLetter("")}");
}

int countUpperLetter(String str) {
  return 1;
}
