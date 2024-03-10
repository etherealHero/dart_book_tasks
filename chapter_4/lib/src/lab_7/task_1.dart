/*
Каждое задание должно сопровождаться минимум пятью
тестами и содержать хотя бы одно исключение.
*/
import 'dart:io';
import './task_1/resident.dart';
import './task_1/room.dart';

import '/src/shared.dart';

var task = Task("""
1. Реализуйте класс «Комната общежития». В нем должна храниться
следующая информация: количество проживающих студентов,
максимальный размер комнаты (количество кроватей) и текущий размер
комнаты. При добавлении экземпляра класса «Студент», проверяется, если
количество проживающих студентов превышает максимальный размер
комнаты, должна выводиться ошибка. На коменданта, даже в случае
переполнения комнаты, такие ограничения не должны действовать. Также
реализуйте возможность вывода текущих состояний объектов в терминал.
""", execute);

void execute(List<String> arguments) {
  var maxim = Person('maxim');
  var petr = Person('petr');
  var alice = Person('alice');
  var alex = Person('alex');

  var room = Room(2);

  room.populate(maxim);
  room.populate(petr);
  room.populate(alice);

  stdout.writeln(room.getInfo());

  room.evict(alex);
  room.evict(petr);
  room.populate(alice);
  room.populate(alex, isGovernor: true);

  stdout.writeln(room.getInfo());
}
