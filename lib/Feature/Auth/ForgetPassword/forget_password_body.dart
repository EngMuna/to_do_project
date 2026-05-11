import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/Core/Spacer/spacer.dart';
import 'package:to_do_project/Core/Styles/asset.dart';
import 'package:to_do_project/Feature/Auth/Login/main_button.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
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
            StaticSpacer.spacer50,
            MainButton(
              text: "reset_password".tr(),
              onPressed: () async {
                final email = emailController.text.trim();

                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("please_enter_email".tr())),
                  );
                  return;
                }

                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: email,
                  );

                  emailController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("check_your_email".tr())),
                  );
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? "error_occurred".tr())),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("something_went_wrong".tr())),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}
