part of 'form_widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    TextEditingController? controller,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.suffixIconColor,
    this.suffixIconSize,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.error,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.isDense = false,
    this.readOnly = false,
    this.alignLabelWithText,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.border,
    this.contentPadding,
    this.contentStyle,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.onTapOutside,
  }) : _controller = controller;

  final TextEditingController? _controller;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? error;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isDense;
  final bool readOnly;
  final bool? alignLabelWithText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentStyle;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside:
          onTapOutside ?? (_) => FocusManager.instance.primaryFocus?.unfocus(),
      enabled: enabled,
      initialValue: initialValue,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        border: border,
        disabledBorder:
            disabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorTheme().secondary),
            ),
        enabledBorder:
            enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorTheme().secondary),
            ),
        focusedBorder:
            focusedBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorTheme().secondary),
            ),
        errorBorder:
            errorBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorTheme().red),
            ),
        focusedErrorBorder:
            focusedErrorBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorTheme().red),
            ),
        error: error,
        hintText: hintText,
        hintStyle:
            hintStyle ??
            AppTextTheme().latoBodySmallText.copyWith(
              color: AppColorTheme().secondary.withValues(alpha: 0.4),
            ),
        isDense: isDense,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        prefixText: prefixText,
        prefixStyle: prefixStyle ?? AppTextTheme().latoBodySmallText,
        contentPadding: contentPadding,
        suffixIconConstraints: suffixIconConstraints,
        labelText: labelText,
        labelStyle:
            labelStyle ??
            AppTextTheme().latoBodySmallText.copyWith(
              color: AppColorTheme().secondary,
            ),
        alignLabelWithHint: alignLabelWithText,
      ),
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: _controller,
      onChanged: onChanged,
      focusNode: focusNode,
      validator: validator,
      style:
          contentStyle ??
          AppTextTheme().latoBodyLargeText.copyWith(
            color: AppColorTheme().white,
          ),
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
