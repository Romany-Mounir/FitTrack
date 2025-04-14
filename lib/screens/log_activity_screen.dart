import '../common_libs.dart';

class LogActivityScreen extends StatefulWidget {
  const LogActivityScreen({super.key});

  @override
  LogActivityScreenState createState() => LogActivityScreenState();
}

class LogActivityScreenState extends State<LogActivityScreen> {
  String _activityType = 'Running';
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  @override
  void dispose() {
    _durationController.dispose();
    _distanceController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Activity'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity Type', style: TextStyle(fontSize: 16)),
            DropdownButtonFormField<String>(
              value: _activityType,
              items: ['Running', 'Walking', 'Cycling']
                  .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _activityType = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Duration', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: 'min',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Distance', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: 'km',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Calories', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // TODO: Add Google Fit sync logic
              },
              child: Text('SYNC WITH GOOGLE FIT'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Add Save logic
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Center(child: Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}