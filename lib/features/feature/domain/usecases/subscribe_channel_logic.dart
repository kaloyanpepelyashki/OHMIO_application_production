import 'package:dart_either/dart_either.dart';
import 'package:pin_tunnel_application_production/core/errors/failure.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/latest_data.dart';

import '../repository/i_pin_tunnel_repository.dart';

class SubscribeChannelLogic{
  final IPinTunnelRepository repository;

  SubscribeChannelLogic(this.repository);

  
  void subscribeToChannel(int sensorId, Function(dynamic) onReceived){
    repository.subscribeToChannel(sensorId, onReceived);
  }

   Future<Either<Failure, LatestData>> getLatestData(int sensorMac) async{
    return await repository.getLatestData(sensorMac);
   }

  Future<Either<Failure, List<ChartData>>> getDailyData(int sensorId) async{
    return await repository.getDailyData(sensorId);
  }

  Future<Either<Failure, List<ChartData>>> getWeeklyData(int sensorId) async{
    return await repository.getWeeklyData(sensorId);
  }

  Future<Either<Failure, List<ChartData>>> getMonthlyData(int sensorId) async{
    return repository.getMonthlyData(sensorId);
  }
}