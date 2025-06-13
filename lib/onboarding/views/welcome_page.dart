part of 'views.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme().primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: 1.2,
            child: Image.asset(AppImages.background, fit: BoxFit.cover),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: 32,
                      left: 16,
                      right: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: AppColorTheme().primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome!',
                          style: AppTextTheme().ebGaramondHeadingLargeText
                              .copyWith(color: AppColorTheme().white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Text text text',
                          style: AppTextTheme().latoBodyLargeText.copyWith(
                            color: AppColorTheme().white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                          title: 'Scan Bottle',
                          buttonColor: AppColorTheme().secondary,
                          fontColor: AppColorTheme().black,
                          fontSize: 16,
                          width: double.infinity,
                          radius: 8,
                          onTap: () {},
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account? ',
                              style: AppTextTheme().latoBodyText.copyWith(
                                color: AppColorTheme().white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                context.pushPage(const SigninPage());
                              },
                              child: Text(
                                'Sign in first',
                                style: AppTextTheme().ebGaramondButtonLargeText
                                    .copyWith(color: AppColorTheme().secondary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
