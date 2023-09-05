import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/action_class.dart';

class ActionPopup extends StatefulWidget {
  final BuildContext context;

  const ActionPopup({required this.context, super.key});

  @override
  State<ActionPopup> createState() => _ActionPopupState();
}

List<String> list = <String>['Above', 'Equal', 'Below'];

List<String> actionList = <String>['notification'];

class _ActionPopupState extends State<ActionPopup> {
  late TextEditingController conditionValue;
  late TextEditingController actionType;

  String dropdownCondition = list.first;
  String dropdownAction = actionList.first;

  @override
  void initState() {
    super.initState();
    conditionValue = TextEditingController();
    actionType = TextEditingController();
  }

  @override
  void dispose() {
    conditionValue.dispose();
    super.dispose();
  }

  void submit() {
    ActionClass actionClass = ActionClass(condition: dropdownCondition, conditionValue: double.parse(conditionValue.text ?? "0"), action: dropdownAction);
    Navigator.of(context).pop(actionClass);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sensor action'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Text("set condition"),
            Row(
              children: [
                DropdownMenu<String>(
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownCondition = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(hintText: 'Enter value'),
                    controller: conditionValue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text("choose action"),
            DropdownMenu<String>(
                  initialSelection: actionList.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownAction = value!;
                    });
                  },
                  dropdownMenuEntries:
                      actionList.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: submit,
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }
}
