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