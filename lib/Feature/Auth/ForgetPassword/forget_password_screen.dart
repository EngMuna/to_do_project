import 'package:flutter/material.dart';
import 'package:to_do_project/Core/Theme/app_colors.dart';
import 'package:to_do_project/Feature/Auth/ForgetPassword/forget_password_body.dart';

class FogetPasswordScreen extends StatelessWidget {
  static const String id = '/FogetPasswordScreen';
  const FogetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.veryLightPinkBackground,
        body: ForgetPasswordBody(),
      ),
    );
  }
}
