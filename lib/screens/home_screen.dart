import 'package:employee_api/models/employee_model.dart';
import 'package:flutter/material.dart';
import '../services/supabase_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();

  late List<Map<String, dynamic>> _employees = [];

  Future<void> fetchEmployee() async {
    final response = await SupabaseProvider.client
        .from('Employee')
        .select()
        .order('id', ascending: true);

    for (var i in response as List) {
      final data = Employee.fromMap(i);

      _employees.add({
        'id': data.id,
        'name': data.name,
        'age': data.age,
        'salary': data.salary,
      });
    }
    setState(() {});
  }

  Future<void> updateEmployee(
    dynamic id,
    String name,
    int age,
    int salary,
  ) async {
    await SupabaseProvider.client
        .from('Employee')
        .update({'name': name, 'age': age, 'salary': salary})
        .eq('id', id);
  }

  void openEditDialog(dynamic selectEmployeeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Employee'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (value) => value!.isEmpty ? 'Enter age' : null,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  validator: (value) => value!.isEmpty ? 'Enter salary' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _employees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_employees[index]['name']),
                    subtitle: Text(
                      'Age: ${_employees[index]['age']}, Salary: ${_employees[index]['salary']}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
