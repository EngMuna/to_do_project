import 'package:flutter/material.dart';
import 'package:to_do_project/Feature/Auth/Login/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 218, 226),
        body: LoginBody(),
      ),
    );
  }
}
