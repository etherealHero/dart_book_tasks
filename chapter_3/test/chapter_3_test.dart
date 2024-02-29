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

    var step = 0;
    var workflowCase = [
      ("Номер Лабораторной работы 4, 5, или 6: ", "4"),
      ("Введите номер задания: ", "1"),
      ("Введите целочисленный список: ", "11 28 -10"),
      ("Максимальное число: 28", ""),
    ];

    process.stdout.transform(utf8.decoder).transform(LineSplitter()).listen(
      (String lineOutput) {
        var (String expectedOutput, String inputLine) = workflowCase[step];

        expect(lineOutput, expectedOutput);

        if (step < workflowCase.length) process.stdin.writeln(inputLine);
        step++;
      },
    );

    var exitCode = await process.exitCode;
    expect(exitCode, 0);
  });
}
