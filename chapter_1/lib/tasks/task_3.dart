/*
1. Напишите приложение, позволяющее пользователю вводить список
целочисленных значений. Удалите все дублирующиеся значения и
вычислите сумму оставшихся. Выведите в терминал полученный результат.
*/

import 'dart:io';

void task_3(List<String> arguments) {
  stdout.write("Введите элементы списка через пробел: ");
  String? integersRaw = stdin.readLineSync();
  List<int?> integers =
      List.from(integersRaw!.split(' ').map((e) => int.tryParse(e)));

  integers.removeWhere((e) => e == null);
  integers = [...Set.from(integers)];

  int? sum = integers.reduce((sum, e) => sum! + e!);

  print("Сумма уникальных значений: $sum");
  print("Уникальные значения: $integers");
}
