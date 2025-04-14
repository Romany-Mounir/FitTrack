import '../common_libs.dart';

class FitTrackApp extends StatelessWidget {
  const FitTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
