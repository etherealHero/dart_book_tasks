import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
2. Пользователь вводит с клавиатуры положительное число. Используйте
маску и операцию побитового исключающего ИЛИ для того, чтобы
инвертировать значения битов и выведите полученный результат в
двоичном формате в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите положительное число: ");
  String? n = stdin.readLineSync();
  String mask = '';

  if (n == null || int.tryParse(n) == null) {
    return ClientMessage().errorInputData();
  }

  for (var bit in int.parse(n).toRadixString(2).split("")) {
    mask += int.parse(bit) & 1 == 1 ? "0" : "1";
  }

  stdout.writeln(int.parse(n).toRadixString(2));
  stdout.writeln(mask);
}
