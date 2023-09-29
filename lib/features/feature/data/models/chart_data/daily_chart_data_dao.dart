import 'package:pin_tunnel_application_production/features/feature/domain/entities/chart_data.dart';

class DailyChartDataDao extends ChartData {
  static ChartData fromJSON(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['created_at']);

    try{
      return ChartData(
      dateTime: DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
      value: (json['avg'] as num).toDouble() ,
    );
    }catch(e){
      return ChartData(dateTime: DateTime.now(), value:0);
    }
  }
}
