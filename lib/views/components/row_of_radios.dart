import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  String valueGet;
  void Function(String) valueSet;

  RadioButtons({required this.valueGet, required this.valueSet, Key? key})
      : super(key: key);
  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  late String value;
  @override
  void initState() {
    value = widget.valueGet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Text('Status :'),
      Row(children: [
        Radio(
            value: 'Open',
            groupValue: value,
            onChanged: (String? val) {
              setState(() {
                value = val!;
              });
              widget.valueSet(val!);
            }),
        const Text('Open')
      ]),
      Row(children: [
        Radio(
            value: 'Closed',
            groupValue: value,
            onChanged: (String? val) {
              setState(() {
                value = val!;
              });
              widget.valueSet(val!);
            }),
        const Text('Closed')
      ])
    ]);
  }
}
