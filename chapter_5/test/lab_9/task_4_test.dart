@Timeout(Duration(seconds: 3))

import "dart:io";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  const String dirPath = 'bin\\task_4';
  const String outputFile = 'file_output.txt';

  late void Function() tearDownEnv;
  late Process process;
  late Stream<String> stream;

  setUp(() => (tearDownEnv) = setUpEnv(dirPath));

  tearDown(() {
    tearDownEnv();
    process.kill();
  });

  group("Уникальные слова по порядку", () {
    test("4 уникальных слова по алфавиту", () async {
      File("$dirPath\\file.txt")
        ..createSync()
        ..writeAsStringSync(
          "lorem ipsum\n"
          "dolor lorem est ",
        );

      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "4");
        yield ("Данные записаны в файл: $dirPath\\$outputFile", null);
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

      expect(
        File("$dirPath\\$outputFile").existsSync(),
        true,
        reason: "Ожидался выходной файл $dirPath\\$outputFile",
      );

      expect(
        File("$dirPath\\$outputFile").readAsStringSync(),
        "dolor, est, ipsum, lorem",
      );
    });

    test("Обработка исключения - файл не существует", () async {
      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "4");
        yield (
          "Файл $dirPath\\file.txt не существует. "
              "Завершение программы",
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
  });
}
