import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/Core/Spacer/spacer.dart';
import 'package:to_do_project/Core/Theme/app_colors.dart';
import 'package:to_do_project/Core/Styles/asset.dart';
import 'package:to_do_project/Feature/Auth/Login/login_screen.dart';
import 'package:to_do_project/Feature/Auth/Login/main_button.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
              controller: nameController,
              decoration: InputDecoration(
                hint: Text("name".tr()),
                border: OutlineInputBorder(),
              ),
            ),
            StaticSpacer.spacer20,
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
            StaticSpacer.spacer20,
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hint: Text("confirm_password".tr()),
                border: OutlineInputBorder(),
              ),
            ),

            StaticSpacer.spacer50,
            MainButton(
              text: 'signup'.tr(),
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("please_fill_all_fields".tr())),
                  );
                  return;
                }
                if (passwordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("passwords_do_not_match".tr())),
                  );
                  return;
                }
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("please_fill_all_fields".tr())),
                  );
                  return;
                }

                if (passwordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("passwords_do_not_match".tr())),
                  );
                  return;
                }
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                  if (credential != null && credential.user != null) {
                    // credential.user!.sendEmailVerification();
                    // await FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("something_went_wrong".tr())),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == "weak_password".tr()) {
                    print('The password provided is too weak.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("The password provided is too weak."),
                      ),
                    );
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("email_already_in_use".tr())),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              width: double.infinity,
            ),
            StaticSpacer.spacer8,
            RichText(
              text: TextSpan(
                text: "${"already_have_account".tr()} ",
                style: TextStyle(color: Colors.black),
                children: [
                  WidgetSpan(
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: Text(
                        "login".tr(),
                        style: TextStyle(
                          color: AppColors.lightPinkBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
