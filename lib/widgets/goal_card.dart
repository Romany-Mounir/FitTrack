import 'package:fit_track/models/goal_model.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final Function(GoalModel) onEdit;

  GoalCard({required this.goal, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(goal.title, style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => onEdit(goal),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: goal.current / goal.goal,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
                Text(
                  '${goal.current} / ${goal.goal}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
