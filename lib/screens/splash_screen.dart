import 'package:employee_api/screens/home_screen.dart';
import 'package:employee_api/services/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signIn_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _signIn();
  }

  Future<void> _signIn() async {
    final response = SupabaseProvider.client.auth.currentSession;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (response != null) {
        Get.to(HomeScreen());
      } else {
        Get.to(SignInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Sign In'),
        centerTitle: true,
      ),
      body: Center(child: CircularProgressIndicator(color: Colors.grey)),
    );
  }
}