import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
14. Пользователь вводит с клавиатуры положительное число. Используя
операции сдвига установить 4 правых бита в ноль и выведите полученный
результат в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите положительное число: ");
  String? numRaw = stdin.readLineSync();

  if (numRaw == null || int.tryParse(numRaw) == null) {
    return ClientMessage().errorInputData();
  }

  int num = int.parse(numRaw);

  stdout.writeln(num.toRadixString(2));
  stdout.writeln((num >> 4 << 4).toRadixString(2));
}
