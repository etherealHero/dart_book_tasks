import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
8. Напишите приложение, позволяющее пользователю вводить Map<int,
String> и строку А. Удалите все элементы значения которых начинаются с
подстроки А и выведите в терминал полученный результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите ключи объекта в числах: ");
  List<int> keys =
      stdin.readLineSync()!.split(" ").map((e) => int.parse(e)).toList();

  stdout.write("Введите значения объекта цельными строками: ");
  List<String> values = stdin.readLineSync()!.split(" ").toList();

  stdout.write("Введите строку А: ");
  String strA = stdin.readLineSync()!;

  Map<int, String> map = Map.fromIterables(keys, values)
    ..removeWhere((key, value) => value.startsWith(strA));

  stdout.writeln(map);
}
