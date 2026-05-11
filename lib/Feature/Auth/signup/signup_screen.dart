import 'package:flutter/material.dart';
import 'package:to_do_project/Core/Theme/app_colors.dart';
import 'package:to_do_project/Feature/Auth/signup/signup_body.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = '/SignUpScreen';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.veryLightPinkBackground,
        body: SignUpBody(),
      ),
    );
  }
}
