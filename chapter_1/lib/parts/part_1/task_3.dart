import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
3. Напишите приложение, где пользователь вводит строку и букву.
Посчитайте сколько раз заданная буква входит в строку и выведите
полученный результат, а также индекс первого вхождения буквы в строку,
в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите строку: ");
  String str = stdin.readLineSync()!;

  stdout.write("Введите букву: ");
  String letter = stdin.readLineSync()!;
  int cnt = 0;

  str.split("").forEach((char) {
    if (char == letter) cnt++;
  });

  stdout.write("$cnt раз заданная буква входит в строку");
  stdout
      .write("${str.indexOf(letter)} индекс первого вхождения буквы в строку");
}
