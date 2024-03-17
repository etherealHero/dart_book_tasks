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
      ['run', '${Directory.current.path}\\bin\\chapter_5.dart'],
    );
    stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());
  });

  tearDown(() => process.kill());

  group("Запуск заданий", () {
    test("Выбор Лабораторной работы и Задания", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
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
        yield ("Номер Лабораторной работы 9 или 10: ", "-1");
        yield (
          "Invalid argument (Номер лабораторной работы): "
              "Ожидалось значение 9 или 10, текущее: -1",
          null
        );
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
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "-1");
        yield (
          "Invalid argument (Номер задачи): "
              "Выбранный номер задачи не существует: -1",
          null
        );
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
