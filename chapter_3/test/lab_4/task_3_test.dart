@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_4/task_3.dart";
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

  group("Цельсий в фаренгейты (интеграционный)", () {
    test("Дробное число", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "3");
        yield ("Введите цельсий: ", "36.6");
        yield ("Фаренгейты: 97.88", null);
      }

      var io = testCase().iterator;

      await for (String output in stream) {
        if (io.moveNext()) {
          var (String expectedOutput, String? input) = io.current;

          expect(
            outputFahrenheitParser(output),
            expectedOutput,
          );

          process.stdin.writeln(input);
        } else {
          process.kill();
        }
      }

      var exitCode = await process.exitCode;
      expect(exitCode, 0, reason: "Ожидалось завершение программы");
    });

    test("Целое число", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "3");
        yield ("Введите цельсий: ", "28");
        yield ("Фаренгейты: 82.4", null);
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
        yield ("Введите номер задания: ", "3");
        yield ("Введите цельсий: ", "lorem");
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

  group("Цельсий в фаренгейты (модульный)", () {
    test(
      "Функция перевода в фаренгейты дробное число",
      () => expect(
        num.tryParse(convertToFahrenheit(36.6).toStringAsFixed(2)),
        97.88,
      ),
    );

    test(
      "Функция перевода в фаренгейты целое число",
      () => expect(convertToFahrenheit(28), 82.4),
    );
  });
}

String outputFahrenheitParser(String output) {
  if (output.startsWith("Фаренгейты: ")) {
    num? distance = num.tryParse(output.substring(12));

    if (distance != null) {
      output = "Фаренгейты: "
          "${distance.toStringAsFixed(2)}";
    }
  }
  return output;
}
