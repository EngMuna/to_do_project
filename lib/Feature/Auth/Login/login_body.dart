import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/Core/app_colors.dart';
import 'package:to_do_project/Core/assets.dart/asset.dart';
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
            SizedBox(height: 50),

            Image.asset(Images.female),
            SizedBox(height: 50),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hint: Text("Email"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hint: Text("Password"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 7),
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
                  "Forget Password",
                  style: TextStyle(
                    color: AppColors.lightPinkBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            MainButton(
              text: 'Login',
              onPressed: () async {
                UserCredential? credential;
                try {
                  credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No user found for that email.")),
                    );
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
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
                    SnackBar(content: Text("Something went wrong")),
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
                // else {
                //   if (credential.user!.emailVerified) {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const HomeScreen(),
                //       ),
                //     );
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text("please verify your email")),
                //     );
                //   }
                // }
              },
              width: double.infinity,
            ),
            SizedBox(height: 20),
            MainButton(
              text: 'Signup',
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
