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

class SubscribeMinuteChannel extends PinTunnelEvent{
  final int sensorId;

  const SubscribeMinuteChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeHourlyChannel extends PinTunnelEvent{
  final int sensorId;

  const SubscribeHourlyChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeDailyChannel extends PinTunnelEvent{
  final int sensorId;

  const SubscribeDailyChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeWeeklyChannel extends PinTunnelEvent{
  final int sensorId;

  const SubscribeWeeklyChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}

class SubscribeMonthlyChannel extends PinTunnelEvent{
  final int sensorId;

  const SubscribeMonthlyChannel({required this.sensorId});

  @override
  List<Object> get props => [sensorId];
}


class PayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const PayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class MinutePayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const MinutePayloadReceived({required this.payload});

  @override
  List<Object> get props => [payload];
}

class HourlyPayloadReceived extends PinTunnelEvent {
  final Map<String, dynamic> payload;

  const HourlyPayloadReceived({required this.payload});

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
