import 'package:fit_track/models/goal_model.dart';
import 'package:flutter/material.dart';

class AddEditGoalScreen extends StatefulWidget {
  final GoalModel? goal;

  AddEditGoalScreen({this.goal});

  @override
  _AddEditGoalScreenState createState() => _AddEditGoalScreenState();
}

class _AddEditGoalScreenState extends State<AddEditGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _goalTitle;
  late int _goalValue;

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _goalTitle = widget.goal!.title;
      _goalValue = widget.goal!.goal;
    } else {
      _goalTitle = '';
      _goalValue = 0;
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
        title: Text(widget.goal == null ? 'Add Goal' : 'Edit Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _goalTitle,
                decoration: InputDecoration(labelText: 'Goal Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _goalTitle = value!;
                },
              ),
              TextFormField(
                initialValue: widget.goal?.goal.toString(),
                decoration: InputDecoration(labelText: 'Goal Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _goalValue = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      GoalModel(
                        title: _goalTitle,
                        current: 0,
                        goal: _goalValue,
                      ),
                    );
                  }
                },
                child: Text(widget.goal == null ? 'Save Goal' : 'Update Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
