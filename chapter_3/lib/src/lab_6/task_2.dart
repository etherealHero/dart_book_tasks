import 'dart:io';
import '/src/shared.dart';

var task = Task("""
2. Напишите функцию, на вход которой подается целочисленное
значение n, которое в последующем будет возводиться в квадрат. Она
должна возвращать другую функцию, при вызове которой будет каждый раз
возвращаться результат выражения n=n^2. Полученный результат выведите
в терминал.
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

  int Function() firstIncrement = createPowIncremet(int.parse(firstInitRaw));
  int Function() secondIncrement = createPowIncremet(int.parse(secondInitRaw));

  firstIncrement();
  firstIncrement();

  stdout.writeln(
    "Тройной вызов первого счетчика: ${firstIncrement()}; "
    "Вызов второго счетчика: ${secondIncrement()}",
  );
}

int Function() createPowIncremet(int init) {
  int currentValue;
  int nextValue = init;

  return () {
    currentValue = nextValue;
    nextValue = nextValue * nextValue;
    return currentValue;
  };
}
