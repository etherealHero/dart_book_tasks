import 'dart:io';

import 'package:chapter_6/chapter_6.dart';

void main(List<String> arguments) {
  task_1();
}

task_1() async {
  try {
    await copyFileByStream("bin\\lab_11.txt");
    await copyFileByFuture("bin\\lab_11.txt");
  } on FileSystemException catch (e) {
    stdout.writeln(e);
    stdout.writeln("Exit program");
  }
}
