import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_class.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/sensor_dao.dart';
import '../../data/models/sensor_range_dao.dart';
import '../entities/action_class.dart';

abstract class IPinTunnelRepository{
  subscribeToChannel(int sensorId, Function(dynamic) onReceived);
  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived);
  subscribeToHourlyData(int sensorId, Function(dynamic) onReceived);
  subscribeToDailyData(int sensorId, Function(dynamic) onReceived);
  Future<Either<Failure,SensorRangeDAO>> getRangeForSensor(int sensorId);
  Future<Either<Failure, List<SensorDAO>>> getSensorsForUser(String email);
  void addAction(ActionClass actionClass);
}