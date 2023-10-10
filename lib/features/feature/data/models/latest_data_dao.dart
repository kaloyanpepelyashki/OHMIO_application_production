import 'package:pin_tunnel_application_production/features/feature/domain/entities/latest_data.dart';

class LatestDataDao extends LatestData{
  static LatestData fromJSON(Map<String, dynamic> json){
    DateTime dateTime = DateTime.parse(json['created_at']);

    return LatestData(
      dateTime: DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour+2, dateTime.minute),
      value: (json['avg'] as num).toDouble(),
      sensorMac: json['sensor_id'],
    );
  }
}