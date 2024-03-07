@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_5/task_3.dart";
import "package:test/test.dart";

import "../utils.dart";

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

  group("Является ли число степенью двойки (интеграционный)", () {
    test("33 не является степенью двойки", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "3");
        yield ("Введите число N: ", "33");
        yield ("Является ли число N степенью двойки: false", null);
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

    test("48 не является степенью двойки", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "3");
        yield ("Введите число N: ", "48");
        yield ("Является ли число N степенью двойки: false", null);
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

    test("32 является степенью двойки", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "3");
        yield ("Введите число N: ", "32");
        yield ("Является ли число N степенью двойки: true", null);
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

    test("Обработка неверных входных данных", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "3");
        yield ("Введите число N: ", "lorem");
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

      var exitCode = await process.exitCode;
      expect(exitCode, 0, reason: "Ожидалось завершение программы");
    });
  });

  group("Функция определяет является ли число степенью двойки (модульный)", () {
    test(
      "Функция: 32 является степенью двойки",
      () => expect(isExponentOfTwo(32), true),
    );
    test(
      "Функция: 33 не является степенью двойки",
      () => expect(isExponentOfTwo(33), false),
    );
    test(
      "Функция: 48 не является степенью двойки",
      () => expect(isExponentOfTwo(48), false),
    );
  });
}
