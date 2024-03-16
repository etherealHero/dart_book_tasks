@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_4/src/lab_7/task_1/resident.dart";
import "package:chapter_4/src/lab_7/task_1/room.dart";
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

  test("Класс комната общежития. Интеграционное тестирование", () async {
    testCase() sync* {
      yield ("Номер Лабораторной работы 7 или 8: ", "7");
      yield ("Введите номер задания: ", "1");
      yield ("В комнату заселен студент maxim", null);
      yield ("В комнату заселен студент petr", null);
      yield ("В комнате нет мест для студента alice", null);
      yield ("==============", null);
      yield ("Вместимость комнаты: 2", null);
      yield ("Количество проживающих: 2", null);
      yield ("Проживающие в комнате: maxim, petr", null);
      yield ("==============", null);
      yield ("В комнате не проживает студент alex", null);
      yield ("Студент petr выселен из комнаты", null);
      yield ("В комнату заселен студент alice", null);
      yield ("В комнату заселен комендант alex", null);
      yield ("==============", null);
      yield ("Вместимость комнаты: 2", null);
      yield ("Количество проживающих: 3", null);
      yield ("Проживающие в комнате: maxim, alice, alex", null);
      yield ("==============", null);
    }

    var io = testCase().iterator;

    await for (String output in stream) {
      if (io.moveNext()) {
        var (String expectedOutput, String? input) = io.current;
        expect(output, expectedOutput);
        if (input != null) process.stdin.writeln(input);
      } else {
        process.kill();
      }
    }

    checkTestCaseFulfilled(io);

    var exitCode = await process.exitCode;
    expect(exitCode, 0, reason: "Ожидалось завершение программы");
  });

  test("Комната после создания пустая", () {
    var room = Room(10);

    expect(
      room.currentResidentCount,
      0,
      reason: "Ожидалось пустая комната",
    );
  });

  test("Нельзя в комнату заселить студента, который уже заселен", () {
    var room = Room(10);
    var person1 = Person("Person 1");

    room.populate(person1);
    room.populate(person1);

    expect(
      room.currentResidentCount,
      1,
      reason: "Ожидалась комната с 1 студентом",
    );
  });

  test("Невозможно выселить студента, который не проживает в комнате", () {
    var room = Room(10);
    var person1 = Person("Person 1");
    var person2 = Person("Person 2");

    room.populate(person1);

    expect(
      () => room.evict(person2),
      throwsA(isA<PersonNotLivesInRoomError>()),
    );
  });

  test("Нельзя поселить студетов больше, чем имеется мест", () {
    var room = Room(1);
    var person1 = Person("Person 1");
    var person2 = Person("Person 2");

    room.populate(person1);
    room.populate(person2);

    expect(room.currentResidentCount, 1);
  });
}
