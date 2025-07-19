import 'package:employee_api/models/employee_model.dart';
import 'package:flutter/material.dart';
import '../services/supabase_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String, dynamic>> _employees = [

  ];

  Future<void> fetchEmployee() async {
  }

  @override
  void initState() {
    super.initState();
    fetchEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _employees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_employees[index]['name']),
                    subtitle: Text(
                      'Age: ${_employees[index]['age']}, Salary: ${_employees[index]['salary']}',
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
