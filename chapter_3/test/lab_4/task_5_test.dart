@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_3/src/lab_4/task_5.dart";
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

  group("Расчет расстояния между точками (интеграционный)", () {
    test("Две описанные точки", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "5");
        yield ("Введите название осей точки 1: ", "x y");
        yield ("Введите значение осей точки 1: ", "1 2");
        yield ("Введите название осей точки 2: ", "x y");
        yield ("Введите значение осей точки 2: ", "4 -1");
        yield ("Расстояние между точками: 4.24", null);
      }

      var io = testCase().iterator;

      await for (String output in stream) {
        if (io.moveNext()) {
          var (String expectedOutput, String? input) = io.current;

          expect(
            outputDistanceParser(output),
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

    test("Вторая точка по умолчанию", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "5");
        yield ("Введите название осей точки 1: ", "x y");
        yield ("Введите значение осей точки 1: ", "1 2");
        yield ("Введите название осей точки 2: ", "");
        yield ("Введите значение осей точки 2: ", "");
        yield ("Расстояние между точками: 8.06", null);
      }

      var io = testCase().iterator;

      await for (String output in stream) {
        if (io.moveNext()) {
          var (String expectedOutput, String? input) = io.current;

          expect(
            outputDistanceParser(output),
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

    test("Обработка неверных входных данных", () async {
      testCase() sync* {
        yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
        yield ("Введите номер задания: ", "5");
        yield ("Введите название осей точки 1: ", "x z");
        yield ("Неверные входные данные", null);
      }

      var io = testCase().iterator;

      await for (String output in stream) {
        if (io.moveNext()) {
          var (String expectedOutput, String? input) = io.current;

          expect(
            outputDistanceParser(output),
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
  });

  test(
    "Функция рассчета расстояния между точками",
    () => expect(
      num.parse(
        getDistance({'x': 1, 'y': 2}, {'x': 4, 'y': -1}).toStringAsFixed(2),
      ),
      4.24,
    ),
  );
}

String outputDistanceParser(String outputRaw) {
  if (outputRaw.startsWith("Расстояние между точками: ")) {
    num? distance = num.tryParse(outputRaw.substring(26));

    if (distance != null) {
      outputRaw = "Расстояние между точками: "
          "${distance.toStringAsFixed(2)}";
    }
  }

  return outputRaw;
}
