abstract class IPinTunnelRepository{
  subscribeToChannel(String channelName, Function(dynamic) onReceived);
  subscribeToMinuteData(int sensorId, Function(dynamic) onReceived);
  subscribeToHourlyData(int sensorId, Function(dynamic) onReceived);
  subscribeToDailyData(int sensorId, Function(dynamic) onReceived);
}