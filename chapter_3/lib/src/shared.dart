import 'dart:io';

class _ClientMessage {
  void raiseError() {
    stdout.writeln("Неверные входные данные");
  }

  void selectLab() {
    stdout.writeln("Номер Лабораторной работы 4, 5, или 6: ");
  }

  void selectTask() {
    stdout.writeln("Введите номер задания: ");
  }
}

var stdmsg = _ClientMessage();

class Task {
  final String description;
  final void Function(List<String> arguments) cb;

  Task(this.description, this.cb);

  void execute(List<String> arguments) {
    // print(description);
    cb(arguments);
  }
}

class Tasks {
  Tasks(this.tasks);

  final List<Task> tasks;

  void execute(int taskNumber, List<String> arguments) {
    tasks[taskNumber].execute(arguments);
  }
}
