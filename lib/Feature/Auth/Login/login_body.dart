import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/Core/Spacer/spacer.dart';
import 'package:to_do_project/Core/Theme/app_colors.dart';
import 'package:to_do_project/Core/Styles/asset.dart';
import 'package:to_do_project/Core/Theme/text_theme_style.dart';
import 'package:to_do_project/Feature/Auth/ForgetPassword/forget_password_screen.dart';
import 'package:to_do_project/Feature/Auth/Login/main_button.dart';
import 'package:to_do_project/Feature/Auth/signup/signup_screen.dart';
import 'package:to_do_project/Feature/Home/home_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StaticSpacer.spacer50,
            Image.asset(Images.female),
            StaticSpacer.spacer50,
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hint: Text("email".tr()),
                border: OutlineInputBorder(),
              ),
            ),
            StaticSpacer.spacer20,
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hint: Text("password".tr()),
                border: OutlineInputBorder(),
              ),
            ),
            StaticSpacer.spacer8,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FogetPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  "forget_password".tr(),
                  style: TextThemeStyle.textThemeStyle.bodyMedium!.copyWith(
                    color: AppColors.lightPinkBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            StaticSpacer.spacer50,
            MainButton(
              text: 'login'.tr(),
              onPressed: () async {
                UserCredential? credential;
                try {
                  credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                } on FirebaseAuthException catch (e) {
                  if (e.code == "no_user_found".tr()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No user found for that email.")),
                    );
                    print('No user found for that email.');
                  } else if (e.code == "wrong_password".tr()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Wrong password provided for that user."),
                      ),
                    );
                    print('Wrong password provided for that user.');
                  }
                }
                if (credential == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("something_went_wrong".tr())),
                  );
                } else {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('userId', credential.user!.uid);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }
              },
              width: double.infinity,
            ),
            StaticSpacer.spacer20,
            MainButton(
              text: 'signup'.tr(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
