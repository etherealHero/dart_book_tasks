import 'dart:io';
import 'dart:math';
import 'package:chapter_2/shared.dart';

var task = Task("""
16 (3sin(n)-15)/(sqrt(n^5))
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

  stdout.writeln("Выражение (3sin(n)-15)/(sqrt(n^5)): "
      "${(3 * sin(numN) - 15) / sqrt(pow(numN, 5))}");
}
