/*
Каждое задание должно сопровождаться минимум двумя
тестами и содержать хотя бы одно исключение.
*/
import 'dart:io';

import '/src/shared.dart';

var task = Task("""
1. Напишите приложение, которое считывает содержимое текстового
файла и выводит в терминал количество слов, а также записывает это
значение в новый файл.
""", execute);

void execute(List<String> arguments) {
  String filePath = 'bin\\task_1\\file.txt';
  String filePathOutput = 'bin\\task_1\\file_output.txt';

  File file = File(filePath);

  if (!file.existsSync()) {
    stdout.writeln(
      "Файл $filePath не существует. Завершение программы",
    );

    return;
  }

  List<String> lines = file.readAsLinesSync();
  int wordCount = 0;

  for (var line in lines) {
    wordCount += RegExp(r'\w+').allMatches(line).length;
  }

  stdout.writeln("Кол-во слов в файле: $wordCount");

  File fileOutput = File(filePathOutput);

  fileOutput.writeAsStringSync(
    "Кол-во слов в файле $filePath: $wordCount",
  );
}
