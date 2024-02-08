import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
1. напишите приложение, где пользователь вводит строку и букву,
наличие которой предстоит проверить в введенной строке. выведите в
терминал полученный результат в терминал, а также индекс последнего
вхождения буквы в строку.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите строку, затем букву, которую необходимо найти: ");

  String? str = stdin.readLineSync();
  String? letter = stdin.readLineSync();

  if (str == null || letter == null || str.isEmpty || letter.length != 1) {
    return ClientMessage().errorInputData();
  }

  print("Строка: $str");
  print("Буква: $letter");
  print(str.contains(letter)
      ? "'$letter' содержится в '$str'"
      : "'$letter' не содержится в '$str'");
  print(
      "индекс последнего вхождения буквы в строку: ${str.lastIndexOf(letter)}");
}
