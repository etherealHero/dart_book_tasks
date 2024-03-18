@Timeout(Duration(seconds: 3))

import "dart:io";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  const String dirPath = 'bin\\task_3';
  const String outputFile = 'file_output.txt';

  late void Function() tearDownEnv;
  late Process process;
  late Stream<String> stream;

  setUp(() => (tearDownEnv) = setUpEnv(dirPath));

  tearDown(() {
    tearDownEnv();
    process.kill();
  });

  group("Подсчет гласных и согласных в файле", () {
    test("Гласная 'е' и согласная 'в'", () async {
      File("$dirPath\\file.txt")
        ..createSync()
        ..writeAsStringSync(
          "Села муха на варенье,\n"
          "вот и всё стихотворенье!\n",
        );

      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "3");
        yield ("Гласная: е", null);
        yield ("Согласная: в", null);
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
        "Гласная: е\n"
        "Согласная: в",
      );
    });

    test("Обработка исключения - файл не существует", () async {
      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "9");
        yield ("Введите номер задания: ", "3");
        yield ("Exception: Файл $dirPath\\file.txt не существует", null);
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
