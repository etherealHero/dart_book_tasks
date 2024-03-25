/*
- Каждое задание должно сопровождаться минимум тремя
тестами и содержать хотя бы одно исключение;
- Каждая задача должна иметь 2 решения: Future API или
Stream и Isolate. 
1. Напишите приложение, которое осуществляет чтение данных из
файла и запись этих данных в другой файл. Названия файлов не должны
совпадать.
*/

import 'dart:io';
import 'package:path/path.dart' as p;

Future<File> copyFileByStream(String path) async {
  var inputFile = File(path);

  if (!inputFile.existsSync()) {
    throw FileSystemException("File not exists", path);
  }

  var outputFile = File(p.join(
    inputFile.parent.path,
    "${p.basenameWithoutExtension(path)}_copy${p.extension(path)}",
  ));

  if (outputFile.existsSync()) {
    outputFile.deleteSync();
  }

  var outputLines = outputFile.openWrite(mode: FileMode.writeOnlyAppend);
  var inputData = inputFile.openRead();

  await for (var data in inputData) {
    outputLines.add(data);
  }

  await outputLines.close();
  return outputFile;
}

Future<File> copyFileByFuture(String path) async {
  var inputFile = File(path);

  if (!inputFile.existsSync()) {
    throw FileSystemException("File not exists", path);
  }

  var outputFile = File(p.join(
    inputFile.parent.path,
    "${p.basenameWithoutExtension(path)}_copy${p.extension(path)}",
  ));

  if (outputFile.existsSync()) {
    outputFile.deleteSync();
  }

  var inputData = await inputFile.readAsBytes();
  var outputData = outputFile.openWrite();

  outputData.add(inputData);

  await outputData.close();
  return outputFile;
}
