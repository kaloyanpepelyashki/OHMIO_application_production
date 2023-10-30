import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_tunnel_application_production/core/errors/failure.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_class.dart';

import '../../domain/usecases/sensor_logic.dart';
import '../../domain/usecases/subscribe_channel_logic.dart';
import 'PinTunnelEvent.dart';
import 'PinTunnelState.dart';

class PinTunnelBloc extends Bloc<PinTunnelEvent, PinTunnelState> {
  String? email;

  final SubscribeChannelLogic subscribeChannelLogic;
  final SensorLogic sensorLogic;
  final payloadController = StreamController<Map<String, dynamic>>();

  final minutePayloadController = StreamController<Map<String, dynamic>>();
  final hourlyPayloadController = StreamController<Map<String, dynamic>>();
  final dailyPayloadController = StreamController<Map<String, dynamic>>();
  final weeklyPayloadController = StreamController<Map<String, dynamic>>();
  final monthlyPayloadController = StreamController<Map<String, dynamic>>();

  PinTunnelBloc(
      {required this.subscribeChannelLogic, required this.sensorLogic})
      : super(InitialState()) {
    payloadController.stream.listen((payload) {
      add(PayloadReceived(payload: payload));
    });

    on<SubscribeChannel>(_onSubscribeChannel);

    on<GetLatestData>(_onGetLatestData);

    on<GetDailyData>(_onGetDailyData);
    on<GetWeeklyData>(_onGetWeeklyData);
    on<GetMonthlyData>(_onGetMonthlyData);

    on<PayloadReceived>(_onPayloadReceived);

    on<GetSensorRange>(_onGetSensorRange);
    on<GetSensorsForUser>(_onGetSensorsForUser);
    on<AddAction>(_onAddAction);

    on<UpdateUserStatus>(_onUpdateUserStatus);

    on<SaveSensorCustomization>(_onSaveSensorCustomization);
    on<GetHistoricalData>(_onGetHistoricalData);
  }

  void _onSubscribeChannel(
    SubscribeChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToChannel(event.sensorId, (payload) {
      if (payload != []) {
        print("change received: ${payload}");
        payloadController.sink.add(payload);
      }
    });
  }

  void _onGetLatestData(
    GetLatestData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getLatestData(event.listOfMacs);
    data.fold(
        ifLeft: (value) => print(value),
        ifRight: (value) => {
              print("Latest data received state $value"),
              emit(LatestDataReceivedState(value))
            });
  }

  void _onGetDailyData(
    GetDailyData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getDailyData(event.sensorId);
    data.fold(
        ifLeft: (value) => print(value),
        ifRight: (value) => {
              print("DAILY DATA RCEIVED STATE $value"),
              emit(DailyDataReceivedState(value))
            });
  }

  void _onGetWeeklyData(
    GetWeeklyData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getWeeklyData(event.sensorId);
    data.fold(
        ifLeft: (value) => print(value),
        ifRight: (value) => {
              print("WEEKLY DATA RECEIVED STATE $value"),
              emit(WeeklyDataReceivedState(value))
            });
  }

  void _onGetMonthlyData(
    GetMonthlyData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getMonthlyData(event.sensorId);
    data.fold(
      ifLeft: (value) => print(value),
      ifRight: (value) => {emit(MonthlyDataReceivedState(value))},
    );
  }

  void _onPayloadReceived(
    PayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    if (event.payload != []) {
      print("EVENT.PAYLOAD ${event.payload}");
      emit(PayloadReceivedState(event.payload));
    }
    // print('payloadReceived emmited $event.payload');
  }

  void _onGetSensorRange(
    GetSensorRange event,
    Emitter<PinTunnelState> emit,
  ) async {
    final result = await sensorLogic.getRangeForSensor(12345);
    result.fold(
      ifLeft: (value) => print(value),
      ifRight: (value) => {emit(SensorRangeReceivedState(value))},
    );
  }

  void _onGetSensorsForUser(
    GetSensorsForUser event,
    Emitter<PinTunnelState> emit,
  ) async {
    final result = await sensorLogic.getSensorsForUser(event.email);
    result.fold(
      ifLeft: (value) => print(value),
      ifRight: (value) => {
        if (value.isNotEmpty)
          {
            print("VALUE in onGetSensorsForUser: ${value}"),
            emit(SensorsForUserReceivedState(value)),
            print("SensorsForUserReceivedState emmited"),
          }
      },
    );
  }

  void _onAddAction(
    AddAction event,
    Emitter<PinTunnelState> emit,
  ) async {
    print("In _onAddAction - Bloc");
    sensorLogic.addAction(event.actionClass);
    print("After sensorLogic.addAction(...)");
  }

  void _onUpdateUserStatus(
    UpdateUserStatus event,
    Emitter<PinTunnelState> emit,
  ) async {
    sensorLogic.updateUserStatus(event.status, event.email);
    print("User profile updated with the status of: ${event.status}");
  }

  void _onSaveSensorCustomization(
    SaveSensorCustomization event,
    Emitter<PinTunnelState> emit,
  ) async {
    final result = await sensorLogic.saveSensorCustomization(
        event.iconName, event.nickname, event.sensorId, event.sensorPlacement);
    result.fold(
      ifLeft: (Failure value) {
        print(value);
      },
      ifRight: (String value) {
        emit(UpdateSuccessState(value));
      },
    );
  }

  void _onGetHistoricalData(
    GetHistoricalData event,
    Emitter<PinTunnelState> emit,
  ) async{
    final result = await sensorLogic.getHistoricalData(event.email);
    print("HISTORICAL DATA: $result");
    result.fold(
      ifLeft: (Failure value){
        print(value);
      },
      ifRight: (List<SensorClass> listOfSensors){
        emit(HistoricalDataReceivedState(listOfSensors));
      }
    );
  }

  @override
  Future<void> close() {
    payloadController.close();
    minutePayloadController.close();
    hourlyPayloadController.close();
    dailyPayloadController.close();
    return super.close();
  }
}
