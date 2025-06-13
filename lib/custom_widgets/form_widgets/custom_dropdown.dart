part of 'form_widgets.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.options = const [],
    this.value,
    this.expandIcon,
    this.onChanged,
    this.isDense = true,
    this.filled = false,
    this.fillColor,
    this.dropdownColor,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.placeholderText,
    this.placeholderStyle,
    this.expandIconColor,
    this.error,
  });

  final List<CustomDropDownOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget? expandIcon;
  final bool? isDense;
  final bool? filled;
  final Color? fillColor;
  final Color? dropdownColor;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final String? placeholderText;
  final TextStyle? placeholderStyle;
  final Color? expandIconColor;
  final Widget? error;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: false,
      dropdownColor: dropdownColor ?? AppColorTheme().white,
      borderRadius: BorderRadius.circular(16),
      icon:
          expandIcon ??
          Icon(
            Icons.expand_more,
            color: expandIconColor ?? AppColorTheme().secondary,
          ),
      hint: Text(
        placeholderText ?? 'Select',
        style:
            placeholderStyle ??
            AppTextTheme().latoBodyText.copyWith(
              color: AppColorTheme().secondary.withValues(alpha: 0.4),
            ),
      ),
      items: options.map((option) {
        return DropdownMenuItem(
          value: option.value,
          child: Text(
            option.displayOption,
            style: AppTextTheme().latoBodyText,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        filled: filled,
        fillColor: fillColor ?? AppColorTheme().white,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        disabledBorder:
            disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColorTheme().darkGrey),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColorTheme().darkGrey),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColorTheme().darkGrey),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColorTheme().red),
            ),
        focusedErrorBorder:
            focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColorTheme().red),
            ),
        isDense: isDense,
        error: error,
      ),
      style: AppTextTheme().latoBodyText,
      value: value,
      onChanged: onChanged,
    );
  }
}

class CustomDropDownOption<T> {
  final T value;
  final String displayOption;

  const CustomDropDownOption({
    required this.value,
    required this.displayOption,
  });
}
