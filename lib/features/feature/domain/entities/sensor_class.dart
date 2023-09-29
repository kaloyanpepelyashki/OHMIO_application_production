import 'package:equatable/equatable.dart';

class SensorClass extends Equatable {
  final String? tunnelMacAddress;
  final String? sensorName;
  final bool? isConnected;
  final String? sensorImage;
  final String? sensorDescription;
  final bool? isActuator;
  final String? unit;
  final String? version;
  final String? minValue;
  final String? maxValue;
  String? sensorMac;
  double? latestValue;

  SensorClass({
    this.tunnelMacAddress,
    this.sensorName,
    this.isConnected,
    this.sensorImage,
    this.sensorDescription,
    this.isActuator,
    this.unit,
    this.version,
    this.minValue,
    this.maxValue,
    this.sensorMac,
    this.latestValue
  });

  @override
  List<Object?> get props => [
        tunnelMacAddress,
        sensorName,
        isConnected,
        sensorImage,
        sensorDescription,
        isActuator,
        unit,
        version,
        minValue,
        maxValue,
        sensorMac,
      ];
}
