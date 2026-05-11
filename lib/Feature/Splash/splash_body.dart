import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/Core/Spacer/spacer.dart';
import 'package:to_do_project/Core/Theme/app_colors.dart';
import 'package:to_do_project/Core/Styles/asset.dart';
import 'package:to_do_project/Core/Theme/text_theme_style.dart';
import 'package:to_do_project/Feature/Auth/Login/login_screen.dart';
import 'package:to_do_project/Feature/Home/home_screen.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('userId') == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.lightPinkBackground),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.female),

            StaticSpacer.spacer20,

            Text(
              "To Do App",
              style: TextThemeStyle.textThemeStyle.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            StaticSpacer.spacer32,
          ],
        ),
      ),
    );
  }
}
