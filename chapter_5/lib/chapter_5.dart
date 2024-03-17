import 'dart:io';
import '/src/shared.dart';
import 'src/lab_9/index.dart' as lab_9;
import 'src/lab_10/index.dart' as lab_10;

final List<Tasks> _labs = [lab_9.tasks, lab_10.tasks];

void execute(List<String> arguments) {
  try {
    stdmsg.selectLab();
    int labNumber = int.parse(stdin.readLineSync()!);

    if (![9, 10].contains(labNumber)) {
      throw ArgumentError.value(
        labNumber,
        "Номер лабораторной работы",
        "Ожидалось значение 9 или 10, текущее",
      );
    }

    stdmsg.selectTask();
    int taskNumber = int.parse(stdin.readLineSync()!) - 1;

    _labs[labNumber - 9].execute(taskNumber, arguments);
  } on ArgumentError catch (e) {
    stdout.writeln(e);
  }
}
