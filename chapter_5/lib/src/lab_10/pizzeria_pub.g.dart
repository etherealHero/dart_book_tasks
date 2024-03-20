// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizzeria_pub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PizzeriaPub _$PizzeriaPubFromJson(Map<String, dynamic> json) => PizzeriaPub(
      name: json['name'] as String,
      location: json['location'] as String,
      menu: (json['menu'] as List<dynamic>)
          .map((e) => PizzaPub.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PizzeriaPubToJson(PizzeriaPub instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'menu': instance.menu,
    };

PizzaPub _$PizzaPubFromJson(Map<String, dynamic> json) => PizzaPub(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isVegetarian: json['is_vegetarian'] as bool,
      isSpicy: json['is_spicy'] as bool,
      specialInstructions: json['special_instructions'] as String?,
    );

Map<String, dynamic> _$PizzaPubToJson(PizzaPub instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'price': instance.price,
    'ingredients': instance.ingredients,
    'is_vegetarian': instance.isVegetarian,
    'is_spicy': instance.isSpicy,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('special_instructions', instance.specialInstructions);
  return val;
}
