import 'dart:io';
import 'dart:math';
import '/src/shared.dart';

var task = Task("""
22. Пользователь вводит с клавиатуры две Map<String, int> (point1 и
point2) вида: {'х' : 10, 'у' : 13}. Напишите функцию, которая возвращает
значение расстояния между заданными точками. Аргумент функции point2
должен иметь следующее значение по умолчанию {'х' : -7, 'у' : 3}, на случай
если пользователь введет не две Map. Полученный результат выведите в
терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите название осей точки 1: ");
  String? axisPointOneRaw = stdin.readLineSync();

  if (axisPointOneRaw == null || axisPointOneRaw != "x y") {
    return stdmsg.raiseError();
  }

  stdout.writeln("Введите значение осей точки 1: ");
  String? coordsPointOneRaw = stdin.readLineSync();

  if (coordsPointOneRaw == null ||
      coordsPointOneRaw.split(" ").indexWhere((e) => int.tryParse(e) == null) !=
          -1 ||
      coordsPointOneRaw.split(" ").length != 2) {
    return stdmsg.raiseError();
  }

  stdout.writeln("Введите название осей точки 2: ");
  String? axisPointTwoRaw = stdin.readLineSync();

  if (axisPointTwoRaw == null || !["x y", ""].contains(axisPointTwoRaw)) {
    return stdmsg.raiseError();
  }

  stdout.writeln("Введите значение осей точки 2: ");
  String? coordsPointTwoRaw = stdin.readLineSync();

  if (coordsPointTwoRaw == null) {
    return stdmsg.raiseError();
  }

  if (coordsPointTwoRaw.isNotEmpty &&
      (coordsPointTwoRaw
                  .split(" ")
                  .indexWhere((e) => int.tryParse(e) == null) !=
              -1 ||
          coordsPointTwoRaw.split(" ").length != 2)) {
    return stdmsg.raiseError();
  }

  Map<String, int> pointOne = Map.fromIterables(axisPointOneRaw.split(" "),
      coordsPointOneRaw.split(" ").map((e) => int.parse(e)));
  Map<String, int> pointTwo;

  if (axisPointTwoRaw.isEmpty && coordsPointTwoRaw.isEmpty) {
    pointTwo = Map.fromIterables(["x", "y"], [-7, 3]);
  } else {
    pointTwo = Map.fromIterables(axisPointTwoRaw.split(" "),
        coordsPointTwoRaw.split(" ").map((e) => int.parse(e)));
  }

  stdout
      .writeln("Расстояние между точками: ${getDistance(pointOne, pointTwo)}");
}

double getDistance(Map<String, int> pointOne, Map<String, int> pointTwo) {
  return sqrt(pow(pointTwo["x"]! - pointOne["x"]!, 2) +
      pow(pointTwo["y"]! - pointOne["y"]!, 2));
}
