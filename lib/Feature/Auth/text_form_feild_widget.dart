import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_project/Core/app_styles.dart';
import 'package:to_do_project/Core/text_theme_style.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Color? filledColor;
  final int? maxLines;
  final String? value;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Color? labelColor;
  final Widget? label;
  final TextDirection? textDirection;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool? readOnly;
  final double? radius;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? style;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? focusBorderColor;
  final bool obscureText;
  final Color? containerColor;
  const TextFormFieldWidget({
    super.key,
    this.controller,
    required this.hint,
    this.maxLines,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.keyboardType,
    this.value,
    this.suffixIcon,
    this.onChanged,
    this.textInputAction,
    this.prefixIcon,
    this.boxShadow,
    this.inputFormatters,
    this.textDirection,
    this.suffix,
    this.onSaved,
    this.labelColor,
    this.contentPadding,
    this.label,
    this.filledColor,
    this.radius,
    this.textAlign,
    this.onFieldSubmitted,
    this.style,
    this.focusNode,
    this.borderColor,
    this.obscureText = false,
    this.focusBorderColor,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: value,
      maxLines: maxLines,
      focusNode: focusNode,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText,
      readOnly: readOnly ?? false,
      onTap: onTap,
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textDirection: textDirection,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      onTapOutside: (event) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      style: style ?? TextThemeStyle.textThemeStyle.bodyMedium,
      decoration: AppStyles.formStyle(
        hint,
        radius: radius ?? 10,
        label: label,
        borderColor: borderColor,
        labelColor: labelColor,
        filledColor: filledColor ?? Colors.transparent,
        suffixIcon: suffixIcon,
        suffix: suffix,
        prefixIcon: prefixIcon,
        focusBorderColor: focusBorderColor,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        context: context,
      ),
    );
  }
}
