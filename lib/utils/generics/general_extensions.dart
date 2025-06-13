part of 'generics.dart';

extension NavigationExtension on BuildContext {
  void pushPage(Widget page, {Function()? then}) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => page)).then(
      (_) {
        if (then != null) {
          then();
        }
      },
    );
  }

  void pushReplacementPage(Widget page, {Function()? then}) {
    Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (context) => page)).then((_) {
      if (then != null) {
        then();
      }
    });
  }

  void pushAndRemoveUntilPage(Widget page, {Function()? then}) {
    Navigator.of(this)
        .pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => page),
          (route) => false,
        )
        .then((_) {
          if (then != null) {
            then();
          }
        });
  }

  void popUntilPage() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void popPage<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}

extension MediaQueryValues on BuildContext {
  double get mWidth => MediaQuery.of(this).size.width;
  double get mHeight => MediaQuery.of(this).size.height;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension SnackbarExtension on BuildContext {
  void showSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    final bgColor = backgroundColor ?? AppColorTheme().primary;
    final txtStyle =
        textStyle ??
        AppTextTheme().latoLightText.copyWith(color: AppColorTheme().white);

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor,
          content: Text(message, style: txtStyle),
          duration: duration,
        ),
      );
  }
}

extension AppFontWeight on FontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}
