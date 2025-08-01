import 'dart:convert';

class Employee {
  final int? id;
  final String name;
  final int age;
  final int salary;

  Employee({
    this.id,
    required this.name,
    required this.age,
    required this.salary,
  });

  // Converts Employee instance to a JSON string
  String toJson() {
    final data = {
      'id': id,
      'name': name,
      'age': age,
      'salary': salary,
    };
    return json.encode(data);
  }

  // Converts JSON string to Employee instance
  factory Employee.fromJson(Map<String, dynamic> data) {
    return Employee(
      id: data['id'],
      name: data['name'],
      age: data['age'],
      salary: data['salary'],
    );
  }
}