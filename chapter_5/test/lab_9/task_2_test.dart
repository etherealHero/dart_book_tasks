@Timeout(Duration(seconds: 3))

import "dart:io";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  const String dirPath = 'bin\\task_2';
  const String outputFile = 'file_output.txt';

  late void Function() tearDownEnv;
  late Process process;
  late Stream<String> stream;

  setUp(() => (tearDownEnv) = setUpEnv(dirPath));

  tearDown(() {
    tearDownEnv();
    process.kill();
  });

  group("Объединение файлов", () {
    test("Объединение 3-х файлов (один пустой)", () async {
      File("$dirPath\\file_1.txt")
        ..createSync()
        ..writeAsStringSync("lorem ipsum");

      File("$dirPath\\file_2.txt").createSync();

      File("$dirPath\\file_3.txt")
        ..createSync()
        ..writeAsStringSync("dolor\nest");

      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "2");
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
        "lorem ipsum\n"
        "dolor\n"
        "est\n",
      );
    });

    test("Обработка исключения - файл не существует", () async {
      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "2");
        yield ("Exception: Файл $dirPath\\file_1.txt не существует", null);
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
