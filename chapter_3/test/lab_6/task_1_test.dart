@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_6/task_1.dart";
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

  group("Счетчик (интеграционный)", () {
    test("Счетчики работают раздельно (интеграционный)", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "6");
        yield ("Введите номер задания: ", "1");
        yield ("Введите начальное значение счетчика 1: ", "2");
        yield ("Введите начальное значение счетчика 2: ", "3");
        yield (
          "Тройной вызов первого счетчика: 5; "
              "Вызов второго счетчика: 4",
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
        yield ("Введите номер задания: ", "1");
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

  group("Модульное тестирование счетчика", () {
    test(
      "Счетчик увеличивается на 1",
      () {
        int Function() firstIncrement = createIterator(4);

        expect(firstIncrement(), 5);
        expect(firstIncrement(), 6);
        expect(firstIncrement(), 7);
      },
    );

    test(
      "Счетчики работают раздельно",
      () {
        int Function() firstIncrement = createIterator(2);
        int Function() secondIncrement = createIterator(3);

        firstIncrement();
        firstIncrement();

        expect(firstIncrement(), 5);
        expect(secondIncrement(), 4);
      },
    );
  });
}
