import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientInstance {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://mjepwlbtbqahkptlijid.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qZXB3bGJ0YnFhaGtwdGxpamlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI5NjQzMDIsImV4cCI6MjA1ODU0MDMwMn0.bJUS4hfQIxjHQdBU64IQ6l3eZwUGBd_It9e2a89VP2I',
      // Optional: for deep links on mobile
      // authFlowType: AuthFlowType.pkce, // default
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
