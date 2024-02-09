import 'dart:io';
import 'package:chapter_1/shared.dart';

var task = Task("""
18. Напишите приложение, позволяющее пользователю вводить два
множества А и В. Найдите разницу В-А и оставьте в получившимся
множестве только те элементы, значения которых <= 10. Выведите в
терминал полученный результат.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите множество A: ");
  Set<int> setA =
      Set.from(stdin.readLineSync()!.split(" ").map((e) => int.parse(e)));

  stdout.write("Введите множество B: ");
  Set<int> setB =
      Set.from(stdin.readLineSync()!.split(" ").map((e) => int.parse(e)));

  Set<int> setBDifferenceSetA =
      setB.difference(setA).where((e) => e <= 10).toSet();

  stdout.writeln(setBDifferenceSetA);
}
