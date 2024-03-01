@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_4/task_1.dart";
import "package:test/test.dart";

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

  group("Поиск максималього числа (интеграционный)", () {
    test("Верное максимальное число", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "1");
        yield ("Введите целочисленный список: ", "10 28 -1 0");
        yield ("Максимальное число: 28", null);
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

      var exitCode = await process.exitCode;
      expect(exitCode, 0, reason: "Ожидалось завершение программы");
    });

    test("Обработка неверных входных данных", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "1");
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

      var exitCode = await process.exitCode;
      expect(exitCode, 0, reason: "Ожидалось завершение программы");
    });
  });

  test("Поиск максималього числа (модульный)", () {
    expect(getMaxValueOfList([10, 28, -1, 0]), 28);
  });
}
