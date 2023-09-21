import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_ohmio_tutorial.dart';

class PintunnelTutorialFirstPage extends StatelessWidget {
  const PintunnelTutorialFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarOhmioTutorial(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text("OHMIO Tutorial",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 36, fontWeight: FontWeight.w500))),
          Image(
            image: AssetImage("assets/sensor.gif"),
            width: 307,
            height: 260,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,10,0),
            child: Text(
              "Press the button to see the information of sensor in detail",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(fontSize: 20),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 194,
            height: 44,
            child: ElevatedButton(
              child: Text(
                "Next",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(fontSize: 29),
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                GoRouter.of(context).push("/pintunnelTutorialSecondPage");
              },
            ),
          ),
        ],
      ),
    );
  }
}
