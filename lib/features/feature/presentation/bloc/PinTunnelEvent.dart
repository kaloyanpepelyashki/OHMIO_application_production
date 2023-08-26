import 'package:equatable/equatable.dart';

abstract class PinTunnelEvent extends Equatable{
  const PinTunnelEvent();

  @override
  List<Object> get props => [];
}

class SubscribeChannel extends PinTunnelEvent{
  final String channelName;

  SubscribeChannel({required this.channelName});

  @override
  List<Object> get props => [channelName];
}

class PayloadReceived extends PinTunnelEvent {
  final String payload;

  PayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}