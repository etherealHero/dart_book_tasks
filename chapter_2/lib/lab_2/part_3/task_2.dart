import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
3. На вход подается список, минимум из 6 элементов. Если его первый и
последний элементы равны, то выведите в терминал «True», иначе «False»
(без кавычек). Реализуйте 3 версии программы с разными подходами.
""", execute);

void execute(List<String> arguments) {
  stdout.write("Введите список минимум из 6 элементов: ");
  String? listRaw = stdin.readLineSync();
  List<String> list;

  if (listRaw == null || listRaw.isEmpty) {
    return ClientMessage().errorInputData();
  }

  list = listRaw.split(" ");

  stdout.writeln(switch (list) {
    [String first, ...List<String> other, String last]
        when first == last && other.length >= 4 =>
      "True",
    [String first, ...List<String> other, String last]
        when first != last && other.length >= 4 =>
      "False",
    _ => "Неверные входные данные"
  });

  if (list case [String first, ...List<String> other, String last]
      when first == last && other.length >= 4) {
    stdout.writeln("True");
  } else if (list case [String first, ...List<String> other, String last]
      when first != last && other.length >= 4) {
    stdout.writeln("False");
  } else {
    stdout.writeln("Неверные входные данные");
  }

  if (list.length >= 6 && list.first == list.last) {
    stdout.writeln("True");
  } else if (list.length >= 6 && list.first != list.last) {
    stdout.writeln("False");
  } else {
    stdout.writeln("Неверные входные данные");
  }
}
