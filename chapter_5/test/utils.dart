import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

/// Проверяет генераторную функцию тест-кейса на признак завершенности
/// ожидаемого вывода-ввода. Использовать внутри test() т.к. использует expect()
void checkTestCaseFulfilled(Iterator<(String, String?)> io) {
  String? fallenStep;
  if (io.moveNext()) fallenStep = io.current.toString();
  expect(fallenStep, isNull, reason: "Ожидался вывод-ввод: $fallenStep");
}

typedef ProcessType = (Process, Stream<String>);

/// Открывает процесс для интеграционного тестирования ввода-вывода
Future<ProcessType> startProcess() async {
  var process = await Process.start(
    "dart",
    ['run', '${Directory.current.path}\\bin\\chapter_5.dart'],
  );
  var stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());

  return (process, stream);
}

void Function() setUpEnv(String dirPath) {
  var backupDir = Directory(dirPath);

  if (backupDir.existsSync()) {
    backupDir = backupDir.renameSync("${dirPath}_backup");
  }

  var testDir = Directory(dirPath)..createSync();

  void tearDownEnv() {
    testDir.deleteSync(recursive: true);

    if (backupDir.existsSync()) {
      backupDir.renameSync(dirPath);
    }
  }

  return tearDownEnv;
}
