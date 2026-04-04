import 'dart:ffi';

import 'package:hotuanphuoc_2224802010872_lab1_2/hotuanphuoc_2224802010872_lab1_2.dart' as hotuanphuoc_2224802010872_lab1_2;

void main() {
  var name = 'Scirivas';
  int age = 20;
  double height = 5.9;
  bool isAdult = (age > 18 ? true : false);
  
  print( 'Name: $name');
  print( 'Age: $age');
  print( 'Height: $height');

  // conditional statement
  if(isAdult) {
    print('$name is an adult.');
  } else {
    print('$name is not an adult.');
  }

  // loop
  for (var i = 0; i <= 5; i++) {
    print('Loop iteration: $i');
    if(i==3) break;
  }
  List<String> friends = ['Bhanu', 'Amar', 'Amulya','Kiran','Sandeep', 'Phước'];

  for(String friend in friends) {
    print('Friend: $friend');
  }
   

  greet(name);
  var person = Person(name, age, height);
  person.introduce();


  try {
    int result = 10 ~/ 0; 
    print('Result: $result');
  } catch (e) {
    print('An error occurred: $e');
  }
}

void greet(String name) {
  print('Welcome to SDC, $name!');
}
class Person {
  String name;
  int age;
  double height;
  bool isAdult;
  Person(this.name, this.age, this.height) : isAdult = age > 18;
  

  void introduce() {
    print('Hi, I am $name and I am $age years old and my height is $height feet.');
  }
}