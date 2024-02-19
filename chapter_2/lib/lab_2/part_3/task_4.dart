import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
13. Пользователь вводит с клавиатуры букву алфавита. Определите
является она строчной или прописной и выведите в терминал «lowercase»,
либо «uppercase» (без кавычек) в зависимости от результата проверки.
Реализуйте 2 версии программы с разными подходами (if и switch).
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите букву алфавита: ");
  String? letterRaw = stdin.readLineSync();

  if (letterRaw == null || letterRaw.length > 1) {
    return ClientMessage().errorInputData();
  }

  String letter = letterRaw;

  if (letter.toLowerCase() == letter) {
    stdout.writeln("lorewcase");
  } else {
    stdout.writeln("uppercase");
  }

  stdout.writeln(switch (letter) {
    String l when l.toLowerCase() == l => "lowercase",
    String l when l.toUpperCase() == l => "uppercase",
    _ => "Неверные входные данные"
  });
}
