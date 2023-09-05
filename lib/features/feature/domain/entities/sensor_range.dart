import 'package:equatable/equatable.dart';
import 'package:pin_tunnel_application_production/features/feature/data/models/sensor_range_dao.dart';

class SensorRange extends Equatable{ 
  final String minValue;
  final String maxValue;

  const SensorRange({
    required this.minValue,
    required this.maxValue
  });

//for testing
  const SensorRange.empty() :
  this(
    minValue: "5.0",
    maxValue: "10.0"
  );


  @override
  List<Object?> get props => [minValue, maxValue];
}