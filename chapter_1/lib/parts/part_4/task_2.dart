import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
7. Напишите приложение, позволяющее пользователю вводить 2 объекта
Map<int, int>. Объедините введенные структуры данных и выведите в
терминал полученный результат, а также количество хранимых в новом
объекте элементов.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите ключи объекта А числами: ");
  List<int> keysA =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите значения объекта А числами: ");
  List<int> valuesA =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите ключи объекта B числами: ");
  List<int> keysB =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите значения объекта B числами: ");
  List<int> valuesB =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  Map<int, int> objectA = Map.fromIterables(keysA, valuesA);
  Map<int, int> objectB = Map.fromIterables(keysB, valuesB);
  Map<int, int> mergeObjects = {}
    ..addAll(objectA)
    ..addAll(objectB);

  stdout.writeln(mergeObjects);
  stdout.writeln("Количество элементов: ${mergeObjects.keys.length}");
}
