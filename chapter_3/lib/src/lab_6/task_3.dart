import 'dart:io';
import '/src/shared.dart';

var task = Task("""
3. Напишите функцию, на вход которой подается строка. Она должна
возвращать другую функцию, принимающую номер индекса и
возвращающую символ, располагаемый в строке по этому индексу. Если
задаваемый индекс выходит за пределы строки, то верните пустой символ.
Полученный результат выведите в терминал.
""", execute);

void execute(List<String> arguments) {
  stdout.writeln("Введите строку: ");
  String? str = stdin.readLineSync();

  if (str == null || str.isEmpty) {
    return stdmsg.raiseError();
  }

  var stringInspector = createStringInspector(str);

  stdout.writeln("Символ строки по индексу 0: '${stringInspector(0)}'");
  stdout.writeln("Символ строки по индексу 3: '${stringInspector(3)}'");
  stdout.writeln("Символ строки по индексу 5: '${stringInspector(5)}'");
  stdout.writeln("Символ строки по индексу 1000: '${stringInspector(1000)}'");
}

String Function(int) createStringInspector(String str) {
  return (int at) {
    if (str.isEmpty || at >= str.length || at < 0) {
      return "";
    } else {
      return str.substring(at, at + 1);
    }
  };
}
