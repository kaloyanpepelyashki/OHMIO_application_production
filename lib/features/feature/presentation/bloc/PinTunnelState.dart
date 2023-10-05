import 'package:equatable/equatable.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/latest_data.dart';
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

class LatestDataReceivedState extends PinTunnelState{
  final List<LatestData> listOfLatestData;

  const LatestDataReceivedState(this.listOfLatestData);
}

class DailyDataReceivedState extends PinTunnelState{
  final List<ChartData> data;

  const DailyDataReceivedState(this.data);

  @override
  List<Object> get props =>[data];
}

class WeeklyDataReceivedState extends PinTunnelState{
  final List<ChartData> data;

  const WeeklyDataReceivedState(this.data);

  @override
  List<Object> get props =>[data];
}

class MonthlyDataReceivedState extends PinTunnelState{
  final List<ChartData> data;

  const MonthlyDataReceivedState(this.data);

  @override
  List<Object> get props =>[data];
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