part of 'views.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme().primary,
      appBar: AppBar(
        leading: Icon(AppIcons().backArrow, color: AppColorTheme().grey),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Sign in',
              style: AppTextTheme().ebGaramondHeadingLargeText.copyWith(
                color: AppColorTheme().white,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(labelText: 'Email'),
            const SizedBox(height: 16),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              buildWhen: (previous, current) =>
                  previous.isPasswordObscured != current.isPasswordObscured,
              builder: (context, state) {
                return CustomTextField(
                  labelText: 'Password',
                  obscureText: state.isPasswordObscured,
                  suffixIcon: IconButton(
                    onPressed: () => context
                        .read<AuthenticationCubit>()
                        .togglePasswordVisibility(),
                    icon: Icon(
                      state.isPasswordObscured
                          ? AppIcons().visibilityOff
                          : AppIcons().visibility,

                      color: AppColorTheme().secondary,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(
              onTap: () {
                context.pushPage(const UserRootPage());
              },
              title: 'Continue',
              radius: 8,
              fontColor: AppColorTheme().black,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Can\'t sign in? ',
                  style: AppTextTheme().latoBodyLargeText.copyWith(
                    color: AppColorTheme().grey,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Recover password',
                    style: AppTextTheme().ebGaramondButtonLargeText.copyWith(
                      color: AppColorTheme().secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
