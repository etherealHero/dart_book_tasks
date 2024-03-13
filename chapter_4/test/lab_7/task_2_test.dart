@Timeout(Duration(seconds: 3))

import "dart:convert";
import "dart:io";
import "package:chapter_4/src/lab_7/task_2/product.dart";
import "package:chapter_4/src/lab_7/task_2/scale.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  late Process process;
  late Stream<String> stream;

  setUp(() async {
    process = await Process.start(
      "dart",
      ['run', '${Directory.current.path}\\bin\\chapter_4.dart'],
    );
    stream = process.stdout.transform(utf8.decoder).transform(LineSplitter());
  });

  tearDown(() => process.kill());

  test("Класс весы. Интеграционное тестирование", () async {
    testCase() sync* {
      yield ("Номер Лабораторной работы 7 или 8: ", "7");
      yield ("Введите номер задания: ", "2");
      yield ("Добавлен продукт carrot", null);
      yield ("Добавлен продукт apple", null);
      yield ("Добавлен продукт carrot", null);
      yield ("Продукт cherry невозможно добавить. Достигнут лимит веса", null);
      yield ("Максимальный вес: 10.0", null);
      yield ("Итоговый вес: 9.0", null);
      yield ("Продукты на весах:", null);
      yield ("\tvegetable carrot, вес за 1 ед. - 2.0, цена - 12.5", null);
      yield ("\tfruit apple, вес за 1 ед. - 5.0, цена - 20.0", null);
      yield ("\tvegetable carrot, вес за 1 ед. - 2.0, цена - 12.5", null);
      yield ("Вес овощей на весах: 4.0", null);
      yield (
        "Продукт с минимальной ценой: vegetable carrot, "
            "вес за 1 ед. - 2.0, цена - 12.5",
        null
      );
      yield (
        "Продукт с максимальным весом: fruit apple, "
            "вес за 1 ед. - 5.0, цена - 20.0",
        null
      );
    }

    var io = testCase().iterator;

    await for (String output in stream) {
      if (io.moveNext()) {
        var (String expectedOutput, String? input) = io.current;
        expect(output, expectedOutput);
        process.stdin.writeln(input);
      } else {
        process.kill();
      }
    }

    checkTestCaseFulfilled(io);

    var exitCode = await process.exitCode;
    expect(exitCode, 0, reason: "Ожидалось завершение программы");
  });

  test("Вессы после создания пустые", () {
    var scale = Scale(maxWeight: 10.0);

    expect(scale.currentWeight, 0.0, reason: "Ожидались пустые весы");
  });

  test("Нельзя переполнить весы", () {
    var scale = Scale(maxWeight: 10.0);
    var carrot = Product(
      name: "carrot",
      productType: ProductType.vegetable,
      weight: 2.0,
      price: 12.5,
    );
    var apple = Product(
      name: "apple",
      productType: ProductType.fruit,
      weight: 5.0,
      price: 20.0,
    );
    var cherry = Product(
      name: "cherry",
      productType: ProductType.berry,
      weight: 4.0,
      price: 20.0,
    );

    scale.addProduct(carrot);
    scale.addProduct(apple);
    scale.addProduct(carrot);

    expect(
      () => scale.addProduct(cherry),
      throwsA(isA<ScaleMaxWeightRangeError>()),
    );
  });

  test("Продукт с минимальной ценой на весах", () {
    var scale = Scale(maxWeight: 10.0);
    var carrot = Product(
      name: "carrot",
      productType: ProductType.vegetable,
      weight: 2.0,
      price: 12.5,
    );
    var apple = Product(
      name: "apple",
      productType: ProductType.fruit,
      weight: 5.0,
      price: 20.0,
    );

    scale.addProduct(carrot);
    scale.addProduct(apple);

    expect(
      scale.getProductWithMinPrice(),
      carrot,
    );
  });

  test("Продукт с максимальным весом за 1 ед. на весах", () {
    var scale = Scale(maxWeight: 10.0);
    var carrot = Product(
      name: "carrot",
      productType: ProductType.vegetable,
      weight: 2.0,
      price: 12.5,
    );
    var apple = Product(
      name: "apple",
      productType: ProductType.fruit,
      weight: 5.0,
      price: 20.0,
    );

    scale.addProduct(carrot);
    scale.addProduct(apple);

    expect(
      scale.getProductWithMaxWeight(),
      apple,
    );
  });
}
