import 'dart:io';
import 'package:chapter_2/shared.dart';

var task = Task("""
Используя деструктурирование организуйте извлечение значений из
объекта Map или List:
9
{
 "nickname": "Alex",
 "age": 35,
 "course": 2,
 "teacher": {
    "name": "Max",
    "age": 40,
    "courses": [
        1,
        2,
        3
    ]
 }
}
Извлеките список courses, nickname и возраст
преподавателя. Выведите в терминал полученный
результат.
""", execute);

void execute(List<String> arguments) {
  var map = {
    "nickname": "Alex",
    "age": 35,
    "course": 2,
    "teacher": {
      "name": "Max",
      "age": 40,
      "courses": [1, 2, 3]
    }
  };

  var {"course": course, "nickname": nickname, "age": age} = map;

  stdout.writeln("course: $course, nickname: $nickname, age: $age");
}
