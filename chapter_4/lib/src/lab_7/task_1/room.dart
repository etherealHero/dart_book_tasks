import 'dart:io';

import 'package:chapter_4/src/lab_7/task_1/resident.dart';

class PersonNotLivesInRoomError implements Exception {
  final String? msg;

  const PersonNotLivesInRoomError([this.msg]);
}

class Room {
  final List<Person> _residentList = [];
  final int _maxResidentCount;

  int get currentResidentCount => _residentList.length;
  int get maxResidentCount => _maxResidentCount;
  List<Person> get residents => _residentList;

  Room(this._maxResidentCount);

  List<Person> populate(Person newResident, {bool isGovernor = false}) {
    if (isGovernor) {
      _residentList.add(newResident);
      stdout.writeln('В комнату заселен комендант ${newResident.name}');
    } else if (_residentList.length < _maxResidentCount) {
      if (_residentList.indexWhere((s) => s.name == newResident.name) == -1) {
        _residentList.add(newResident);
        stdout.writeln('В комнату заселен студент ${newResident.name}');
      } else {
        stdout.writeln('В комнате уже заселен этот студент');
      }
    } else {
      stdout.writeln('В комнате нет мест для студента ${newResident.name}');
    }

    return _residentList;
  }

  List<Person> evict(Person resident) {
    if (_residentList.indexWhere((s) => s.name == resident.name) == -1) {
      throw PersonNotLivesInRoomError(
          "В комнате не проживает студент ${resident.name}");
    } else {
      _residentList.removeWhere((s) => s.name == resident.name);
      stdout.writeln('Студент ${resident.name} выселен из комнаты');
    }

    return _residentList;
  }

  String getInfo() {
    return "==============\n"
        "Вместимость комнаты: $maxResidentCount\n"
        "Количество проживающих: $currentResidentCount\n"
        "Проживающие в комнате: ${residents.join(", ")}\n"
        "==============";
  }
}
