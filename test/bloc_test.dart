import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/sensor_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/usecases/subscribe_channel_logic.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';

class MockSubscribeChannelLogic extends Mock implements SubscribeChannelLogic {}
class MockSensorLogic extends Mock implements SensorLogic{}


void main() {
  late SubscribeChannelLogic mockSubscribeChannelLogic;
  late PinTunnelBloc pinTunnelBloc;
  late SensorLogic mockSensorLogic;

  setUp(() {
    mockSubscribeChannelLogic = MockSubscribeChannelLogic();
    mockSensorLogic = MockSensorLogic();
    pinTunnelBloc =
        PinTunnelBloc(subscribeChannelLogic: mockSubscribeChannelLogic, sensorLogic: mockSensorLogic, );
  });
  group('PinTunnelBloc', () {
    test('initial state is InitialState', () {
      expect(pinTunnelBloc.state, InitialState());
    });
    blocTest(
      'emits [] when nothing is added',
      build: () =>
          PinTunnelBloc(subscribeChannelLogic: mockSubscribeChannelLogic, sensorLogic: mockSensorLogic),
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
        const PayloadReceivedState({'key': 'value'})
      ],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'emits [PayloadReceivedState] multiple times when PayloadReceived is added',
      build: () => pinTunnelBloc,
      act: (bloc) {
        bloc.add(const PayloadReceived(payload: {'key1': 'value1'}));
      },
      expect: () => [
        const PayloadReceivedState({'key1': 'value1'}),
      ],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'emits [PayloadReceivedState] multiple times when PayloadReceived is added multiple times',
      build: () => pinTunnelBloc,
      act: (bloc) {
        bloc.add(const PayloadReceived(payload: {'key1': 'value1'}));
        bloc.add(const PayloadReceived(payload: {'key2': 'value2'}));
        bloc.add(const PayloadReceived(payload: {'key3': 'value3'}));
        bloc.add(const PayloadReceived(payload: {'key4': 'value4'}));
      },
      expect: () => [
        const PayloadReceivedState({'key1': 'value1'}),
        const PayloadReceivedState({'key2': 'value2'}),
        const PayloadReceivedState({'key3': 'value3'}),
        const PayloadReceivedState({'key4': 'value4'}),
      ],
    );

    blocTest<PinTunnelBloc, PinTunnelState>(
      'calls subscribeToChannel with correct parameters when SubscribeChannel is added',
      build: () => pinTunnelBloc,
      act: (bloc) {
        bloc.add(const SubscribeChannel(sensorId: 12345));
      },
      verify: (_) {
        verify(() => mockSubscribeChannelLogic.subscribeToChannel(12345, any()));
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
