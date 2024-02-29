@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:test/test.dart";

void main() {
  test("Поиск максимального числа", () async {
    var process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_3.dart'],
    );

    testCase() sync* {
      yield ("Номер Лабораторной работы 4, 5, или 6: ", "4");
      yield ("Введите номер задания: ", "1");
      yield ("Введите целочисленный список: ", "11 28 -10");
      yield ("Максимальное число: 28", null);
    }

    var io = testCase().iterator;

    process.stdout.transform(utf8.decoder).transform(LineSplitter()).listen(
      (String output) {
        if (io.moveNext()) {
          var (String expectedOutput, String? input) = io.current;
          expect(output, expectedOutput);
          process.stdin.writeln(input);
        } else {
          process.kill();
        }
      },
    );

    var exitCode = await process.exitCode;
    expect(exitCode, 0, reason: "Ожидалось завершение программы");
  });
}
