import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/latest_data.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_class.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/sensor_dao.dart';
import '../../data/models/sensor_range_dao.dart';
import '../entities/action_class.dart';

abstract class IPinTunnelRepository{
  subscribeToChannel(int sensorId, Function(dynamic) onReceived);
  Future<Either<Failure, List<LatestData>>> getLatestData(List<int> listOfMacs);
  Future<Either<Failure, List<ChartData>>> getDailyData(int sensorId);
  Future<Either<Failure, List<ChartData>>> getWeeklyData(int sensorId);
  Future<Either<Failure, List<ChartData>>> getMonthlyData(int sensorId);
  Future<Either<Failure,SensorRangeDAO>> getRangeForSensor(int sensorId);
  Future<Either<Failure, List<SensorClass>>> getSensorsForUser(String email);
  void addAction(ActionClass actionClass);
  void updateUserStatus(String status, String email);
  Future<Either<Failure, String>> saveSensorCustomization(String iconName, String nickname, int sensorId, String sensorPlacement);
}