import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/top_bar_back_action.dart';

class BlinkerInput extends StatefulWidget {
  const BlinkerInput({super.key});

  @override
  State<BlinkerInput> createState() => BlinkerInputState();
}

class BlinkerInputState extends State<BlinkerInput> {
  //Assigning the controller of the input field
  final controller = TextEditingController();

  //assigning the variable that holds the binary value of the input string
  var binaryValue;

  ValueNotifier<Color> signalState = ValueNotifier<Color>(Colors.transparent);

  String convertToBinary() {
    return "111111${controller.text.codeUnits.map((x) => x.toRadixString(2).padLeft(8, '0')).join()}111111";
  }

  void sendSignal() async {
    binaryValue = convertToBinary();
    debugPrint(binaryValue);
    //Iterates through each of the characters of the binary value
    for (var i = 0; i < binaryValue.length; i++) {
      var char = binaryValue[i];
      await Future.delayed(const Duration(milliseconds: 20));

      //Sets the state of the widget
      setState(() {
        if (char == "1") {
          signalState.value = Colors.white;
          debugPrint("white");
        } else if (char == "0") {
          signalState.value = Colors.black;
          debugPrint("black");
        }
      });
    }
    //Closes the dialog widget after the signal is over.
    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext dialogContext) {
    return Scaffold(
        appBar: const TopBarBackAction(),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 1.0,
                child: Column(children: [
                  TextField(
                      //Passing the TextEditing controller to the Text Field
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: "Enter a string",
                          enabledBorder: OutlineInputBorder())),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const SizedBox(
                                    child: AlertDialog(
                                        content: Text("Please enter a text")));
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                dialogContext = context;
                                return SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: SignalDialog(
                                      signalState: signalState,
                                      sendSignalCallback: sendSignal,
                                    ));
                              });
                        }
                      },
                      child: const Text("Convert to binary"))
                ]))));
  }
}

class BinaryEncoderPage extends StatelessWidget {
  const BinaryEncoderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlinkerInput();
  }
}

class SignalDialog extends StatelessWidget {
  const SignalDialog(
      {super.key, required this.signalState, required this.sendSignalCallback});

  final ValueNotifier<Color> signalState;
  final VoidCallback sendSignalCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder<Color>(
                    valueListenable: signalState,
                    builder: (context, value, child) {
                      return Container(
                        width: 350,
                        height: 350,
                        color: value,
                      );
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      child: ElevatedButton(
                        onPressed: sendSignalCallback,
                        child: const Text("Signal"),
                      )),
                ],
              ),
            )));
  }
}
