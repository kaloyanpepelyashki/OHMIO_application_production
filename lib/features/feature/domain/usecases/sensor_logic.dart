import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_range.dart';

import '../../../../core/errors/failure.dart';
import '../repository/i_pin_tunnel_repository.dart';

class SensorLogic{

  const SensorLogic(this._repository);

  final IPinTunnelRepository _repository;

  Future<Either<Failure, SensorRange>>  getRangeForSensor(int sensorId){
    return _repository.getRangeForSensor(sensorId);
  }
}