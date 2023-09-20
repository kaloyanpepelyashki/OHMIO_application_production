import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/pages/dashboard/dashboard_page.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/back_action_btn.dart';

class TopBarOhmioTutorial extends StatefulWidget
    implements PreferredSizeWidget {
  const TopBarOhmioTutorial({super.key});

  @override
  State<TopBarOhmioTutorial> createState() => _TopBarOhmioTutorialState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarOhmioTutorialState extends State<TopBarOhmioTutorial> {
  SupabaseManager supabaseManager = SupabaseManager(
    supabaseUrl: "https://wruqswjbhpvpikhgwade.supabase.co",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackActionBtn(
          icon: Icons.arrow_back,
          onPressed: () {
            //Removes layer from the navigation stack
            Navigator.pop(context);
          }),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,15,20,0),
          child: GestureDetector(
              child: Text(
                "Skip",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {
                GoRouter.of(context).pushNamed("dashboard", pathParameters: {
                  "email": "kuba.kolando.02.01@gmail.com",
                });
              }),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      leadingWidth: 100,
    );
  }
}
