/*
Каждое задание должно сопровождаться минимум пятью
тестами и содержать хотя бы одно исключение.
*/
import 'dart:convert';
import 'dart:io';

import 'pizzeria.dart';
import 'pizzeria_pub.dart';

import '/src/shared.dart';

var task = Task("""
Дан файл, содержащий данные в JSON-формате (bin\\lab_10\\pizzeria.json). Напишите
приложение, позволяющее осуществить из него загрузку, изменить
некоторые значения и сохранить текущее состояние экземпляров классов в
новый файл в JSON-формате.
""", execute);

void execute(List<String> arguments) {
  var filePath = 'bin\\lab_10\\pizzeria.json';
  var fileOutputPath = 'bin\\lab_10\\file_output.json';
  var fileOutputPubPath = 'bin\\lab_10\\file_output_pub.json';
  var file = File(filePath);

  if (!file.existsSync()) {
    stdout.writeln(
      "Файл $filePath не существует. Завершение программы",
    );

    return;
  }

  Map<String, dynamic> json = jsonDecode(file.readAsStringSync());
  var encoder = JsonEncoder.withIndent("  ");

  var pizzeria = Pizzeria.fromJson(json['pizzeria']);
  var pizzeriaPub = PizzeriaPub.fromJson(json['pizzeria']);

  pizzeria.name = 'Pizza NewWorld';
  pizzeria.location = '110 Street';
  pizzeria.menu[0].price += 2.0;
  pizzeria.menu[0].ingridients.ingredients.add('cheese');

  pizzeriaPub.name = 'Pizza NewWorld';
  pizzeriaPub.location = '110 Street';
  pizzeriaPub.menu[0].price += 2.0;
  pizzeriaPub.menu[0].ingredients.add('cheese');

  File(fileOutputPath).writeAsStringSync(encoder.convert(pizzeria));
  File(fileOutputPubPath).writeAsStringSync(encoder.convert(pizzeriaPub));
  stdout.writeln(
    "Данные записаны в файл: "
    "1) $fileOutputPath, "
    "2) $fileOutputPubPath",
  );
}
