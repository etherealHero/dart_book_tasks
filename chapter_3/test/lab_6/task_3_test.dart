@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_6/task_3.dart";
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

  group("Функция-конструктор инспектор строки (интеграционный)", () {
    test("Функция-конструктор инспектор строки (интеграционный)", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "6");
        yield ("Введите номер задания: ", "3");
        yield ("Введите строку: ", "lorem dolor");
        yield ("Символ строки по индексу 0: 'l'", null);
        yield ("Символ строки по индексу 3: 'e'", null);
        yield ("Символ строки по индексу 5: ' '", null);
        yield ("Символ строки по индексу 1000: ''", null);
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
        yield ("Введите номер задания: ", "3");
        yield ("Введите строку: ", "");
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

  test(
    "Функция-конструктор инспектор строки (модульный)",
    () {
      var stringInspector = createStringInspector("lorem dolor");

      expect(stringInspector(0), 'l');
      expect(stringInspector(3), 'e');
      expect(stringInspector(5), ' ');
      expect(stringInspector(1000), '',
          reason: 'За пределами строки ожидается пустой символ');
    },
  );
}
