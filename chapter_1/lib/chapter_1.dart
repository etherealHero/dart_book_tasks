/*
1. напишите приложение, где пользователь вводит строку и букву,
наличие которой предстоит проверить в введенной строке. выведите в
терминал полученный результат в терминал, а также индекс последнего
вхождения буквы в строку.
*/

import 'dart:io';

void start(List<String> arguments) {
  stdout.writeln("Введите строку, затем букву, которую необходимо найти: ");

  String? str = stdin.readLineSync();
  String? letter = stdin.readLineSync();

  if (str == null || letter == null || str.isEmpty || letter.length != 1) {
    return stdout.writeln("Неверные входные данные");
  }

  print("Строка: $str");
  print("Буква: $letter");
  print(str.contains(letter)
      ? "'$letter' содержится в '$str'"
      : "'$letter' не содержится в '$str'");
  print(
      "индекс последнего вхождения буквы в строку: ${str.lastIndexOf(letter)}");
}
