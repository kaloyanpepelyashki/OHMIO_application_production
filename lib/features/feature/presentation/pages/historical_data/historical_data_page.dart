import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/sensor_class.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dahboard_top_bar_burger_menu.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/dashboard/grid_item_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/historical_data/historical_data_item.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class HistoricalDataPage extends StatefulWidget {
  const HistoricalDataPage({super.key});

  @override
  State<HistoricalDataPage> createState() => _HistoricalDataPageState();
}

class _HistoricalDataPageState extends State<HistoricalDataPage> {
  List<SensorClass> listOfSensors = [];
  final List<String> themeColors = ['card1', 'card2', 'card3', 'card4'];

  @override
  void initState() {
    var _session = supabaseManager.supabaseSession;
    _session = supabaseManager.supabaseClient.auth.currentSession;
    BlocProvider.of<PinTunnelBloc>(context)
        .add(GetHistoricalData(email: _session!.user.email!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {
        if (state is HistoricalDataReceivedState) {
          if (state.listOfSensors.isNotEmpty) {
            listOfSensors = state.listOfSensors;
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: const TopBarBackAction(),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: CustomScrollView(primary: false, slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3,
                  children: [
                    if (listOfSensors.isNotEmpty)
                      for (int i = 0; i < listOfSensors.length; i++)
                        HistoricalDataItem(
                          id: int.parse(listOfSensors[i].sensorMac!),
                          sensorName: listOfSensors[i].sensorName,
                          sensorImage: listOfSensors[i].sensorImage,
                          sensorDescription:
                              listOfSensors[i].sensorDescription!,
                          themeColor: themeColors[i % 4],
                        ),
                  ],
                ),
              ),
            ]));
      },
    );
  }
}
