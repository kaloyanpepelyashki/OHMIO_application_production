import 'package:equatable/equatable.dart';

class LatestData extends Equatable{
  final DateTime? dateTime;
  final double? value;
  final int? sensorMac;

  LatestData({this.dateTime, this.value, this.sensorMac});
  
  @override
  List<Object?> get props => [dateTime, value, sensorMac];
}