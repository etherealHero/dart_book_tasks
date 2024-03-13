import 'dart:io';
import 'package:chapter_4/src/lab_7/task_2/product.dart';
import 'package:chapter_4/src/lab_7/task_2/scale.dart';

import '/src/shared.dart';

var task = Task("""
8. Реализуйте класс Scale (весы) и Product. В конструктор класса Scale
передайте максимальный вес, который они могут выдержать. Также
данный класс должен предоставлять пользователю следующие методы:
добавление и удаление товаров, сортировку товаров по стоимости и весу,
нахождение товара с минимальной стоимостью, товара с максимальным
весом, определение текущего веса всех товаров на весах и общего веса
товаров определенного типа. Если общий вес товаров равен или превышает
максимальный, новые товары не должны добавляться на весы (вывод
оповещения). Также обеспечьте вывод текущего состояния объектов в
терминал.
""", execute);

void execute(List<String> arguments) {
  Scale scale = Scale(maxWeight: 10.0);
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

  try {
    scale.addProduct(cherry);
  } on ScaleMaxWeightRangeError catch (e) {
    stdout.writeln(e.msg);
  }

  stdout.writeln("Максимальный вес: ${scale.maxWeight}");
  stdout.writeln("Итоговый вес: ${scale.currentWeight}");
  stdout.writeln("Продукты на весах:\n$scale");
  stdout.writeln(
    "Вес овощей на весах: "
    "${scale.getTotalWeightByProductType(ProductType.vegetable)}",
  );
  stdout.writeln(
    "Продукт с минимальной ценой: "
    "${scale.getProductWithMinPrice()}",
  );
  stdout.writeln(
    "Продукт с максимальным весом: "
    "${scale.getProductWithMaxWeight()}",
  );
}
