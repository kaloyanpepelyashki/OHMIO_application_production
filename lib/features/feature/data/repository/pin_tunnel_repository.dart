import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';

class PinTunnelRepository implements IPinTunnelRepository{
  @override
  subscribeToChannel(String channelName, Function(dynamic) onReceived) {
    SupabaseManager supabaseManager = SupabaseManager(supabaseUrl: "https://xkvzvrqmpqhfhutbvlry.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhrdnp2cnFtcHFoZmh1dGJ2bHJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxNzY0ODQsImV4cCI6MjAwMjc1MjQ4NH0.73RTVlB2J7OTLRdMQBsOmnKLJb3cOU_jMJxiomkh4-A");

    supabaseManager.subscribeToChannel(channelName, onReceived);
  }
}