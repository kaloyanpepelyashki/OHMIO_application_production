import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/inputField_with_heading.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/widgets/top_bar_back_action.dart';
import "package:timezone/standalone.dart" as tz;

import '../../../data/data_sources/supabase_service.dart';
import '../../../domain/entities/user_class.dart';
import '../../widgets/elevated_button_component.dart';

class OnBoardingPersonalDataPage extends StatefulWidget {
  const OnBoardingPersonalDataPage({super.key});

  @override
  State<OnBoardingPersonalDataPage> createState() =>
      _OnBoardingPersonalDataPageState();
}

class _OnBoardingPersonalDataPageState
    extends State<OnBoardingPersonalDataPage> {
  //Ipnut field TextEditing controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final _userProfile = userProfile;
  final _session = supabaseManager.supabaseClient.auth.currentSession;

  //Uploads the user data to the databse
  Future<Either<Exception, void>> uploadToDatabase() async {
    try {
      tz.Location utc = tz.getLocation('UTC');
      await supabaseManager.supabaseClient.from("profiles").update({
        "email": supabaseManager.user?.email,
        "first_name": _nameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        "updated_at": tz.TZDateTime.from(DateTime.now(), utc).toIso8601String(),
      }).eq("id", supabaseManager.user?.id);
      return const Either.right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Either.left(
          Exception("Unexpected error occured while uploading data"));
    }
  }

  void populateUserProfile() {
    _userProfile.onboarding(
        _nameController.text.trim(),
        _lastNameController.text.trim(),
        _session?.user.email,
        DateTime.now(),
        _session?.user.email);
  }

  void getPersonalData() async {
    debugPrint(supabaseManager.user?.id);
    try {
      //Checks if the input field have been filled out by the user.
      if (_nameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty) {
        final uploadResult = await uploadToDatabase();
        uploadResult.fold(
            ifLeft: (l) => {
                  populateUserProfile(),
                  GoRouter.of(context).go("/signup/onboarding-username")
                },
            ifRight: (r) => {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please fill out all fields"),
                    backgroundColor: Color.fromARGB(156, 255, 1, 1),
                  ))
                });
      } else {
        //If the input field haven't been filled out by the user it throws an alert on screen
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please fill out all fields"),
          backgroundColor: Color.fromARGB(156, 255, 1, 1),
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _userProfile.empty();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarBackAction(),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.8,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: const Image(
                          image: AssetImage('assets/brandmark-design.png'),
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: InputFieldWithHeading(
                                controller: _nameController,
                                heading: "A little bit about you",
                                placeHolder: "Name",
                              )),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: TextField(
                                  controller: _lastNameController,
                                  decoration: const InputDecoration(
                                      hintText: "Last name",
                                      enabledBorder: OutlineInputBorder())))
                        ])),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButtonComponent(
                          onPressed: () {
                            getPersonalData();
                          },
                          text: "Next",
                        )),
                  ],
                ))));
  }
}
