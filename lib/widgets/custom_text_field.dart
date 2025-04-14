import '../common_libs.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.blueGrey.withAlpha(100)),
    );
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey.withAlpha(200)),
        hintStyle: TextStyle(color: Colors.blueGrey.withAlpha(100)),
        border: border,
        enabledBorder: border,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
