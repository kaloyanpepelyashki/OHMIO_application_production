import '../repository/i_pin_tunnel_repository.dart';

class SubscribeChannelLogic{
  final IPinTunnelRepository repository;

  SubscribeChannelLogic(this.repository);

  @override
  void subscribeToChannel(String channelName, Function(dynamic) onReceived){
    repository.subscribeToChannel(channelName, onReceived);
  }
}