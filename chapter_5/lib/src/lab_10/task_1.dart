/*
Каждое задание должно сопровождаться минимум пятью
тестами и содержать хотя бы одно исключение.
*/
import '/src/shared.dart';

var task = Task("""
Дан файл, содержащий данные в JSON-формате. Напишите
приложение, позволяющее осуществить из него загрузку, изменить
некоторые значения и сохранить текущее состояние экземпляров классов в
новый файл в JSON-формате.
{
  "pizzeria": {
  "name": "Pizza World",
  "location": "789 Pine Street",
  "menu": [
      {
        "name": "Margherita",
        "price": 10.99,
        "ingredients": [
          "tomato",
          "mozzarella",
          "basil"
        ],
        "is_vegetarian": true,
        "is_spicy": false,
        "special_instructions": "Extra cheese available upon request"
      },
      {
        "name": "Pepperoni",
        "price": 12.99,
        "ingredients": [
            "tomato",
            "mozzarella",
            "pepperoni"
        ],
        "is_vegetarian": false,
        "is_spicy": true,
      }
    ]
  }
} 

""", execute);

void execute(List<String> arguments) {}
