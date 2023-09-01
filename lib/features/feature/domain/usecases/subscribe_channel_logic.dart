import '../repository/i_pin_tunnel_repository.dart';

class SubscribeChannelLogic{
  final IPinTunnelRepository repository;

  SubscribeChannelLogic(this.repository);

  
  void subscribeToChannel(String channelName, Function(dynamic) onReceived){
    repository.subscribeToChannel(channelName, onReceived);
  }

  void subscribeToMinuteData(int sensorId, Function(dynamic) onReceived){
    repository.subscribeToMinuteData(sensorId, onReceived);
  }

  void subscribeToHourlyData(int sensorId, Function(dynamic) onReceived){
    repository.subscribeToHourlyData(sensorId, onReceived);
  }


  void subscribeToDailyData(int sensorId, Function(dynamic) onReceived){
    repository.subscribeToDailyData(sensorId, onReceived);
  }

}