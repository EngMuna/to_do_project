import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_project/Core/app_styles.dart';
import 'package:to_do_project/Core/text_theme_style.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.passwordController,
    this.hintText,
    required this.validator,
    this.label,
    this.textInputAction,
    this.focusNode,
    this.text,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.onFieldSubmitted,
    this.filledColor,
    this.style,
    this.iconColor,
    this.boxShadow,
    this.labelColor,
  });

  final TextEditingController? passwordController;
  final String? hintText;
  final String? text;
  final Color? labelColor;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? label;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final Color? filledColor;
  final TextStyle? style;
  final Color? iconColor;
  final List<BoxShadow>? boxShadow;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextThemeStyle.textThemeStyle.bodyMedium,
      autofocus: false,
      controller: widget.passwordController,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: AppStyles.formStyle(
        context: context,
        radius: 10,
        widget.hintText ?? '',
        label: widget.label,
        labelColor: widget.labelColor,
        filledColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        suffixIcon: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: widget.iconColor ?? Colors.black,
            ),
          ),
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
      ),
      obscureText: !showPassword,
      validator: widget.validator,
    );
  }
}
