import 'package:flutter/material.dart';
import 'package:to_do_project/Feature/Auth/ForgetPassword/forget_password_body.dart';

class FogetPasswordScreen extends StatelessWidget {
  const FogetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 218, 226),
        body: ForgetPasswordBody(),
      ),
    );
  }
}
