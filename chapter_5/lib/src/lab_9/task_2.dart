import 'dart:io';

import '/src/shared.dart';

var task = Task("""
2. Напишите приложение, которое считывает содержимое нескольких
текстовых файлов, объединяет их и записывает результат в новый файл.
""", execute);

void execute(List<String> arguments) {
  File file1, file2, file3;

  try {
    file1 = getExistsFileByPath('bin\\task_2\\file_1.txt');
    file2 = getExistsFileByPath('bin\\task_2\\file_2.txt');
    file3 = getExistsFileByPath('bin\\task_2\\file_3.txt');
  } catch (e) {
    stdout.writeln(e);
    return;
  }

  var wholeLinesList = <String>[];

  wholeLinesList.addAll(file1.readAsLinesSync());
  wholeLinesList.addAll(file2.readAsLinesSync());
  wholeLinesList.addAll(file3.readAsLinesSync());

  const fileOutputPath = 'bin\\task_2\\file_output.txt';
  var fileOutput = File(fileOutputPath);

  StringBuffer sb = StringBuffer();
  for (var line in wholeLinesList) {
    sb.writeln(line);
  }

  fileOutput.writeAsStringSync(sb.toString());
  stdout.writeln("Данные записаны в файл: $fileOutputPath");
}

File getExistsFileByPath(String path) {
  File file = File(path);

  if (!file.existsSync()) {
    throw Exception('Файл $path не существует');
  }

  return file;
}
