import 'package:equatable/equatable.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_range.dart';

import '../../domain/entities/action_class.dart';
import '../../domain/entities/sensor_class.dart';

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

  const PayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class MinutePayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  const MinutePayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class HourlyPayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  const HourlyPayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class DailyPayloadReceivedState extends PinTunnelState{
  final dynamic payload;

  const DailyPayloadReceivedState(this.payload);

  @override
  List<Object> get props =>[payload];
}

class SensorRangeReceivedState extends PinTunnelState{

  final SensorRange sensorRange;

  const SensorRangeReceivedState(this.sensorRange);

  @override
  List<Object> get props =>[sensorRange];
}

class SensorsForUserReceivedState extends PinTunnelState{

  final List<SensorClass> sensorList;

  const SensorsForUserReceivedState(this.sensorList);

  @override
  List<Object> get props =>[sensorList];
}

class AddActionState extends PinTunnelState{
  final ActionClass actionClass;

  const AddActionState(this.actionClass);

  @override
  List<Object> get props =>[actionClass];
}