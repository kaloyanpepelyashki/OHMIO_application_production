import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  late SupabaseClient supabaseClient;
  late SupabaseManager supabaseManager;

  setUp(() {
    supabaseClient = SupabaseClient("https://xkvzvrqmpqhfhutbvlry.supabase.co", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhrdnp2cnFtcHFoZmh1dGJ2bHJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxNzY0ODQsImV4cCI6MjAwMjc1MjQ4NH0.73RTVlB2J7OTLRdMQBsOmnKLJb3cOU_jMJxiomkh4-A");
    supabaseManager = SupabaseManager(
      supabaseUrl: "https://xkvzvrqmpqhfhutbvlry.supabase.co",
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhrdnp2cnFtcHFoZmh1dGJ2bHJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxNzY0ODQsImV4cCI6MjAwMjc1MjQ4NH0.73RTVlB2J7OTLRdMQBsOmnKLJb3cOU_jMJxiomkh4-A",
    );
  });

  test('successfully signs in the user', () async {
    final result = await supabaseClient.auth
          .signInWithPassword(email: 'gamij26987@chodyi.com', password: '123456');

    // Check if the function returns the correct value
   expect(result.user!.email, 'gamij26987@chodyi.com');
  });
}
