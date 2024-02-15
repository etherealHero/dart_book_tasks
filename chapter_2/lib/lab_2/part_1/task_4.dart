import 'dart:io';
import 'dart:math';
import 'package:chapter_2/shared.dart';

var task = Task("""
12 (n-20)/(sqrt(n^3))
""", execute);

void execute(List<String> arguments) {
  num numN;

  stdout.write("Введите значение N: ");
  String? numNRaw = stdin.readLineSync();

  if (numNRaw != null && num.tryParse(numNRaw) != null) {
    numN = num.parse(numNRaw);
  } else {
    return ClientMessage().errorInputData();
  }

  stdout.writeln("Выражение (n-20)/(sqrt(n^3)): "
      "${(numN - 20) / sqrt(pow(numN, 3))}");
}
