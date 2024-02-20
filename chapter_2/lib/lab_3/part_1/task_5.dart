import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
21 <1..z>((2n^2 - 4n + 10) / (2n))
""", execute);

void execute(List<String> arguments) {
  stdout.write("<1..z>(sqrt(n + sqrt(n^n)) / 7) Введите z и n через пробел: ");
  String? argsRaw = stdin.readLineSync();

  if (argsRaw == null) return ClientMessage().errorInputData();

  var [int? zRaw, int? nRaw] =
      argsRaw.split(" ").map((e) => int.tryParse(e)).toList();

  if (zRaw == null || nRaw == null) return ClientMessage().errorInputData();

  stdout.writeln("<1..z>((2n^2 - 4n + 10) / (2n)) "
      "= ${zRaw * ((2 * nRaw * nRaw - 4 * nRaw + 10) / (2 * nRaw))}"
      ", при z = $zRaw и  n = $nRaw");
}
