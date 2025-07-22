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

  // Convert Employee object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'salary': salary,
    };
  }

  // Create an Employee object from JSON
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      salary: json['salary'],
    );
  }
}