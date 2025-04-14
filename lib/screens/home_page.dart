import 'dart:io';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common_libs.dart';
import '../utils/health_util.dart';
import 'health_example.dart';

final health = Health();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserModel? user;
  double stepPercent = 0.0;
  int currentSteps = 0;
  int caloriesBurned = 0;
  int activeMinutes = 0;
  bool dataAvailable = true;
  final int goalSteps = 10000;
  AppState _state = AppState.DATA_NOT_FETCHED;


  List<HealthDataType> get types =>
      (Platform.isAndroid)
          ? dataTypesAndroid
          : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  List<HealthDataAccess> get permissions =>
      types
          .map(
            (type) =>
                // can only request READ permissions to the following list of types on iOS
                [
                      HealthDataType.WALKING_HEART_RATE,
                      HealthDataType.ELECTROCARDIOGRAM,
                      HealthDataType.HIGH_HEART_RATE_EVENT,
                      HealthDataType.LOW_HEART_RATE_EVENT,
                      HealthDataType.IRREGULAR_HEART_RATE_EVENT,
                      HealthDataType.EXERCISE_TIME,
                    ].contains(type)
                    ? HealthDataAccess.READ
                    : HealthDataAccess.READ_WRITE,
          )
          .toList();

  @override
  void initState() {
    super.initState();
    Future.wait([fetchHealthData()]);
  }

  Future<bool> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, "This is only available on Android");

    final HealthConnectSdkStatus? status =
        await health.getHealthConnectSdkStatus();

    Logger().d(status?.name);

    return status == HealthConnectSdkStatus.sdkAvailable;
  }

  Future<bool> authorize() async {
    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.

    await getHealthConnectSdkStatus();

    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we have health permissions
    bool? hasPermissions = await health.hasPermissions(
      types,
      permissions: permissions,
    );

    // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
    // Hence, we have to request with WRITE as well.
    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized = await health.requestAuthorization(
          types,
          permissions: permissions,
        );

        // request access to read historic data
        await health.requestHealthDataHistoryAuthorization();
      } catch (error) {
        Logger().e("Exception in authorize: $error");
      }
    }

    setState(
          () =>
      _state =
      (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED,
    );
    return (authorized);
  }

  Future<void> fetchHealthData() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    // Request permissions
    // await Permission.activityRecognition.request();

    bool accessWasGranted = await authorize();

    if (accessWasGranted) {
      try {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          types: types,
          startTime: midnight,
          endTime: now,
        );

        Logger().i(
          healthData.map((d) => d.toJson().toString()).toList().toString(),
        );

        if (healthData.isEmpty) {
          setState(() => dataAvailable = false);
          return;
        }

        int totalSteps = 0;
        double totalCalories = 0;
        int totalMinutes = 0;

        for (var dp in healthData) {
          switch (dp.type) {
            case HealthDataType.STEPS:
              totalSteps += (dp.value as NumericHealthValue).numericValue.toInt();
              break;
            case HealthDataType.ACTIVE_ENERGY_BURNED:
              totalCalories += (dp.value as NumericHealthValue).numericValue;
              break;

              // Todo: review data type
              case HealthDataType.EXERCISE_TIME:
              totalMinutes += (dp.value as NumericHealthValue).numericValue.toInt();
              break;
            default:
              break;
          }
        }

        setState(() {
          currentSteps = totalSteps;
          stepPercent = totalSteps / goalSteps;
          caloriesBurned = totalCalories.round();
          activeMinutes = totalMinutes;
          dataAvailable = true;
        });
      } catch (e) {
        Logger().e("Health data error: $e");
        setState(() => dataAvailable = false);
      }
    } else {
      Logger().i("Authorization not granted");
      setState(() => dataAvailable = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, ${UserManager.user?.name ?? UserManager.user?.id}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateTime.now().getReadableFormat,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                            () => AppNavigator.push(context, AppRoutes.profile),
                        icon: Icon(CupertinoIcons.person),
                      ),
                      IconButton(
                        onPressed:
                            () => AppNavigator.push(context, AppRoutes.health),
                        icon: Icon(CupertinoIcons.exclamationmark_circle),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              dataAvailable
                  ? _MetricsRow(
                    steps: currentSteps,
                    calories: caloriesBurned,
                    minutes: activeMinutes,
                  )
                  : const Center(
                    child: Text(
                      "Health data not available",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              const SizedBox(height: 40),
              Center(
                child:
                    dataAvailable
                        ? CircularPercentIndicator(
                          radius: 80.0,
                          lineWidth: 12.0,
                          percent: stepPercent.clamp(0.0, 1.0),
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Steps",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "$currentSteps",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          progressColor: Colors.teal,
                          backgroundColor: Colors.grey.shade200,
                          circularStrokeCap: CircularStrokeCap.round,
                        )
                        : const Text("No step data to display"),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text('Log Activity'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: authorize,
                    child: Text('Auth'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text('View Goals'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricsRow extends StatelessWidget {
  final int steps;
  final int calories;
  final int minutes;

  const _MetricsRow({this.steps = 0, this.calories = 0, this.minutes = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _MetricCard(
          icon: Icons.directions_walk,
          label: "Steps",
          value: "$steps",
        ),
        _MetricCard(
          icon: Icons.local_fire_department,
          label: "Calories",
          value: "$calories kcal",
        ),
        _MetricCard(icon: Icons.timer, label: "Workout", value: "$minutes min"),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.teal),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/*
class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
*/
