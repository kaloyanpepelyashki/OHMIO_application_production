import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/subscribe_channel_logic.dart';
import 'PinTunnelEvent.dart';
import 'PinTunnelState.dart';

class PinTunnelBloc extends Bloc<PinTunnelEvent, PinTunnelState> {
  final SubscribeChannelLogic subscribeChannelLogic;
  final _payloadController = StreamController<String>();

  PinTunnelBloc({
    required this.subscribeChannelLogic,
  }) : super(InitialState()) {
    _payloadController.stream.listen((payload) {
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
        _payloadController.sink.add(payload);
    });
}

  void _onPayloadReceived(
    PayloadReceived event,
    Emitter<PinTunnelState> emit,
  ) {
    // Handle the PayloadReceived event here.
    // For example, you can emit a new state:
    emit(PayloadReceivedState(event.payload));
    print('payloadReceived emmited ' + event.payload);
  }
}
