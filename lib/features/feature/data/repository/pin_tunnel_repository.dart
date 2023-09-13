import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/sensor_range_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/action_class.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';
import 'package:postgres/postgres.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/sensor_class.dart';
import '../models/sensor_dao.dart';
import 'package:http/http.dart' as http;

class PinTunnelRepository implements IPinTunnelRepository {
  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/certificate.crt');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) {
     final isValidHost = host == "db.wruqswjbhpvpikhgwade.supabase.co";
     return isValidHost;
    });
    IOClient ioClient = IOClient(client);
    return ioClient;
  }


  @override
  subscribeToChannel(int sensorId, Function(dynamic) onReceived) async {
    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",
    );
    final response = await supabaseClient
        .from('pintunnel_data')
        .select('''time, data''')
        .eq('sensor_id', sensorId)
        .order('time', ascending: false)
        .limit(10);
    print("PINTUNNEL_DATA RESPONSE: $response");
    onReceived({'sensor_data': response});
    Future.delayed(Duration(seconds: 1));

    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'pintunnel_data',
          filter: 'sensor_id=eq.$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",
    );
    final response = await supabaseClient
        .from('per_minute_data')
        .select('''created_at, avg''')
        .eq('sensor_id', sensorId)
        .order('created_at', ascending: false)
        .limit(10);
    onReceived({'sensor_data': response});

    supabaseManager.supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'per_minute_data',
          filter: 'sensor_id=eq.$sensorId'),
      (payload, [ref]) {
        print('Minute payload received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
  subscribeToHourlyData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",
    );
    supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'hourly_data',
          filter: 'sensor_id=eq.$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
  subscribeToDailyData(int sensorId, Function(dynamic) onReceived) async {
    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",

    );
    supabaseClient.channel('*').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
          event: '*',
          schema: '*',
          table: 'daily_data',
          filter: 'sensor_id=eq.$sensorId'),
      (payload, [ref]) {
        //print('Change received: ${payload.toString()}');
        onReceived(payload);
      },
    ).subscribe();
  }

  @override
  Future<Either<Failure, SensorRangeDAO>> getRangeForSensor(
      int sensorId) async {

    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",

    );

    try {
      final data = await supabaseClient.from('range').select('''
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
  Future<Either<Failure, List<SensorClass>>> getSensorsForUser(
      String email) async {

    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",

    );

    try {
      final clientId = (await supabaseClient.from('profiles').select('''
    id
  ''').eq('email', email))[0]['id'];

      final pintunnelData = (await supabaseClient
          .from('pintunnel')
          .select('''id, mac_address''').eq('user_id', clientId));

      final cfg_code = (await supabaseClient
          .from('sensor')
          .select('''cfg_code''').eq(
              'pintunnel_id', pintunnelData[0]['id']))[0]['cfg_code'];

      final data = await supabaseClient.from('sensor_config').select(
          '''description, isActuator, unit, version, min_value, max_value, image, name''');

      List<SensorClass> sensorClassList = [];
      data.forEach((i) => {
            sensorClassList.add(SensorDAO.fromJSON(i as Map<String, dynamic>)),
          });

      return Right(sensorClassList);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  void addAction(ActionClass actionClass) async {
    SupabaseClient supabaseClient = SupabaseClient(
      "https://wruqswjbhpvpikhgwade.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0",
    );

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
      await supabaseClient.from('dependency').insert({
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
