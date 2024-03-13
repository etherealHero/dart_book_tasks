@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_4/src/lab_8/task_2/mystring.dart";
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

  test("Класс MyString(). Интеграционное тестирование", () async {
    testCase() sync* {
      yield ("Номер Лабораторной работы 7 или 8: ", "8");
      yield ("Введите номер задания: ", "2");
      yield ("1) lorem 2) ipsum 3) lorem 4) est", null);
      yield ("Первая строка, нулевой индекс: l", null);
      yield (
        "RangeError (Индекс не входит в диапазон): "
            "Index out of range: index should be less than 5: 100",
        null
      );
      yield (
        "Invalid argument (Ожидался экземпеляр "
            "MyString() к конкатенации): String",
        null
      );
      yield ("Сложение 1ой и 2ой строки: loremipsum", null);
      yield ("1ая строка равна 2ой строке: false", null);
      yield ("1ая строка равна 3ей строке: true", null);
      yield ("1ая строка больше 3ей строки: false", null);
      yield ("4ая строка меньше 1ой строки: true", null);
      yield ("1ая строка больше 2ой строки: true", null);
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

  test("Исключение при несуществующем индексе", () {
    expect(() => MyString("lorem")[100], throwsA(isA<RangeError>()));
  });

  test("Исключение при конкатенации с другим типом", () {
    expect(() => MyString("lorem") + "ipsum", throwsA(isA<ArgumentError>()));
  });

  test("Конкатенация MyString()", () {
    expect(MyString("lorem") + MyString("ipsum"), MyString("loremipsum"));
  });

  test("Проверка на равенство", () {
    expect(MyString("lorem") == MyString("lorem"), true);
    expect(MyString("lorem") == MyString("ipsum"), false);
  });

  test("Сравнение MyString()", () {
    expect(MyString("lorem") > MyString("est"), true);
    expect(MyString("lorem") > MyString("lorem"), false);
    expect(MyString("lorem") < MyString("ipsum"), false);
  });
}
