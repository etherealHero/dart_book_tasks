import 'dart:io';
import 'package:chapter_2/shared.dart';
import 'package:chapter_2/lab_2/index.dart' as lab_2;
import 'package:chapter_2/lab_3/index.dart' as lab_3;

void start(List<String> arguments) {
  // int labNumber = 2;
  // int partNumber = 1;
  // int taskNumber = 1;

  // if (labNumber == 2) {
  //   lab_2.parts.execute(partNumber - 1, taskNumber - 1, arguments);
  // } else if (labNumber == 3) {
  //   lab_3.parts.execute(partNumber - 1, taskNumber - 1, arguments);
  // }

  // return;

  try {
    stdout.write("Лабораторная работа №2 (0)"
        " или Лабораторная работа №3 (1): ");
    int labNumber = int.parse(stdin.readLineSync()!);

    stdout.write("Введите номер части: ");
    int partNumber = int.parse(stdin.readLineSync()!) - 1;

    stdout.write("Введите номер задания: ");
    int taskNumber = int.parse(stdin.readLineSync()!) - 1;

    if (labNumber == 0) {
      lab_2.parts.execute(partNumber, taskNumber, arguments);
    } else if (labNumber == 1) {
      lab_3.parts.execute(partNumber, taskNumber, arguments);
    } else {
      throw Error();
    }
  } catch (e) {
    ClientMessage().errorInputData();
  }
}
