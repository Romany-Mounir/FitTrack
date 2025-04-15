import 'package:fit_track/common_libs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // final _auth = AuthService();
  bool isLoading = false;

  void _login() async {
    setState(() => isLoading = true);
    try {
      var response = await UserManager.instance.signIn(
        password: passwordController.text,
        email: emailController.text,
        context: context,
      );
      if (response != null) {
        if (mounted) {
          AppNavigator.push(context, AppRoutes.home);
        }
      }
    } catch (e) {
      Logger().e(e);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  //
  // void _loginWithGoogle() async {
  //   setState(() => isLoading = true);
  //   try {
  //     // await _auth.signInWithGoogle();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const HomeScreen()),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Google Sign-In failed: $e')));
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppLogo(),
                // Logo
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Forgot Password logic
                    child: const Text('Forgot Password?'),
                  ),
                ),
                PrimaryButton(
                  text: isLoading ? 'Logging in...' : 'Login',
                  onPressed: isLoading ? () {} : _login,
                ),
                const SizedBox(height: 16),
                // ToDo: Google sign in
                // GoogleSignInButton(
                //   onPressed: isLoading ? () {} : _loginWithGoogle,
                // ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed:
                          () => AppNavigator.push(context, AppRoutes.register),
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
