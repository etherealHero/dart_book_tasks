import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
2. Напишите приложение, где пользователь вводит строку и букву.
Выведите в терминал длину строки, также индекс первого и последнего
вхождения буквы в строку.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите строку: ");
  String str = stdin.readLineSync()!;

  stdout.write("Введите букву: ");
  String letter = stdin.readLineSync()!;

  stdout.write("Длина строки: ${str.length}");
  stdout
      .write("Первый индекс вхождения буквы в строку: ${str.indexOf(letter)}");
  stdout.write(
      "Последний индекс вхождения буквы в строку: ${str.lastIndexOf(letter)}");
}
