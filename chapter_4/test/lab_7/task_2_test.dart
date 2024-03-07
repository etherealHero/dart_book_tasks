// ignore_for_file: unused_import

@Skip('Задание еще не реализовано')
@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import 'package:chapter_4/src/lab_7/task_2.dart';
import "package:test/test.dart";

import '../utils.dart';

void main() {
  late Process process;
  late Stream<String> stream;

  setUp(() async {
    process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_4.dart'],
    );
    stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());
  });

  tearDown(() => process.kill());

  test("test", () async {
    testCase() sync* {
      yield ("Номер Лабораторной работы 7 или 8: ", "7");
      yield ("Введите номер задания: ", "2");
      yield ("stdout", "stdin");
      yield ("stdout", null);
    }

    var io = testCase().iterator;

    await for (String output in stream) {
      if (io.moveNext()) {
        var (String expectedOutput, String? input) = io.current;
        expect(output, expectedOutput);
        process.stdin.writeln(input);
      } else {
        process.kill();
      }
    }

    checkTestCaseFulfilled(io);

    var exitCode = await process.exitCode;
    expect(exitCode, 0, reason: "Ожидалось завершение программы");
  });
}
