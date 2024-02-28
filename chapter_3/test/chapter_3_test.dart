import "dart:convert";
import "dart:io";
import "package:async/async.dart";
import "package:test/test.dart";

void main() {
  test("Выбор номера Лабораторной работы", () async {
    var process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_3.dart'],
    );

    var stdoutSplitter = StreamSplitter(
      process.stdout
          .transform(
            utf8.decoder,
          )
          .transform(
            const LineSplitter(),
          ),
    );

    process.stdin.writeln("4");
    process.stdin.writeln("1");
    process.stdin.writeln("1 13 28 2 -10");

    var taskOutput = await stdoutSplitter.split().first;
    expect(
      taskOutput,
      "Номер Лабораторной работы 4, 5, или 6: "
      "Введите номер задания: "
      "Введите целочисленный список: "
      "28",
    );

    var exitCode = await process.exitCode;
    expect(exitCode, 0);
  });
}
