/*
Во всех заданиях необходимо предусмотреть проверку на
правильность вводимых данных с клавиатуры.
Каждое задание на функции должно сопровождаться
минимум тремя тестами.
*/
import 'dart:io';
import '/src/shared.dart';

var task = Task("""
1. Пользователь вводит с клавиатуры число n. Напишите рекурсивную
функцию, вычисляющую сумму всех чисел от 1 до n. Полученный результат
выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите число N: ");
  String? nRaw = stdin.readLineSync();

  if (nRaw == null || int.tryParse(nRaw) == null) {
    return stdmsg.raiseError();
  }

  int n = int.parse(nRaw);

  stdout.writeln("Сумма чисел от 1 до N: ${sumNumbers(n)}");
}

int sumNumbers(int n) {
  if (n == 1) {
    return n;
  } else {
    return n + sumNumbers(n - 1);
  }
}
