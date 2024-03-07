@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_5/task_4.dart";
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

  group("Сумма элементов кратных N (интеграционный)", () {
    test("Некоторые элементы кратны N", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "4");
        yield ("Введите целочисленный список: ", "3 10 -3 9 16");
        yield ("Введите число N: ", "3");
        yield ("Сумма элементов списка, кратных N: 9", null);
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

    test("Все элементы кратны N", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "4");
        yield ("Введите целочисленный список: ", "3 -3 9 9");
        yield ("Введите число N: ", "3");
        yield ("Сумма элементов списка, кратных N: 18", null);
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

    test("Все элементы не кратны N", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "4");
        yield ("Введите целочисленный список: ", "3 -3 9 9");
        yield ("Введите число N: ", "4");
        yield ("Сумма элементов списка, кратных N: 0", null);
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

    test("Неверные элементы списка", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "4");
        yield ("Введите целочисленный список: ", "3 -3 9 9 lorem");
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

    test("Неверное число N", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "4");
        yield ("Введите целочисленный список: ", "3 -3 9 9");
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
      "Функция: Сумма элементов кратных N, где часть элементов кратна N",
      () => expect(sumOfListWhereMultiplyByInt([3, 10, -3, 9, 16], 3), 9),
    );
    test(
      "Функция: Сумма элементов кратных N, где все элементы кратны N",
      () => expect(sumOfListWhereMultiplyByInt([3, -3, 9, 9], 3), 18),
    );
    test(
      "Функция: Сумма элементов кратных N, где все элементы не кратны N",
      () => expect(sumOfListWhereMultiplyByInt([3, -3, 9, 9], 4), 0),
    );
  });
}
