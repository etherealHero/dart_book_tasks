import 'dart:io';
import 'dart:math';
import 'package:chapter_2/shared.dart';

var task = Task("""
12 <1..z>(sqrt(n + sqrt(n^n)) / 7)
""", execute);

void execute(List<String> arguments) {
  stdout.write("<1..z>(sqrt(n + sqrt(n^n)) / 7) Введите z и n через пробел: ");
  String? argsRaw = stdin.readLineSync();

  if (argsRaw == null) return ClientMessage().errorInputData();

  var [int? zRaw, int? nRaw] =
      argsRaw.split(" ").map((e) => int.tryParse(e)).toList();

  if (zRaw == null || nRaw == null) return ClientMessage().errorInputData();

  stdout.writeln("<1..z>(sqrt(n + sqrt(n^n)) / 7) "
      "= ${(sqrt(nRaw + sqrt(pow(nRaw, nRaw))) / 7) * zRaw}"
      ", при z = $zRaw и  n = $nRaw");
}
