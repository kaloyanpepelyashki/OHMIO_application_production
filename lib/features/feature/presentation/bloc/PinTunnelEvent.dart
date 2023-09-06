import 'package:equatable/equatable.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_range.dart';

import '../../domain/entities/action_class.dart';

abstract class PinTunnelEvent extends Equatable{
  const PinTunnelEvent();

  @override
  List<Object> get props => [];
}

class SubscribeChannel extends PinTunnelEvent{
  final int sensorId;

  SubscribeChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeMinuteChannel extends PinTunnelEvent{
  final int sensorId;

  SubscribeMinuteChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeHourlyChannel extends PinTunnelEvent{
  final int sensorId;

  SubscribeHourlyChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeDailyChannel extends PinTunnelEvent{
  final int sensorId;

  SubscribeDailyChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}




class PayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  PayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class MinutePayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  MinutePayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class HourlyPayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  HourlyPayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class DailyPayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  DailyPayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}


class GetSensorRange extends PinTunnelEvent{
  final int sensorId;

  GetSensorRange({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class AddAction extends PinTunnelEvent{
  final ActionClass actionClass;

  AddAction({required this.actionClass});
}
