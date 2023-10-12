import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/data/data_sources/supabase_service.dart';

import '../../domain/entities/user_class.dart';

class UserProfileHeader extends StatefulWidget {
  const UserProfileHeader({super.key});

  @override
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader> {
  List<UserData> _userData = [];

  void fetchUserData() async {
    final dataBaseResponse = await supabaseManager.getUserData();
    debugPrint(_userData.toString());
    dataBaseResponse.fold(
        ifLeft: (l) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$l"),
                backgroundColor: const Color.fromARGB(156, 255, 1, 1),
              ))
            },
        ifRight: (r) => {
              setState(() {
                _userData = r;
              })
            });
  }

  @override
  initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_userData.isEmpty) {
      return CircularProgressIndicator();
    }
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            Text(
              "Hello ${_userData.first.firstName}",
              style: TextStyle(fontSize: 24),
            )
          ],
        ));
    ;
  }
}
