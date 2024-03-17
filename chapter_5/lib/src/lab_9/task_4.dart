import 'dart:io';

import '/src/shared.dart';

var task = Task("""
14. Напишите приложение, которое считывает содержимое текстового
файла и записывает в новый файл все уникальные слова в алфавитном
порядке.
""", execute);

void execute(List<String> arguments) {
  String filePath = 'bin\\task_4\\file.txt';
  String filePathOutput = 'bin\\task_4\\file_output.txt';

  File file = File(filePath);

  if (!file.existsSync()) {
    stdout.writeln(
      "Файл $filePath не существует. Завершение программы",
    );
  }

  var fileData = file.readAsStringSync();
  var uniqueWords = Set.from(
    RegExp(r'(\w+)').allMatches(fileData).map((e) => e[0]!),
  ).toList()
    ..sort(((a, b) => (a as String).compareTo(b)));

  var fileOutput = File(filePathOutput);

  fileOutput.writeAsStringSync(uniqueWords.join(", "));
}
