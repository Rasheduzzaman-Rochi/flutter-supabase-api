import 'package:employee_api/models/employee_model.dart';
import 'package:flutter/material.dart';
import '../services/supabase_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        // delete(_employees[index]['id']);
                      },
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