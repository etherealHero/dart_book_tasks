@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_5/task_1.dart";
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

  group("Рекурсивный расчет суммы 1..N (интеграционный)", () {
    test("Расчет суммы 1..6", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "1");
        yield ("Введите число N: ", "6");
        yield ("Сумма чисел от 1 до N: 21", null);
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

    test("Расчет суммы 1..10", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "1");
        yield ("Введите число N: ", "10");
        yield ("Сумма чисел от 1 до N: 55", null);
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
        yield ("Введите номер задания: ", "1");
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

  group("Расчет суммы 1..N (модульный)", () {
    test(
      "Функция расчета суммы рекурсией 1..6",
      () => expect(sumNumbers(6), 21),
    );
    test(
      "Функция расчета суммы рекурсией 1..10",
      () => expect(sumNumbers(10), 55),
    );
  });
}
