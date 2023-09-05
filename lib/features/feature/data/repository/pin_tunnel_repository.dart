import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/sensor_range_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';

class PinTunnelRepository implements IPinTunnelRepository {
  @override
  subscribeToChannel(int sensorId, Function(dynamic) onReceived) async {

     SupabaseManager supabaseManager = SupabaseManager(
        supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*', table: 'pintunnel_data',filter: 'sensor_id=eq.${sensorId}'),
      (payload, [ref]) {
        print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseManager supabaseManager = SupabaseManager(
        supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*', table: 'per_minute_data',filter: 'sensor_id=$sensorId'),
      (payload, [ref]) {
        print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  subscribeToHourlyData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseManager supabaseManager = SupabaseManager(
        supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'hourly_data',
          filter: 'sensor_id=$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  subscribeToDailyData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseManager supabaseManager = SupabaseManager(
        supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'daily_data',
          filter: 'sensor_id=$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
  Future<Either<Failure, SensorRangeDAO>> getRangeForSensor(
      int sensorId) async {
    SupabaseClient client = SupabaseClient(
        "https://wruqswjbhpvpikhgwade.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");

    try {
      final data = await client.from('range').select('''
    min_value,
    max_value
  ''').eq('sensor_id', sensorId);
      return Right(SensorRangeDAO.fromJSON(data[0]));
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  getPortConfigForSensor(int sensorId) {}

  getPintunnelForProfileEmail(String email) {}
}
