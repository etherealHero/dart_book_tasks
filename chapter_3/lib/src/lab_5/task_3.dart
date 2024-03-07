import 'dart:io';
import '/src/shared.dart';

var task = Task("""
12. Пользователь с клавиатуры вводит целое число N. Напишите
рекурсивную функцию проверяющую то, является ли введенное значение
точной степенью двойки. Если да – функция должна вернуть true, иначе
false. Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите число N: ");
  String? nRaw = stdin.readLineSync();

  if (nRaw == null || int.tryParse(nRaw) == null) {
    return stdmsg.raiseError();
  }

  int n = int.parse(nRaw);

  stdout.writeln("Является ли число N степенью двойки: ${isExponentOfTwo(n)}");
}

bool isExponentOfTwo(num n) {
  return switch (n) {
    num n when n / 2 == 2 => true,
    num n when n / 2 < 2 => false,
    _ => isExponentOfTwo(n / 2),
  };
}
