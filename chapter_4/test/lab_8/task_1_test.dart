@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_4/src/lab_8/task_1/date.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  late Process process;
  late Stream<String> stream;

  setUp(() async {
    process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_4.dart'],
    );
    stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());
  });

  tearDown(() => process.kill());

  test("Класс дата. Интеграционное тестирование", () async {
    testCase() sync* {
      yield ("Номер Лабораторной работы 7 или 8: ", "8");
      yield ("Введите номер задания: ", "1");
      yield (
        "Invalid argument(s): Недействительный месяц. "
            "Ожидается номер месяца от 1 до 12",
        null
      );
      yield ("DateCompareException: Сравнивание даты с другим типом", null);
      yield ("Дата 1: 24г. 3 месяц 10 день", null);
      yield ("Дата 2: 2024г. 3 месяц 12 день", null);
      yield ("Дата 3: 24г. 3 месяц 10 день", null);
      yield ("Дата 1 равна Дате 2: false", null);
      yield ("Дата 1 больше Даты 2: false", null);
      yield ("Дата 2 больше Даты 1: true", null);
      yield ("Дата 1 меньше Даты 2: true", null);
      yield ("Дата 2 меньше Даты 1: false", null);
      yield ("Дата 1 больше или равна Дате 2: false", null);
      yield ("Дата 2 больше или равна Дате 1: true", null);
      yield ("Дата 1 меньше или равна Дате 2: true", null);
      yield ("Дата 2 меньше или равна Дате 1: false", null);
      yield ("Дата 1 равна Дате 3: true", null);
      yield ("Дата 1 больше Даты 3: false", null);
      yield ("Дата 3 больше Даты 1: false", null);
      yield ("Дата 1 меньше Даты 3: false", null);
      yield ("Дата 3 меньше Даты 1: false", null);
      yield ("Дата 1 больше или равна Дате 3: true", null);
      yield ("Дата 3 больше или равна Дате 1: true", null);
      yield ("Дата 1 меньше или равна Дате 3: true", null);
      yield ("Дата 3 меньше или равна Дате 1: true", null);
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

  test("Валидация при создании даты", () {
    expect(
      () => Date(year: 2024, month: 15, day: 10),
      throwsA(isA<ArgumentError>()),
    );
  });

  test("Исключение при сравнении даты с другим типом", () {
    Object obj = "lorem";

    expect(
      () => Date(year: 2024, month: 12, day: 10) > obj,
      throwsA(isA<DateCompareException>()),
    );
  });

  test("Дата больше второй даты", () {
    Date firstDate = Date(year: 2024, month: 12, day: 10);
    Date secondDate = Date(year: 2000, month: 12, day: 10);

    expect(
      firstDate > secondDate,
      true,
      reason: "Ожидалось, что дата будет больше второй даты",
    );
  });

  test("Дата меньше или равна другой дате", () {
    Date firstDate = Date(year: 2000, month: 3, day: 10);
    Date secondDate = Date(year: 2024, month: 3, day: 10);
    Date thirdDate = Date(year: 2000, month: 3, day: 10);

    expect(
      firstDate <= secondDate,
      true,
      reason: "Ожидалось, что дата будет меньше второй даты",
    );

    expect(
      firstDate <= thirdDate,
      true,
      reason: "Ожидалось, что дата равна третьей дате",
    );
  });
}
