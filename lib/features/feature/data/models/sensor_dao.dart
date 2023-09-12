import '../../domain/entities/sensor_class.dart';

class SensorDAO extends SensorClass{
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
  
  final String? image;
  final String? name;

  const SensorDAO({
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

    this.image,
    this.name,
  });

  factory SensorDAO.fromJSON(Map<String, dynamic> map){
    return SensorDAO(
      sensorDescription: map['description'].toString() ?? "",
      isActuator: map['isActuator'] ?? false,
      unit: map['unit'].toString() ?? "",
      version: map['version'].toString() ?? "",
      minValue: map['min_value'].toString() ?? "",
      maxValue: map['max_value'].toString() ?? "",
      image: map['image'].toString() ?? "",
      name: map['name'].toString() ?? "",
    );
  }
}