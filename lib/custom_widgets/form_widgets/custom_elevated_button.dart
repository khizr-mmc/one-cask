part of 'form_widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.title = '',
    this.buttonColor,
    this.fontColor,
    this.fontSize,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.onTap,
    this.borderWidth,
    this.borderColor,
    this.titleUnderline,
    this.hasIcon = false,
    this.icon,
  });

  final String title;
  final Color? buttonColor;
  final Color? fontColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? borderWidth;
  final Color? borderColor;
  final bool? titleUnderline;
  final bool? hasIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColorTheme().secondary,
          borderRadius: BorderRadius.circular(radius ?? 32),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1,
          ),
        ),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasIcon == true)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    icon ?? AppIcons().add,
                    color: fontColor ?? AppColorTheme().white,
                    size: 24,
                  ),
                ),

              Text(
                title,
                style: AppTextTheme().ebGaramondButtonLargeText.copyWith(
                  color: fontColor ?? AppColorTheme().white,
                  fontSize: fontSize ?? 14,

                  decoration: titleUnderline == true
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: titleUnderline == true
                      ? AppColorTheme().primary
                      : null,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
