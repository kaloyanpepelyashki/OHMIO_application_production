import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';

class MockSubscribeChannelLogic extends Mock implements SubscribeChannelLogic {}

void main() {
  late MockSubscribeChannelLogic mockSubscribeChannelLogic;
  late PinTunnelBloc pinTunnelBloc;

  setUp(() {
    mockSubscribeChannelLogic = MockSubscribeChannelLogic();
    pinTunnelBloc =
        PinTunnelBloc(subscribeChannelLogic: mockSubscribeChannelLogic);
  });
  group('PinTunnelBloc', () {
    test('initial state is InitialState', () {
      expect(pinTunnelBloc.state, InitialState());
    });
    blocTest(
      'emits [] when nothing is added',
      build: () =>
          PinTunnelBloc(subscribeChannelLogic: MockSubscribeChannelLogic()),
      expect: () => [],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'emits [PayloadReceivedState] when _payloadController adds an event',
      build: () {
        when(() => mockSubscribeChannelLogic.subscribeToChannel(any(), any()))
            .thenAnswer((_) {});
        return pinTunnelBloc;
      },
      act: (bloc) {
        bloc.payloadController.sink.add({'key': 'value'});
      },
      expect: () => [
        PayloadReceivedState({'key': 'value'})
      ],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'emits [PayloadReceivedState] multiple times when PayloadReceived is added',
      build: () => pinTunnelBloc,
      act: (bloc) {
        bloc.add(PayloadReceived(payload: {'key1': 'value1'}));
      },
      expect: () => [
        PayloadReceivedState({'key1': 'value1'}),
      ],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'emits [PayloadReceivedState] multiple times when PayloadReceived is added multiple times',
      build: () => pinTunnelBloc,
      act: (bloc) {
        bloc.add(PayloadReceived(payload: {'key1': 'value1'}));
        bloc.add(PayloadReceived(payload: {'key2': 'value2'}));
        bloc.add(PayloadReceived(payload: {'key3': 'value3'}));
        bloc.add(PayloadReceived(payload: {'key4': 'value4'}));
      },
      expect: () => [
        PayloadReceivedState({'key1': 'value1'}),
        PayloadReceivedState({'key2': 'value2'}),
        PayloadReceivedState({'key3': 'value3'}),
        PayloadReceivedState({'key4': 'value4'}),
      ],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'calls subscribeToChannel with correct parameters when SubscribeChannel is added',
      build: () => pinTunnelBloc,
      act: (bloc) {
        bloc.add(SubscribeChannel(channelName: '*'));
      },
      verify: (_) {
        verify(() => mockSubscribeChannelLogic.subscribeToChannel('*', any()));
      },
    );
/*
    blocTest<PinTunnelBloc, PinTunnelState>(
      'does not emit any state when subscribeToChannel throws an exception',
      build: () {
        when(() => mockSubscribeChannelLogic.subscribeToChannel(any(), any()))
            .thenThrow(Exception('Test Exception'));
        return pinTunnelBloc;
      },
      act: (bloc) {
        bloc.add(SubscribeChannel(channelName: 'test'));
      },
      expect: () => [],
    );
    */
  });
}
