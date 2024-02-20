import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
12. Пользователь вводит с клавиатуры два значения. Используя
побитовые операции и не прибегая к буферной переменной, поменяйте
значение этих переменных местами и выведите полученный результат в
терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите два значения через пробел: ");

  String? numsRaw = stdin.readLineSync();

  if (numsRaw == null ||
      numsRaw.split(" ").length != 2 ||
      numsRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) != -1) {
    return ClientMessage().errorInputData();
  }

  var [int a, int b] = numsRaw.split(" ").map((e) => int.parse(e)).toList();

  a = a ^ b;
  b = a ^ b;
  a = a ^ b;

  stdout.writeln("swap a: $a, b: $b");
}
