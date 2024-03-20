import 'package:json_annotation/json_annotation.dart';

part 'pizzeria_pub.g.dart';

@JsonSerializable()
class PizzeriaPub {
  String name;
  String location;
  List<PizzaPub> menu;

  PizzeriaPub({
    required this.name,
    required this.location,
    required this.menu,
  });

  factory PizzeriaPub.fromJson(Map<String, dynamic> json) =>
      _$PizzeriaPubFromJson(json);

  Map<String, dynamic> toJson() => _$PizzeriaPubToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PizzaPub {
  String name;
  double price;
  List<String> ingredients;
  bool isVegetarian;
  bool isSpicy;
  @JsonKey(includeIfNull: false)
  String? specialInstructions;

  PizzaPub({
    required this.name,
    required this.price,
    required this.ingredients,
    required this.isVegetarian,
    required this.isSpicy,
    this.specialInstructions,
  });

  factory PizzaPub.fromJson(Map<String, dynamic> json) =>
      _$PizzaPubFromJson(json);

  Map<String, dynamic> toJson() => _$PizzaPubToJson(this);
}
