import 'package:employee_api/services/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      final response = await SupabaseProvider.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        Get.showSnackbar(
          GetSnackBar(
            message: ' ',
            title: 'Sign In Successful',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error during sign In: $e');
      Get.showSnackbar(
        GetSnackBar(
          message: 'fail',
          title: e.toString(),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Sign In'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Name is required' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => (value?.length ?? 0) < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                obscureText: true,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}