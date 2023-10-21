import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';

class SupabaseRealTimeTest extends StatefulWidget {
  const SupabaseRealTimeTest({super.key});

  @override
  State<SupabaseRealTimeTest> createState() => _SupabaseRealTimeTestState();
}

class _SupabaseRealTimeTestState extends State<SupabaseRealTimeTest> {
  List list = [];
  final stream = supabaseManager.supabaseClient
      .from("realtimeTestData")
      .stream(primaryKey: ['id']).eq("id", 8);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBackAction(),
      body: Center(
          heightFactor: 1000,
          child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                debugPrint("$snapshot");
                final list = snapshot.data!;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Text(list[index]['value'].toString());
                    });
              })),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
            context: context,
            builder: ((context) {
              return SimpleDialog(
                title: Text("Test"),
                children: [
                  TextFormField(
                    onFieldSubmitted: (value) async {
                      await supabaseManager.supabaseClient
                          .from("realtimeTestData")
                          .insert({'value': value});
                    },
                  )
                ],
              );
            }));
      }),
    );
  }
}
