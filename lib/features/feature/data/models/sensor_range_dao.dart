import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_range.dart';

class SensorRangeDAO extends SensorRange{

  const SensorRangeDAO({
    required super.minValue,
    required super.maxValue
  });

  factory SensorRangeDAO.fromJSON(Map<String, dynamic> map){
    return SensorRangeDAO(
      minValue: map['min_value'].toString() ?? "",
      maxValue: map['max_value'].toString() ?? ""
    );
  }
}