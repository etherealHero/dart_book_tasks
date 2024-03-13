import 'dart:io';

import 'package:chapter_4/src/lab_7/task_2/product.dart';

class ScaleMaxWeightRangeError implements Exception {
  final String? msg;

  const ScaleMaxWeightRangeError([this.msg]);
}

class Scale {
  final double _maxWeight;
  final List<Product> _products = [];

  double get maxWeight => _maxWeight;

  double get currentWeight {
    if (_products.isEmpty) return 0.0;

    return _products
        .map(
          (p) => p.weight,
        )
        .reduce(
          (sum, pw) => sum + pw,
        );
  }

  Scale({required double maxWeight}) : _maxWeight = maxWeight;

  void addProduct(Product product) {
    if (currentWeight + product.weight > _maxWeight) {
      throw ScaleMaxWeightRangeError(
        "Продукт ${product.name} невозможно добавить. "
        "Достигнут лимит веса",
      );
    }

    stdout.writeln("Добавлен продукт ${product.name}");
    _products.add(product);
  }

  Product removeProduct() {
    return _products.removeLast();
  }

  List<Product> sortByPrice(Product product) {
    _products.sort((p1, p2) => p1.price.compareTo(p2.price));
    return _products;
  }

  List<Product> sortByWeight(Product product) {
    _products.sort((p1, p2) => p1.weight.compareTo(p2.weight));
    return _products;
  }

  Product? getProductWithMinPrice() {
    Product productWithMinPrice;

    if (_products.isNotEmpty) {
      productWithMinPrice = _products[0];
    } else {
      return null;
    }

    for (var p in _products) {
      if (p.price < productWithMinPrice.price) {
        productWithMinPrice = p;
      }
    }

    return productWithMinPrice;
  }

  Product? getProductWithMaxWeight() {
    Product productWithMaxWeight;

    if (_products.isNotEmpty) {
      productWithMaxWeight = _products[0];
    } else {
      return null;
    }

    for (var p in _products) {
      if (p.weight > productWithMaxWeight.weight) {
        productWithMaxWeight = p;
      }
    }

    return productWithMaxWeight;
  }

  double getTotalWeightByProductType(ProductType productType) {
    var productsByType = _products.where((p) => p.productType == productType);

    if (productsByType.isEmpty) return 0.0;

    return productsByType
        .map(
          (p) => p.weight,
        )
        .reduce(
          (sum, pw) => sum + pw,
        );
  }

  @override
  String toString() {
    if (_products.isEmpty) {
      return "\tВесы пустые";
    } else {
      return "\t${_products.join("\n\t")}";
    }
  }
}
