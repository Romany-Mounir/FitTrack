import '../common_libs.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _wave1;
  late Animation<double> _wave2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _controller2.repeat();
    });

    _wave1 = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _controller1, curve: Curves.easeOut));

    _wave2 = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double baseSize = 150;
    const Color waveColor = Colors.blueAccent;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _wave1,
            builder:
                (_, __) => Container(
                  width: baseSize * _wave1.value,
                  height: baseSize * _wave1.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: waveColor.withAlpha(
                      ((0.4 * (2 - _wave1.value)) * 256).toInt(),
                    ),
                  ),
                ),
          ),
          AnimatedBuilder(
            animation: _wave2,
            builder:
                (_, __) => Container(
                  width: baseSize * _wave2.value,
                  height: baseSize * _wave2.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: waveColor.withAlpha(
                      ((0.4 * (2 - _wave2.value)) * 256).toInt(),
                    ),
                  ),
                ),
          ),
          // Apply gradient mask to SVG
          ShaderMask(
            shaderCallback:
                (bounds) => const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
            blendMode: BlendMode.srcIn,
            child: const AppLogo(), // Your SVG logo
          ),
        ],
      ),
    );
  }
}
