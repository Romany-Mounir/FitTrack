import '../common_libs.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.logo,
      height: 100,
      colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
    );
  }
}
