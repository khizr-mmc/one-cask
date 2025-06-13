part of 'views.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _iconOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _iconOpacity = 0.0;
      });
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        context.pushReplacementPage(const WelcomePage());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme().primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with zoom-in effect
          Transform.scale(
            scale: 1.2,
            child: Image.asset(AppImages.background, fit: BoxFit.cover),
          ),
          // Centered app icon with fade-out animation
          Center(
            child: AnimatedOpacity(
              opacity: _iconOpacity,
              duration: const Duration(milliseconds: 500),
              child: Image.asset(AppImages.oneCask, width: 120, height: 120),
            ),
          ),
        ],
      ),
    );
  }
}
