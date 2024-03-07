/*
Во всех заданиях необходимо предусмотреть проверку на
правильность вводимых данных с клавиатуры.
Каждое задание на функции должно сопровождаться
минимум тремя тестами.
*/
import 'dart:io';
import '/src/shared.dart';

var task = Task("""
1. Напишите функцию, на вход которой подается целочисленное
значение, устанавливающее начальное состояние счетчика. Она должна
возвращать другую функцию, при вызове которой будет возвращаться
обновленное значение счетчика, увеличивающееся на единицу.
Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите начальное значение счетчика 1: ");
  String? firstInitRaw = stdin.readLineSync();

  if (firstInitRaw == null || int.tryParse(firstInitRaw) == null) {
    return stdmsg.raiseError();
  }

  stdout.writeln("Введите начальное значение счетчика 2: ");
  String? secondInitRaw = stdin.readLineSync();

  if (secondInitRaw == null || int.tryParse(secondInitRaw) == null) {
    return stdmsg.raiseError();
  }

  int Function() firstIncrement = createIterator(int.parse(firstInitRaw));
  int Function() secondIncrement = createIterator(int.parse(secondInitRaw));

  firstIncrement();
  firstIncrement();

  stdout.writeln(
    "Тройной вызов первого счетчика: ${firstIncrement()}; "
    "Вызов второго счетчика: ${secondIncrement()}",
  );
}

int Function() createIterator(int init) {
  int iterator = init;
  return () => ++iterator;
}
