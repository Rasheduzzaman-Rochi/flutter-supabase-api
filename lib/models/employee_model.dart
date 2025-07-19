class Employee {
  final int? id;
  final String name;
  final int age;
  final double salary;

  Employee({
    this.id,
    required this.name,
    required this.age,
    required this.salary,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'salary': salary,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      salary: map['salary'],
    );
  }
}