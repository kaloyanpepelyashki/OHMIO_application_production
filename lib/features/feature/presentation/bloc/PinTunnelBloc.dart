import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/sensor_logic.dart';
import '../../domain/usecases/subscribe_channel_logic.dart';
import 'PinTunnelEvent.dart';
import 'PinTunnelState.dart';

class PinTunnelBloc extends Bloc<PinTunnelEvent, PinTunnelState> {
  final SubscribeChannelLogic subscribeChannelLogic;
  final SensorLogic sensorLogic;
  final payloadController = StreamController<Map<String, dynamic>>();

  final minutePayloadController = StreamController<Map<String, dynamic>>();
  final hourlyPayloadController = StreamController<Map<String, dynamic>>();
  final dailyPayloadController = StreamController<Map<String, dynamic>>();

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

    on<SubscribeChannel>(_onSubscribeChannel);
    on<SubscribeMinuteChannel>(_onSubscribeMinuteChannel);
    on<SubscribeHourlyChannel>(_onSubscribeHourlyChannel);
    on<SubscribeDailyChannel>(_onSubscribeDailyChannel);
    on<PayloadReceived>(_onPayloadReceived);
    on<MinutePayloadReceived>(_onMinutePayloadReceived);
    on<HourlyPayloadReceived>(_onHourlyPayloadReceived);

    on<GetSensorRange>(_onGetSensorRange);
  }

  void _onSubscribeChannel(
    SubscribeChannel event,
    Emitter<PinTunnelState> emit,
  ) async {
    subscribeChannelLogic.subscribeToChannel(event.sensorId, (payload) {
print("change received: ${jsonEncode(payload)}");
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

  void _onPayloadReceived(
    PayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(PayloadReceivedState(event.payload));
    print('payloadReceived emmited $event.payload');
  }

  void _onMinutePayloadReceived(
    MinutePayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(MinutePayloadReceivedState(event.payload));
    print('minutePayloadReceivedState emmited $event.payload');
  }

  void _onHourlyPayloadReceived(
    HourlyPayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(HourlyPayloadReceivedState(event.payload));
    print('hourlyPayloadReceivedState emmited $event.payload');
  }

  void _onDailyPayloadReceived(
    DailyPayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(DailyPayloadReceivedState(event.payload));
    print('dailyPayloadReceivedState emmited $event.payload');
  }

  void _onGetSensorRange(
    GetSensorRange event,
    Emitter<PinTunnelState> emit,
  ) async {
    final result = await sensorLogic.getRangeForSensor(12345);
    result.fold(
      ifLeft: (value) => print(value),
      ifRight: (value) => {
        emit(SensorRangeReceivedState(value))},
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
