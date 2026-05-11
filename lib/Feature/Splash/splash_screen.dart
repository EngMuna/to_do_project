import 'package:flutter/material.dart';
import 'package:to_do_project/Feature/Splash/splash_body.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: SplashBody()));
  }
}
