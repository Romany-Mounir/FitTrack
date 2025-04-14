import '../common_libs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel? _user;

  Future<void> _getAuth() async {
    _user = await UserManager.instance.fetchUserFromSupabase();
    setState(() => _user);
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      setState(() {
        _user = UserModel.fromSupabase(data.session?.user.toJson());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _checkAuth);
  }

  void _checkAuth() async {
    await _getAuth();
    if (mounted) {
      if (_user == null) {
        AppNavigator.push(context, AppRoutes.login);
      } else {
        AppNavigator.push(context, AppRoutes.home);
      }
    }
    Logger().i(_user?.toSupabase().toString());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AppLoader()));
  }
}
