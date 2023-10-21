import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseChannelsTest extends StatefulWidget {
  const SupabaseChannelsTest({super.key});

  @override
  State<SupabaseChannelsTest> createState() => _SupabaseChannelsTestState();
}

class _SupabaseChannelsTestState extends State<SupabaseChannelsTest> {
  late String? content = "";
  final testChannel = supabaseManager.supabaseClient.channel("myChannel");

  void subscribeToStream() {
    debugPrint("subscribing to stream");
    testChannel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
            event: "update",
            schema: "public",
            table: "realtimeTestData",
            filter: "id=eq.8"), (payload, [ref]) {
      debugPrint("ref: ${[ref]}");
      debugPrint("payload: $payload");
      debugPrint("Data Updated to:  ${payload["new"]['value']}");
      debugPrint("Old value :  ${payload["old"]['value']}");
      if (payload != null && payload.isNotEmpty) {
        var oldValue = payload["old"]["value"];
        var newValue = payload["new"]["value"];
        setState(() {
          content = newValue.toString();
        });
      }
    }).subscribe();
  }

  @override
  void initState() {
    super.initState();
    subscribeToStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBackAction(),
      body: Center(
          heightFactor: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 65),
                child: Text(
                  "${content} %",
                  style: TextStyle(fontSize: 40),
                )),
            // ElevatedButton(
            //     onPressed: () => {debugPrint("Content: ${content}")},
            //     child: Text("dsa"))
          ])),
    );
  }
}
