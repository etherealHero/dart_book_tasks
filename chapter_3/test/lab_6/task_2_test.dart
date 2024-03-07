@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_6/task_2.dart";
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

  group("Счетчик n=n^2 (интеграционный)", () {
    test("Счетчики n=n^2 работают раздельно (интеграционный)", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "6");
        yield ("Введите номер задания: ", "2");
        yield ("Введите начальное значение счетчика 1: ", "2");
        yield ("Введите начальное значение счетчика 2: ", "3");
        yield (
          "Тройной вызов первого счетчика: 16; "
              "Вызов второго счетчика: 3",
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

      var exitCode = await process.exitCode;
      expect(exitCode, 0, reason: "Ожидалось завершение программы");
    });

    test("Обработка неверных входных данных", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "6");
        yield ("Введите номер задания: ", "2");
        yield ("Введите начальное значение счетчика 1: ", "2");
        yield ("Введите начальное значение счетчика 2: ", "lorem");
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

  group("Модульное тестирование счетчика n=n^2", () {
    test(
      "Счетчик n=n^2 возвращает квадрат числа",
      () {
        int Function() firstIncrement = createPowIncremet(4);

        expect(firstIncrement(), 4);
        expect(firstIncrement(), 16);
        expect(firstIncrement(), 256);
      },
    );

    test(
      "Счетчики n=n^2 работают раздельно",
      () {
        int Function() firstIncrement = createPowIncremet(2);
        int Function() secondIncrement = createPowIncremet(3);

        firstIncrement();
        firstIncrement();

        expect(firstIncrement(), 16);
        expect(secondIncrement(), 3);
      },
    );
  });
}
