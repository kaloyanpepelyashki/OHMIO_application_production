import 'package:equatable/equatable.dart';

class SensorClass  extends Equatable{
  final String? tunnelMacAddress;
  final String? sensorName;
  final bool? isConnected;
  final String? sensorImage;
  final String? sensorDescription;
  final bool? isActuator;

   const SensorClass({
    this.tunnelMacAddress,
    this.sensorName,
    this.isConnected,
    this.sensorImage,
    this.sensorDescription,
    this.isActuator,
   }
  );
  
  @override
  List<Object?> get props => [tunnelMacAddress, sensorName, isConnected, sensorImage, sensorDescription, isActuator];
}
