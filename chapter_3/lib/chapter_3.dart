import 'dart:io';
import '/src/shared.dart';
import '/src/lab_4/index.dart' as lab_4;
import '/src/lab_5/index.dart' as lab_5;
import '/src/lab_6/index.dart' as lab_6;

final List<Tasks> _labs = [lab_4.tasks, lab_5.tasks, lab_6.tasks];

void execute(List<String> arguments) {
  try {
    stdmsg.selectLab();
    int labNumber = int.parse(stdin.readLineSync()!);

    if (![4, 5, 6].contains(labNumber)) throw Error();

    stdmsg.selectTask();
    int taskNumber = int.parse(stdin.readLineSync()!) - 1;

    _labs[labNumber - 4].execute(taskNumber, arguments);
  } catch (e) {
    stdmsg.raiseError();
  }
}
