abstract class IPinTunnelRepository{
  subscribeToChannel(String channelName, Function(dynamic) onReceived);
}