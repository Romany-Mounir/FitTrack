import 'package:fit_track/common_libs.dart';
import 'package:fit_track/models/goal_model.dart';
import 'package:flutter/material.dart';
import '../widgets/goal_card.dart';
import '../widgets/reminder_toggle.dart';
import 'add_edit_goal_screen.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<GoalModel> goals = [
    GoalModel(title: 'Steps', current: 6700, goal: 10000),
    GoalModel(title: 'Weekly Workouts', current: 3, goal: 4),
    GoalModel(title: 'Calories', current: 2300, goal: 3500),
  ];

  void _addOrEditGoal(GoalModel? goal) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditGoalScreen(goal: goal)),
    );

    if (result != null && result is GoalModel) {
      setState(() {
        if (goal == null) {
          goals.add(result);
        } else {
          int index = goals.indexOf(goal);
          goals[index] = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Goals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Goals', style: TextStyle(fontSize: 24)),
            ...goals
                .map(
                  (goal) => GoalCard(
                    goal: goal,
                    onEdit: (goal) => _addOrEditGoal(goal),
                  ),
                )
                .toList(),
            SizedBox(height: 20),
            PrimaryButton(
              text: 'Add a Goal',
              onPressed: () => _addOrEditGoal(null),
            ),
            SizedBox(height: 20),
            ReminderToggle(),
          ],
        ),
      ),
    );
  }
}
