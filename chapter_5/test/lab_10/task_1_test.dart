@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  const String dirPath = 'bin\\lab_10';
  const String outputFile = 'file_output.json';
  const String outputPubFile = 'file_output_pub.json';

  late void Function() tearDownEnv;
  late Process process;
  late Stream<String> stream;

  setUp(() => (tearDownEnv) = setUpEnv(dirPath));

  tearDown(() {
    tearDownEnv();
    process.kill();
  });

  group("Класс Сериализация/Десериализация (интеграционный)", () {
    test("Чтение json, изменение, запись", () async {
      File("$dirPath\\pizzeria.json")
        ..createSync()
        ..writeAsStringSync(
          '{"pizzeria":{"name":"Pizza World","location":"789 Pine Street","menu":'
          '[{"name":"Margherita","price":10.99,"ingredients":["tomato","mozzarella","basil"],'
          '"is_vegetarian":true,"is_spicy":false,"special_instructions":"Extra cheese available upon request"},'
          '{"name":"Pepperoni","price":12.99,"ingredients":["tomato","mozzarella","pepperoni"],'
          '"is_vegetarian":false,"is_spicy":true}]}}',
        );

      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "10");
        yield ("Введите номер задания: ", "1");
        yield (
          "Данные записаны в файл: "
              "1) $dirPath\\$outputFile, "
              "2) $dirPath\\$outputPubFile",
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

      expect(
        File("$dirPath\\$outputFile").existsSync(),
        true,
        reason: "Ожидался выходной файл $dirPath\\$outputFile",
      );

      expect(
        File("$dirPath\\$outputPubFile").existsSync(),
        true,
        reason: "Ожидался выходной файл $dirPath\\$outputPubFile",
      );

      expect(
        (jsonDecode(File("$dirPath\\$outputFile").readAsStringSync())
                as Map<String, dynamic>)
            .containsKey('name'),
        true,
      );

      expect(
        (jsonDecode(File("$dirPath\\$outputFile").readAsStringSync())
            as Map<String, dynamic>)['name'],
        'Pizza NewWorld',
      );
    });

    test("Исходный файл не существует", () async {
      (process, stream) = await startProcess();

      testCase() sync* {
        yield ("Номер Лабораторной работы 9 или 10: ", "10");
        yield ("Введите номер задания: ", "1");
        yield (
          "Файл $dirPath\\pizzeria.json не существует. Завершение программы",
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
