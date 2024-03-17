import 'dart:io';

import '/src/shared.dart';

var task = Task("""
2. Напишите приложение, которое считывает содержимое нескольких
текстовых файлов, объединяет их и записывает результат в новый файл.
""", execute);

void execute(List<String> arguments) {
  File file1 = getExistsFileByPath('bin\\task_2\\file_1.txt');
  File file2 = getExistsFileByPath('bin\\task_2\\file_2.txt');
  File file3 = getExistsFileByPath('bin\\task_2\\file_3.txt');

  var wholeLinesList = <String>[];

  wholeLinesList.addAll(file1.readAsLinesSync());
  wholeLinesList.addAll(file2.readAsLinesSync());
  wholeLinesList.addAll(file3.readAsLinesSync());

  var fileOutput = File('bin\\task_2\\file_output.txt');

  StringBuffer sb = StringBuffer();
  for (var line in wholeLinesList) {
    sb.writeln(line);
  }

  fileOutput.writeAsStringSync(sb.toString());
}

File getExistsFileByPath(String path) {
  File file = File(path);

  if (!file.existsSync()) {
    throw Exception('Файл $path не существует');
  }

  return file;
}
