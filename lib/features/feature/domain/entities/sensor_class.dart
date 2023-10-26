import 'package:equatable/equatable.dart';

class SensorClass extends Equatable {
  String? tunnelMacAddress;
  String? sensorName;
  bool? isConnected;
  String? sensorImage;
  String? sensorDescription;
  bool? isActuator;
  String? unit;
  String? version;
  String? minValue;
  String? maxValue;
  String? sensorMac;
  double? latestValue;
  String? missingDay;
  String? nickname;

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
    this.latestValue,
    this.missingDay,
    this.nickname
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
        latestValue,
        missingDay,
        nickname
      ];
}
