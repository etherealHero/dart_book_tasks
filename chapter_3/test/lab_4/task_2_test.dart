@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_4/task_2.dart";
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

  group("Произведение чисел списка (интеграционный)", () {
    test("Произведение чисел", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "2");
        yield ("Введите целочисленный список: ", "3 5 -1");
        yield ("Произведение чисел: -15", null);
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
        yield ("Введите номер задания: ", "2");
        yield ("Введите целочисленный список: ", "3 5 -1 lorem");
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

  group("Произведение чисел (модульный)", () {
    test(
      "Функция произведения списка чисел",
      () => expect(getMultiplyOfList([3, 5, -1]), -15),
    );

    test(
      "Функция произведения списка чисел с нулем",
      () => expect(getMultiplyOfList([3, 5, 0]), 0),
    );
  });
}
