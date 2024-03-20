class Pizzeria {
  late String name;
  late String location;
  late List<Pizza> menu;

  Pizzeria({
    required this.name,
    required this.location,
    required this.menu,
  });

  factory Pizzeria.fromJson(Map<String, dynamic> json) {
    assert(json.containsKey('name'));
    assert(json.containsKey('location'));
    assert(json.containsKey('menu'));

    return Pizzeria(
      name: json['name'],
      location: json['location'],
      menu: List<Pizza>.from(
        json['menu'].map((e) => Pizza.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'location': location,
        'menu': menu,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write('Pizzeria{name: $name, location: $location, ');
    sb.write('menu: $menu}');
    return sb.toString();
  }
}

class Pizza {
  late String name;
  late double price;
  late Ingredients ingridients;
  late bool isVegetarian;
  late bool isSpicy;
  late String? specialInstructions;

  Pizza({
    required this.name,
    required this.price,
    required this.ingridients,
    required this.isVegetarian,
    required this.isSpicy,
    required this.specialInstructions,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      name: json['name'],
      price: json['price'],
      ingridients: Ingredients.fromJson(json['ingredients']),
      isVegetarian: json['is_vegetarian'],
      isSpicy: json['is_spicy'],
      specialInstructions: json['special_instructions'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'ingredients': ingridients,
        'is_vegetarian': isVegetarian,
        'is_spicy': isSpicy,
        'special_instructions': specialInstructions,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write("Pizza{name: $name, price: $price, ");
    sb.write("ingridients: $ingridients, isVegetatian: $isVegetarian, ");
    sb.write("isSpicy: $isSpicy, specialInstructions: $specialInstructions}");
    return sb.toString();
  }
}

class Ingredients {
  final List<String> ingredients;

  Ingredients(this.ingredients);

  factory Ingredients.fromJson(List<dynamic> json) {
    return Ingredients(json.map((e) => e as String).toList());
  }

  List<dynamic> toJson() => ingredients;

  @override
  String toString() {
    return ingredients.toString();
  }
}
