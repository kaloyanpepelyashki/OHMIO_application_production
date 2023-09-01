import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PinTunnelRepository implements IPinTunnelRepository{
  @override
  subscribeToChannel(String channelName, Function(dynamic) onReceived) {
    SupabaseManager supabaseManager = SupabaseManager(supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");

    print('subscribeToChannel method in repository called');
/*
// _hyper_20_5_chunk is the name of pintunnel_data hypertable
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*', table: '_hyper_20_5_chunk'),
      (payload, [ref]) {
        print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
*/
  }

  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived){
    SupabaseManager supabaseManager = SupabaseManager(supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*', table: 'per_minute_data'),
      (payload, [ref]) {
        print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
    
  }

  subscribeToHourlyData(int sensorId, Function(dynamic) onReceived){
    SupabaseManager supabaseManager = SupabaseManager(supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*', table: 'hourly_data', filter: 'sensor_id=$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
    
  }

  subscribeToDailyData(int sensorId, Function(dynamic) onReceived){
    SupabaseManager supabaseManager = SupabaseManager(supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*', table: 'daily_data', filter: 'sensor_id=$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
    
  }
}