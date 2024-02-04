import 'dart:io';

import 'package:chapter_1/shared/client_message.dart';
import 'package:chapter_1/tasks/task_1.dart';
import 'package:chapter_1/tasks/task_2.dart';
import 'package:chapter_1/tasks/task_3.dart';
import 'package:chapter_1/tasks/task_4.dart';

void start(List<String> arguments) {
  stdout.write("Введите номер задания: ");
  // String? task = stdin.readLineSync();

  switch (4) {
    case 1:
      task_1(arguments);
      break;
    case 2:
      task_2(arguments);
      break;
    case 3:
      task_3(arguments);
      break;
    case 4:
      task_4(arguments);
      break;
    default:
      ClientMessage().errorInputData();
  }
}
