import 'package:employee_api/services/supabase_credentials.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProvider {
  static Future<void> init() async {
    await Supabase.initialize(
      url: SupabaseCredentials.url,
      anonKey: SupabaseCredentials.anonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}