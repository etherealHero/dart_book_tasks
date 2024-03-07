import 'package:test/test.dart';

/// Проверяет генераторную функцию тест-кейса на признак завершенности
/// ожидаемого вывода-ввода. Использовать внутри test() т.к. использует expect()
void checkTestCaseFulfilled(Iterator<(String, String?)> io) {
  String? fallenStep;
  if (io.moveNext()) fallenStep = io.current.toString();
  expect(fallenStep, isNull, reason: "Ожидался вывод-ввод: $fallenStep");
}
