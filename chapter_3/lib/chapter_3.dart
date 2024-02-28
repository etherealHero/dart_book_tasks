import 'dart:io';
import 'package:chapter_3/src/shared.dart';
import 'package:chapter_3/src/lab_4/index.dart' as lab_4;
import 'package:chapter_3/src/lab_5/index.dart' as lab_5;
import 'package:chapter_3/src/lab_6/index.dart' as lab_6;

final List<Tasks> _labs = [lab_4.tasks, lab_5.tasks, lab_6.tasks];

void execute(List<String> arguments) {
  // int labNumber = 4;
  // int taskNumber = 1;

  // labs[labNumber - 4].execute(taskNumber - 1, arguments);
  // return;

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
