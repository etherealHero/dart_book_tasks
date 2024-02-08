import 'dart:io';

import 'package:chapter_1/shared.dart';
import 'package:chapter_1/parts/index.dart';
import 'package:chapter_1/tasks/index.dart';

void start(List<String> arguments) {
  try {
    stdout.write("Первая задача с каждого раздела (0)"
        " или раздел с задачами по варианту (1): ");
    int isPart = int.parse(stdin.readLineSync()!);

    if (isPart == 1) {
      stdout.write("Введите номер части: ");
      int partNumber = int.parse(stdin.readLineSync()!) - 1;

      stdout.write("Введите номер задания: ");
      int taskNumber = int.parse(stdin.readLineSync()!) - 1;

      parts.execute(partNumber, taskNumber, arguments);
    } else if (isPart == 0) {
      stdout.write("Введите номер задания: ");
      int taskNumber = int.parse(stdin.readLineSync()!) - 1;

      tasks.execute(taskNumber, arguments);
    } else {
      throw Error();
    }
  } catch (e) {
    ClientMessage().errorInputData();
  }
}
