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

    minutePayloadController.stream.listen((payload) {
      add(MinutePayloadReceived(payload: payload));
    });

    hourlyPayloadController.stream.listen((payload) {
      add(HourlyPayloadReceived(payload: payload));
    });

    dailyPayloadController.stream.listen((payload) {
      add(DailyPayloadReceived(payload: payload));
    });

    weeklyPayloadController.stream.listen((payload) {
      add(WeeklyPayloadReceived(payload: payload));
    });

    monthlyPayloadController.stream.listen((payload) {
      add(MonthlyPayloadReceived(payload: payload));
    });

    on<SubscribeChannel>(_onSubscribeChannel);
    on<SubscribeMinuteChannel>(_onSubscribeMinuteChannel);
    on<SubscribeHourlyChannel>(_onSubscribeHourlyChannel);
    on<SubscribeDailyChannel>(_onSubscribeDailyChannel);
    on<SubscribeWeeklyChannel>(_onSubscribeWeeklyChannel);
    on<SubscribeMonthlyChannel>(_onSubscribeMonthlyChannel);

    on<PayloadReceived>(_onPayloadReceived);
    on<MinutePayloadReceived>(_onMinutePayloadReceived);
    on<HourlyPayloadReceived>(_onHourlyPayloadReceived);
    on<DailyPayloadReceived>(_onDailyPayloadReceived);
    on<WeeklyPayloadReceived>(_onWeeklyPayloadReceived);
    on<MonthlyPayloadReceived>(_onMonthlyPayloadReceived);

    on<GetSensorRange>(_onGetSensorRange);
    on<GetSensorsForUser>(_onGetSensorsForUser);
    on<AddAction>(_onAddAction);
  }

  void _onSubscribeChannel(
    SubscribeChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToChannel(event.sensorId, (payload) {
      //print("change received: ${jsonEncode(payload)}");
      payloadController.sink.add(payload);
    });
  }

  void _onSubscribeMinuteChannel(
    SubscribeMinuteChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToMinuteData(event.sensorId, (payload) {
      minutePayloadController.sink.add(payload);
    });
  }

  void _onSubscribeHourlyChannel(
    SubscribeHourlyChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToHourlyData(event.sensorId, (payload) {
//print("change received: ${jsonEncode(payload)}");
      hourlyPayloadController.sink.add(payload);
    });
  }

  void _onSubscribeDailyChannel(
    SubscribeDailyChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToDailyData(event.sensorId, (payload) {
//print("change received: ${jsonEncode(payload)}");
      dailyPayloadController.sink.add(payload);
    });
  }

  void _onSubscribeWeeklyChannel(
    SubscribeWeeklyChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToWeeklyData(event.sensorId, (payload) {
      weeklyPayloadController.sink.add(payload);
    });
  }

  void _onSubscribeMonthlyChannel(
    SubscribeMonthlyChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToMonthlyData(event.sensorId, (payload) {
      monthlyPayloadController.sink.add(payload);
    });
  }

  void _onPayloadReceived(
    PayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    print("EVENT.PAYLOAD ${event.payload}");
    emit(PayloadReceivedState(event.payload));
    // print('payloadReceived emmited $event.payload');
  }

  void _onMinutePayloadReceived(
    MinutePayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(MinutePayloadReceivedState(event.payload));
    print('minutePayloadReceivedState emmited ${event.payload}');
  }

  void _onHourlyPayloadReceived(
    HourlyPayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(HourlyPayloadReceivedState(event.payload));
    print('hourlyPayloadReceivedState emmited ${event.payload}');
  }

  void _onDailyPayloadReceived(
    DailyPayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(DailyPayloadReceivedState(event.payload));
    print('dailyPayloadReceivedState emmited $event.payload');
  }

  void _onWeeklyPayloadReceived(
    WeeklyPayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(WeeklyPayloadReceivedState(event.payload));
    print('weeklyPayloadReceivedState emmited $event.payload');
  }

  void _onMonthlyPayloadReceived(
    MonthlyPayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(MonthlyPayloadReceivedState(event.payload));
    print('monthlyPayloadReceivedState emmited $event.payload');
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

  @override
  Future<void> close() {
    payloadController.close();
    minutePayloadController.close();
    hourlyPayloadController.close();
    dailyPayloadController.close();
    return super.close();
  }
}
