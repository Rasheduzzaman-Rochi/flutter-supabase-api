import 'package:employee_api/models/employee_model.dart';
import 'package:flutter/material.dart';
import '../services/supabase_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Employee> _employees = [];
  late Future<void> _fetchEmployeeFuture;

  Future<void> fetchEmployee() async {
    _employees.clear();

    final response = await SupabaseProvider.client
        .from('Employee')
        .select()
        .order('id', ascending: true);

    for (var i in response as List) {
      Employee data = Employee.fromJson(i);
      _employees.add(data);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEmployeeFuture = fetchEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: FutureBuilder(
        future: _fetchEmployeeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _employees.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_employees[index].name),
                        subtitle: Text(
                          'Age: ${_employees[index].age}, Salary: ${_employees[index].salary}',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}