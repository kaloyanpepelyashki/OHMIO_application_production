import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_range.dart';

import '../../../../core/errors/failure.dart';
import '../entities/action_class.dart';
import '../entities/sensor_class.dart';
import '../repository/i_pin_tunnel_repository.dart';

class SensorLogic{

  const SensorLogic(this._repository);

  final IPinTunnelRepository _repository;

  Future<Either<Failure, SensorRange>>  getRangeForSensor(int sensorId){
    return _repository.getRangeForSensor(sensorId);
  }

   Future<Either<Failure, List<SensorClass>>> getSensorsForUser(String email){
    return _repository.getSensorsForUser(email);
  }

  void addAction(ActionClass actionClass){
    _repository.addAction(actionClass);
  }

  void updateUserStatus(String status, String email){
    _repository.updateUserStatus(status, email);
  }

  Future<Either<Failure, String>> saveSensorCustomization(String iconName, String nickname, int sensorId, String sensorPlacement){
    return _repository.saveSensorCustomization(iconName, nickname, sensorId, sensorPlacement);
  }
}