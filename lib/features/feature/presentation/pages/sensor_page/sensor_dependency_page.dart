import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class SensorDependencyPage extends StatelessWidget {
  const SensorDependencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBackAction(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(

      )
    );
  }
}