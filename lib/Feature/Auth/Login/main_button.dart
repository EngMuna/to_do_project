import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:to_do_project/Core/app_colors.dart';
import 'package:to_do_project/Core/text_theme_style.dart';

class MainButton extends StatelessWidget {
  final String text;
  final bool isBordered;
  final bool isGradiunt;
  final VoidCallback onPressed;
  final Widget? icon;
  final Color? color;
  final List<Color>? gradiuntColors;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final bool isDisabled;
  final Widget? widgetButton;
  final List<BoxShadow>? boxShadow;
  final double? radius;
  final Color? bgColor;
  const MainButton({
    super.key,
    this.isBordered = false,
    required this.text,
    required this.onPressed,
    this.color,
    this.icon,
    this.isGradiunt = false,
    this.textStyle,
    this.gradiuntColors,
    this.width,
    this.height,
    this.isDisabled = false,
    this.widgetButton,
    this.boxShadow,
    this.radius,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height ?? 44,
        width: width ?? 182.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 15)),
          boxShadow: isDisabled ? [] : boxShadow,
          border: isBordered
              ? Border.all(
                  color: isBordered && isDisabled
                      ? AppColors.borderColor
                      : color ?? AppColors.mainColor,
                  width: 1.w,
                )
              : isDisabled
              ? Border.all(color: Colors.transparent)
              : null,
          color: isBordered
              ? bgColor ?? AppColors.white
              : isDisabled
              ? AppColors.darkGrey
              : color ?? AppColors.lightPinkBackground,
          gradient: isGradiunt == true
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradiuntColors!,
                  stops: const [0.0, 1.0],
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Center(
            child:
                widgetButton ??
                Text(
                  text,
                  style:
                      textStyle ??
                      TextThemeStyle.textThemeStyle.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isBordered
                            ? isBordered && isDisabled
                                  ? AppColors.borderColor
                                  : color ?? AppColors.mainColor
                            : AppColors.white,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}
