@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_5/task_2.dart";
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

  group("Рекурсивный поиск минимального числа (интеграционный)", () {
    test("Рекурсивный поиск минимального числа", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "5");
        yield ("Введите номер задания: ", "2");
        yield ("Введите целочисленный список: ", "10 28 -1 0");
        yield ("Минимальное значение из списка: -1", null);
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
        yield ("Введите номер задания: ", "2");
        yield ("Введите целочисленный список: ", "10 28 -1 0 lorem");
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

  test("Функция по рекурсивному поиску минимального числа", () {
    var list = [10, 28, -1, 0];

    expect(getMinValueOfList(list, list.length - 1, list[list.length - 1]), -1);
  });
}
