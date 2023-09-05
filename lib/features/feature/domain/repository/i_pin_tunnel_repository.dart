import 'package:dart_either/dart_either.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/sensor_range_dao.dart';

abstract class IPinTunnelRepository{
  subscribeToChannel(int sensorId, Function(dynamic) onReceived);
  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived);
  subscribeToHourlyData(int sensorId, Function(dynamic) onReceived);
  subscribeToDailyData(int sensorId, Function(dynamic) onReceived);
  Future<Either<Failure,SensorRangeDAO>> getRangeForSensor(int sensorId);
}