import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';

class MonthlyChartDataDao extends ChartData {
  static ChartData fromJSON(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['created_at']);

    return ChartData(
      dateTime: DateTime(dateTime.year, dateTime.month, dateTime.day),
      value: (json['avg'] as num).toDouble(),
    );
  }
}