enum ProductType { vegetable, fruit, berry }

extension ParseToString on ProductType {
  String toShortString() {
    return toString().split('.').last;
  }
}

class Product {
  String name;
  ProductType productType;
  double weight;
  double price;

  Product({
    required this.name,
    required this.productType,
    required this.weight,
    required this.price,
  });

  @override
  String toString() {
    return "${productType.toShortString()} $name, вес за 1 ед. - $weight, цена - $price";
  }
}
