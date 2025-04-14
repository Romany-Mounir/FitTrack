import 'package:flutter/material.dart';

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const AchievementTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Colors.grey.shade700),
        ),
        title: Text(label),
      ),
    );
  }
}
