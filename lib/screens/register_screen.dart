import '../common_libs.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      var response = await UserManager.instance.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        context: context,
      );

      if (response == null) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Signup failed')));
        }
      }

      if (mounted) {
        // Go to home or show verify email screen
        AppNavigator.push(context, AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup failed: ${(e as AuthApiException).message}'),
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AppLogo(),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Name',
                    icon: Icons.person,
                    controller: nameController,
                    validator: FormValidators.validateName,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: emailController,
                    validator: FormValidators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                    controller: passwordController,
                    validator: FormValidators.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Confirm Password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: confirmPasswordController,
                    validator:
                        (value) => FormValidators.confirmPassword(
                          value,
                          passwordController.text,
                        ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: isLoading ? 'Registering...' : 'Sign Up',
                    onPressed: isLoading ? null : _signUp,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed:
                            () => AppNavigator.push(context, AppRoutes.login),
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
