import 'dart:io';
import '/src/shared.dart';

var task = Task("""
17. Пользователь вводит с клавиатуры строку, содержащую символы в
различном регистре. Напишите функцию, возвращающую количество
прописных букв. Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите строку: ");
  String? str = stdin.readLineSync();

  if (str == null) return stdmsg.raiseError();

  stdout.writeln("Количество прописных букв: ${countUpperLetter(str)}");
}

int countUpperLetter(String str) {
  int counter = 0;

  for (var letter in str.split("")) {
    if (letter.toUpperCase() == letter &&
        letter.toUpperCase() != letter.toLowerCase()) counter += 1;
  }

  return counter;
}
