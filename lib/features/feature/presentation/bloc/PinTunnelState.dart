import 'package:equatable/equatable.dart';

abstract class PinTunnelState extends Equatable{
  const PinTunnelState();

  @override
  List<Object> get props => [];
}

class NoInternetState extends PinTunnelState{
}

class InitialState extends PinTunnelState{
  
}

class PayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  PayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class MinutePayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  MinutePayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class HourlyPayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  HourlyPayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class DailyPayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  DailyPayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}