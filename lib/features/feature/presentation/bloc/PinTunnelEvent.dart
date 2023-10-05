import 'package:equatable/equatable.dart';

import '../../domain/entities/action_class.dart';

abstract class PinTunnelEvent extends Equatable{
  const PinTunnelEvent();

  @override
  List<Object> get props => [];
}

class SubscribeChannel extends PinTunnelEvent{
  final int sensorId;

  const SubscribeChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class GetLatestData extends PinTunnelEvent{
  final List<int> listOfMacs;

  const GetLatestData({required this.listOfMacs});
}

class GetDailyData extends PinTunnelEvent{
  final int sensorId;

  const GetDailyData({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class GetWeeklyData extends PinTunnelEvent{
  final int sensorId;

  const GetWeeklyData({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class GetMonthlyData extends PinTunnelEvent{
  final int sensorId;

  const GetMonthlyData({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}


class PayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const PayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class DailyPayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const DailyPayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class WeeklyPayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const WeeklyPayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class MonthlyPayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const MonthlyPayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}


class GetSensorRange extends PinTunnelEvent{
  final int sensorId;

  const GetSensorRange({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class AddAction extends PinTunnelEvent{
  final ActionClass actionClass;

  const AddAction({required this.actionClass});
}

class GetSensorsForUser extends PinTunnelEvent{
  final String email;

  const GetSensorsForUser({required this.email});

  @override
  List<Object> get props => [email];
}
