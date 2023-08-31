import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/subscribe_channel_logic.dart';
import 'PinTunnelEvent.dart';
import 'PinTunnelState.dart';

class PinTunnelBloc extends Bloc<PinTunnelEvent, PinTunnelState> {
  final SubscribeChannelLogic subscribeChannelLogic;
  final payloadController = StreamController<Map<String, dynamic>>();

  PinTunnelBloc({
    required this.subscribeChannelLogic,
  }) : super(InitialState()) {
    payloadController.stream.listen((payload) {
      add(PayloadReceived(payload: payload));
    });
    
    on<SubscribeChannel>(_onSubscribeChannel);
    on<PayloadReceived>(_onPayloadReceived);
  }

  void _onSubscribeChannel(
    SubscribeChannel event,
    Emitter<PinTunnelState> emit,
) async {
    subscribeChannelLogic.subscribeToChannel(event.channelName, (payload) {
        
//print("change received: ${jsonEncode(payload)}");
        payloadController.sink.add(payload);
    });
}

  void _onPayloadReceived(
    PayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    emit(PayloadReceivedState(event.payload));
    print('payloadReceived emmited $event.payload');
  }
}
