import 'package:employee_api/services/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/employee_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final List<Employee> _employees = [];
  late Future<void> _fetchEmployees;

  @override
  void initState() {
    super.initState();
    _fetchEmployees = fetchEmployee();
    subscribeToChanges();
  }

  Future<void> fetchEmployee() async {
    final response = await SupabaseProvider.client
        .from('Employee')
        .select()
        .order('id', ascending: true);

    for (var i in response as List) {
      Employee data = Employee.fromJson(i);
      _employees.add(data);
    }
  }

  void subscribeToChanges() {
    SupabaseProvider.client
        .channel('public:Employee')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'Employee',
          callback: (payload) {
            fetchEmployee();
          },
        )
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: FutureBuilder(
        future: _fetchEmployees,
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
