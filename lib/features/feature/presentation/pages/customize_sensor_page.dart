import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelState.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/elevated_button_component.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class CustomizeSensorPage extends StatefulWidget {
  final String sensorId;
  const CustomizeSensorPage({required this.sensorId, super.key});

  @override
  State<CustomizeSensorPage> createState() => _CustomizeSensorPageState();
}

class _CustomizeSensorPageState extends State<CustomizeSensorPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController placementController = TextEditingController();

  @override
  void initState() {
    print("SENSOR ID: ${widget.sensorId}");
    super.initState();
  }

  @override
  void dispose() {
    nicknameController!.dispose();
    placementController!.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
              appBar: TopBarBackAction(),
              backgroundColor: Theme.of(context).colorScheme.background,

              body: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Customize your sensor",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Nickname",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                key: Key("emailField"),
                                controller: nicknameController!,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16.0),
                                    hintText: 'Nickname',
                                    hintStyle: TextStyle(fontSize: 18)),
                                obscureText: false,
                              )),
                          SizedBox(height: 10),
                          Text(
                            "Where you would like to place your sensor",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                controller: placementController!,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16.0),
                                    hintText: 'Living Room',
                                    hintStyle: TextStyle(fontSize: 18)),
                                obscureText: false,
                              )),
                          SizedBox(height: 10),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      width: 248,
                      height: 44,
                      child: ElevatedButtonComponent(
                        text: "Save",
                        onPressed: () {
                          saveCustomization();
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
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
