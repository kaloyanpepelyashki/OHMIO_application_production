import 'package:equatable/equatable.dart';

class ChartData extends Equatable {
  final DateTime? dateTime;
  final double? value;
  ChartData({this.dateTime, this.value});

  @override
  List<Object?> get props => [dateTime, value];
}
