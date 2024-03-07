@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:test/test.dart";

import "utils.dart";

void main() {
  late Process process;
  late Stream<String> stream;

  setUp(() async {
    process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_3.dart'],
    );
    stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());
  });

  tearDown(() => process.kill());

  group("Запуск заданий", () {
    test("Выбор Лабораторной работы и Задания", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "1");
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
    });

    test("Выбор несуществующей Лабораторной работы", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "-1");
        yield ("Неверные входные данные", null);
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
    });

    test("Выбор Лабораторной работы и несуществующейго задания", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "-1");
        yield ("Неверные входные данные", null);
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
    });
  });
}
