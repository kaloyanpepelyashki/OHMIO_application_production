import '../../domain/entities/sensor_class.dart';

class SensorDAO {
  static SensorClass fromJSON(Map<String, dynamic> json) {
    return SensorClass(
      sensorDescription: json['description']?.toString() ?? "",
      sensorId: json['id'] ?? "",
      isActuator: json['isActuator'] is bool ? json['isActuator'] : false,
      unit: json['unit']?.toString() ?? "",
      version: json['version']?.toString() ?? "",
      minValue: json['min_value']?.toString() ?? "",
      maxValue: json['max_value']?.toString() ?? "",
      sensorImage: json['image']?.toString() ?? "",
      sensorName: json['name']?.toString() ?? "",
    );
  }
}