import 'package:flutter/material.dart';

class ReminderToggle extends StatefulWidget {
  @override
  _ReminderToggleState createState() => _ReminderToggleState();
}

class _ReminderToggleState extends State<ReminderToggle> {
  bool isReminderOn = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Reminders', style: TextStyle(fontSize: 18)),
        Switch(
          value: isReminderOn,
          onChanged: (value) {
            setState(() {
              isReminderOn = value;
            });
          },
        ),
      ],
    );
  }
}
