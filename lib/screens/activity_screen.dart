import 'package:flutter/material.dart';
import '../widgets/chart_line.dart';
import '../widgets/chart_bar.dart';
import '../widgets/achievement_tile.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedTab = 0; // Steps / Calories / Time
  int _selectedView = 0; // Day / Week / Month

  final List<String> metrics = ['Steps', 'Calories', 'Time'];
  final List<String> views = ['Day', 'Week', 'Month'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Activity"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tabs: Steps / Calories / Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(metrics.length, (index) {
                  final selected = _selectedTab == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedTab = index);
                      print("Switched to tab: $_selectedTab");
                    },
                    child: Column(
                      children: [
                        Text(
                          metrics[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.black : Colors.grey,
                          ),
                        ),
                        if (selected)
                          Container(
                            height: 3,
                            width: 40,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // View by: Day / Week / Month
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(views.length, (index) {
                  final selected = _selectedView == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedView = index);
                      print("Switched to view: $_selectedView");
                    },
                    child: Text(
                      views[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: selected ? Colors.black : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              if (_selectedTab == 0) ...[
                const SizedBox(height: 20),
                const Text(
                  "Total Steps",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ChartLine(
                  key: ValueKey('line_$_selectedTab-$_selectedView'),
                  viewIndex: _selectedView,
                ),
                const SizedBox(height: 30),

                const Text(
                  "Achievements",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 12),

                const AchievementTile(
                  icon: Icons.directions_walk,
                  label: "5K Steps",
                ),
                const AchievementTile(icon: Icons.star, label: "Weekly Goal"),

                const SizedBox(height: 30),

                const Text(
                  "Progress",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 12),

                ChartBar(
                  key: ValueKey('bar_$_selectedTab-$_selectedView'),
                  viewIndex: _selectedView,
                ),
              ] else if (_selectedTab == 1) ...[
                const SizedBox(height: 20),
                const Text(
                  "Calories Burned",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ChartLine(
                  key: ValueKey('line_$_selectedTab-$_selectedView'),
                  viewIndex: _selectedView,
                ),
                const SizedBox(height: 30),

                const Text(
                  "Achievements",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 12),
                const SizedBox(height: 20),
                const AchievementTile(
                  icon: Icons.local_fire_department,
                  label: "500 Cal Goal",
                ),
                const AchievementTile(
                  icon: Icons.bolt,
                  label: "High Intensity Day",
                ),
                const SizedBox(height: 30),
                ChartBar(
                  key: ValueKey('bar_$_selectedTab-$_selectedView'),
                  viewIndex: _selectedView,
                ),
              ] else if (_selectedTab == 2) ...[
                const SizedBox(height: 20),
                const Text(
                  "Exercise Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ChartLine(
                  key: ValueKey('line_$_selectedTab-$_selectedView'),
                  viewIndex: _selectedView,
                ),
                const SizedBox(height: 30),

                const Text(
                  "Achievements",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 12),
                const SizedBox(height: 20),
                const AchievementTile(
                  icon: Icons.timer,
                  label: "30 Min Workout",
                ),
                const AchievementTile(
                  icon: Icons.accessibility_new,
                  label: "Daily Stretch Done",
                ),
                const SizedBox(height: 30),
                ChartBar(
                  key: ValueKey('bar_$_selectedTab-$_selectedView'),
                  viewIndex: _selectedView,
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
