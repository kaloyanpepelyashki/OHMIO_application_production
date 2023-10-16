import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  void _onSubscribeChannel(
    SubscribeChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToChannel(event.sensorId, (payload) {
      if(payload != []){
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
      ifLeft: (value)=>print(value),
      ifRight: (value)=>{
        print("Latest data received state $value"),
        emit(LatestDataReceivedState(value))});
  }

  void _onGetDailyData(
    GetDailyData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getDailyData(event.sensorId);
    data.fold(
      ifLeft: (value)=>print(value),
      ifRight: (value)=>{
        print("DAILY DATA RCEIVED STATE $value"),
        emit(DailyDataReceivedState(value))});
  }

  void _onGetWeeklyData(
    GetWeeklyData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getWeeklyData(event.sensorId);
    data.fold(
      ifLeft: (value)=>print(value),
      ifRight: (value)=>{
        print("WEEKLY DATA RECEIVED STATE $value"),
        emit(WeeklyDataReceivedState(value))});
  }

  void _onGetMonthlyData(
    GetMonthlyData event,
    Emitter<PinTunnelState> emit,
  ) async {
    final data = await subscribeChannelLogic.getMonthlyData(event.sensorId);
    data.fold(
      ifLeft: (value)=> print(value),
      ifRight: (value)=>{ emit(MonthlyDataReceivedState(value))},
    );
  }

  void _onPayloadReceived(
    PayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    if(event.payload!=[]){
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
        if (value.isNotEmpty) {emit(SensorsForUserReceivedState(value))}
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

  @override
  Future<void> close() {
    payloadController.close();
    minutePayloadController.close();
    hourlyPayloadController.close();
    dailyPayloadController.close();
    return super.close();
  }
}
