import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/sensor_range_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/action_class.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/sensor_class.dart';
import '../models/sensor_dao.dart';

class PinTunnelRepository implements IPinTunnelRepository {
  @override
  subscribeToChannel(int sensorId, Function(dynamic) onReceived) async {
    SupabaseManager supabaseManager = SupabaseManager(
        supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'pintunnel_data',
          filter: 'sensor_id=eq.$sensorId'),
      (payload, [ref]) {
        print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseManager supabaseManager = SupabaseManager(
        supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'per_minute_data',
          filter: 'sensor_id=$sensorId'),
      (payload, [ref]) {
        print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
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

  @override
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

  @override
  Future<Either<Failure, List<SensorDAO>>> getSensorsForUser(
      String email) async {
    SupabaseClient client = SupabaseClient(
        "https://wruqswjbhpvpikhgwade.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");

    try {
      final clientId = (await client.from('profiles').select('''
    id
  ''').eq('email', email))[0]['id'];

    final pintunnelData = (await client.from('pintunnel').select('''id, mac_address''').eq('user_id', clientId));

      final cfg_code = (await client.from('sensor').select('''cfg_code''').eq('pintunnel_id', pintunnelData[0]['id']))[0]['cfg_code'];

      print(cfg_code);

      final data = await client.from('sensor_config').select('''description, isActuator, unit, version, min_value, max_value, image, name''');

      print(data);

      List<SensorDAO> sensorDAOList = [];
      data.forEach((i) => sensorDAOList.add(SensorDAO.fromJSON(i as Map<String, dynamic>)));
      
      return Right(sensorDAOList);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  void addAction(ActionClass actionClass) async {
    SupabaseClient client = SupabaseClient(
        "https://wruqswjbhpvpikhgwade.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");

    print("In repository addAction");
    print(actionClass.action);
    print(actionClass.condition);
    print(actionClass.conditionValue);
    print(actionClass.sensorId);

    try {
      /* final response = await client.from('dependency').insert({
        'action_logic': 'notification',
        'action_condition': 'above',
        'action_condition_value': 23.5,
        'independent_sensor_id': 12345,
      });*/
      await client.from('dependency').insert({
        'action_logic': actionClass.action,
        'action_condition': actionClass.condition,
        'action_condition_value': actionClass.conditionValue,
        'independent_sensor_id': actionClass.sensorId,
      });
    } catch (e) {
      print('Error inserting data: $e');
    }
  }
}
