import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelEvent.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class DependencyChooseSensor extends StatefulWidget {
  const DependencyChooseSensor({super.key});

  @override
  State<DependencyChooseSensor> createState() => _DependencyChooseSensorState();
}

class _DependencyChooseSensorState extends State<DependencyChooseSensor> {

  @override
  void initState() {
    getSensors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                GoRouter.of(context).push("/dependencyCondition");
              },
              child: Container(
                width: 300,
                height: 77,
                color: Color(0xFFFFD9D9D9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Self",
                      style: GoogleFonts.inter(
                        textStyle:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.plus,
                        size: 30,
                      ),
                      onPressed: () async {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 77,
              color: Color(0xFFFFD9D9D9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Sensor name",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 30,
                    ),
                    onPressed: () async {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 77,
              color: Color(0xFFFFD9D9D9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Sensor name",
                    style: GoogleFonts.inter(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 30,
                    ),
                    onPressed: () async {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 77,
              color: Color(0xFFFFD9D9D9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Sensor name",
                    style: GoogleFonts.inter(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 30,
                    ),
                    onPressed: () async {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    void getSensors() {
    var _session = supabaseManager.supabaseSession;
    _session = supabaseManager.supabaseClient.auth.currentSession;
    BlocProvider.of<PinTunnelBloc>(context)
        .add(GetSensorsForUser(email: _session!.user.email!));
  }
}
