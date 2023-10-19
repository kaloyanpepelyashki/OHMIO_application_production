import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class CustomizeSensorPage extends StatefulWidget {
  final String sensorId;
  const CustomizeSensorPage({required this.sensorId, super.key});

  @override
  State<CustomizeSensorPage> createState() => _CustomizeSensorPageState();
}

class _CustomizeSensorPageState extends State<CustomizeSensorPage> {
  TextEditingController? nicknameController;
  TextEditingController? placementController;

  @override
  void initState() {
    nicknameController = TextEditingController();
    placementController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        
        return Scaffold(
          appBar: TopBarBackAction(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Text("Customize your sensor"),
              Text("Nickname"),
              TextField(controller: nicknameController),
              Text("Where you would like to place your sensor"),
              TextField(controller: placementController),
              Text("Select an icon for your sensor"),
              SizedBox(height: 100),
              ElevatedButton(
                child: Text("Save"),
                onPressed: () {
                  saveCustomization();
                },
              ),
              Text("Skip")
            ],
          ),
        );
      },
    );
  }

  void saveCustomization() {
    String nickname = '';
    String sensorPlacement = '';
    String iconName = '';
    if (nicknameController!.text.isNotEmpty) {
      nickname = nicknameController!.text;
    }
    if (placementController!.text.isNotEmpty) {
      sensorPlacement = placementController!.text;
    }

    BlocProvider.of<PinTunnelBloc>(context).add(
      SaveSensorCustomization(
        sensorId: int.parse(widget.sensorId),
        nickname: nickname,
        sensorPlacement: sensorPlacement,
        iconName: iconName,
      ),
    );

    var _session = supabaseManager.supabaseSession;
    _session = supabaseManager.supabaseClient.auth.currentSession;

    GoRouter.of(context).pushNamed("dashboard", pathParameters: {
      "email": _session!.user.email!,
    });
  }
}
