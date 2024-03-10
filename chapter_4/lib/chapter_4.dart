import 'dart:io';
import '/src/shared.dart';
import '/src/lab_7/index.dart' as lab_7;
import '/src/lab_8/index.dart' as lab_8;

final List<Tasks> _labs = [lab_7.tasks, lab_8.tasks];

void execute(List<String> arguments) {
  try {
    stdmsg.selectLab();
    int labNumber = int.parse(stdin.readLineSync()!);

    if (![7, 8].contains(labNumber)) throw Error();

    stdmsg.selectTask();
    int taskNumber = int.parse(stdin.readLineSync()!) - 1;

    _labs[labNumber - 7].execute(taskNumber, arguments);
  } catch (e) {
    stdmsg.raiseError();
    // rethrow;
  }
}
