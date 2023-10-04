import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/chart_data/daily_chart_data_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/chart_data/monthly_chart_data_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/chart_data/weekly_chart_data_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/latest_data_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/sensor_range_dao.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/action_class.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/latest_data.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/repository/i_pin_tunnel_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/sensor_class.dart';
import '../models/sensor_dao.dart';

class PinTunnelRepository implements IPinTunnelRepository {
  @override
  subscribeToChannel(int sensorId, Function(dynamic) onReceived) async {
    try {
      final response = await supabaseManager.supabaseClient
          .from('pintunnel_data')
          .select('''time, data''')
          .eq('sensor_mac', sensorId)
          .order('time', ascending: false)
          .limit(10);

      print(sensorId);
      print("RESPONSE: $response");
      if (response != null) {
        onReceived({'sensor_data': response});
      }

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
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Either<Failure, LatestData>> getLatestData(int sensorMac) async {
    try {
      final response = await supabaseManager.supabaseClient
          .from('daily_data')
          .select('''created_at, avg, sensor_id''')
          .eq('sensor_id', sensorMac)
          .limit(1);
      final latestData = LatestDataDao.fromJSON(response[0]);
      return Right(latestData);
    } catch (e) {
      return const Left(
          NotFoundFailure(message: "Daily data not found", statusCode: 404));
    }
  }

  @override
  Future<Either<Failure, List<ChartData>>> getDailyData(int sensorMac) async {

    try {
      final response = await supabaseManager.supabaseClient
          .from('daily_data')
          .select('''created_at, avg''')
          .eq('sensor_id', sensorMac)
          .order('created_at', ascending: false);

      print("RESPONSE FROM DAILY DATA: $response");
      List<ChartData> chartDataList = [];
      for (int index = 0; index < response.length; index++) {
        final chartData =
            DailyChartDataDao.fromJSON(response[index] as Map<String, dynamic>);
        chartDataList.add(chartData);
      }
      if (chartDataList.isNotEmpty) {
        return Right(chartDataList);
      }

      return const Left(
          NotFoundFailure(message: "Daily data not found", statusCode: 404));
    } catch (e) {
      print(e);
      return const Left(
          NotFoundFailure(message: "Unknown exception", statusCode: 404));
    }
  }

  @override
  Future<Either<Failure, List<ChartData>>> getWeeklyData(int sensorMac) async {
    print("SENSOR ID IN SUBSCRIBETOWEEKLYDATA: $sensorMac");

    final response = await supabaseManager.supabaseClient
        .from('weekly_data')
        .select('''created_at, avg''')
        .eq('sensor_id', sensorMac)
        .order('created_at', ascending: false);

    print("WEEKLY DATA RESPONSE: $response");

    List<ChartData> chartDataList = [];
    for (int index = 0; index < response.length; index++) {
      final chartData =
          WeeklyChartDataDao.fromJSON(response[index] as Map<String, dynamic>);
      chartDataList.add(chartData);
    }
    print("WEEKLY CHART DATA LIST - $chartDataList");
    if (chartDataList.isNotEmpty) {
      return Right(chartDataList);
    }
    return Left(
        NotFoundFailure(message: "Weekly data not found", statusCode: 404));
  }

  @override
  Future<Either<Failure, List<ChartData>>> getMonthlyData(int sensorMac) async {

    final response = await supabaseManager.supabaseClient
        .from('monthly_data')
        .select('''created_at, avg''')
        .eq('sensor_id', sensorMac)
        .order('created_at', ascending: false);

    List<ChartData> chartDataList = [];
    for (int index = 0; index < response.length; index++) {
      final chartData =
          DailyChartDataDao.fromJSON(response[index] as Map<String, dynamic>);
      chartDataList.add(chartData);
    }
    if (chartDataList.isNotEmpty) {
      return Right(chartDataList);
    }
    return Left(
        NotFoundFailure(message: "Monthly data not found", statusCode: 404));
  }

  @override
  Future<Either<Failure, SensorRangeDAO>> getRangeForSensor(
      int sensorId) async {

    try {
      final data = await supabaseManager.supabaseClient.from('range').select('''
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

    try {
      final clientId = (await supabaseManager.supabaseClient.from('profiles').select('''
    id
  ''').eq('email', email));
      print("CLIENT ID IN pintunnel_repository: $clientId");

      if (clientId.isEmpty || clientId == null) {
        return Left(NotFoundFailure(
            message: "ClientId not found for given email", statusCode: 404));
      }

      print(clientId[0]['id']);

      final session = supabaseManager.supabaseClient.auth.currentSession;

      if (session != null) {
        print('User is authenticated with user id: ${session.user.id}');
      } else {
        print('User is anonymous (not authenticated)');
      }

      final pintunnelData = await supabaseManager.supabaseClient
          .from('pintunnel')
          .select('mac_address')
          .eq('user_id', clientId[0]['id']);

      print("PINTUNNEL DATA IN pintunnel_repository: $pintunnelData");
      if (pintunnelData.isEmpty) {
        return Left(NotFoundFailure(
            message: "Pintunnel not found for given email", statusCode: 404));
      }

      final sensorData = (await supabaseManager.supabaseClient
          .from('sensor')
          .select('''cfg_code, sensor_mac''').eq('mac_address', '123456789'));
      print("SENSOR DATA $sensorData");
      if (sensorData.isEmpty || sensorData == null) {
        return Left(
            NotFoundFailure(message: "Sensor data is null", statusCode: 404));
      }

      List<dynamic> cfgCodes =
          sensorData.map((data) => data['cfg_code'] as int).toList();

      final data = await supabaseManager.supabaseClient
          .from('sensor_config')
          .select('''description, isActuator, unit, version, min_value, max_value, image, name''').in_(
              'cfg_code', cfgCodes);

      List<SensorClass> sensorClassList = [];
      for (int index = 0; index < data.length; index++) {
        final sensor = SensorDAO.fromJSON(data[index] as Map<String, dynamic>);
        sensor.sensorMac = sensorData[index]['sensor_mac'].toString();
        sensorClassList.add(sensor);
      }
      if (sensorClassList.isNotEmpty) {
        return Right(sensorClassList);
      }
      return Left(
          NotFoundFailure(message: "Sensors not found", statusCode: 404));
    } on APIException catch (e) {
      print("EXCEPTION pin_tunnel_repository $e");
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  void addAction(ActionClass actionClass) async {

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
      await supabaseManager.supabaseClient.from('dependency').insert({
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
