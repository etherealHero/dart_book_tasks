@Timeout(Duration(seconds: 3))
@Skip("not implemented")

import "dart:convert";
import "dart:io";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  late Process process;
  late Stream<String> stream;

  setUp(() async {
    process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_5.dart'],
    );
    stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());
  });

  tearDown(() => process.kill());

  test("description", () async {
    testCase() sync* {
      yield ("Номер Лабораторной работы 9 или 10: ", "9");
      yield ("Введите номер задания: ", "2");
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
