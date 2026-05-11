import 'package:flutter/material.dart';

import 'package:to_do_project/Core/spacer.dart';
import 'package:to_do_project/Feature/Auth/Login/main_button.dart';
import 'package:to_do_project/Feature/Auth/Login/password_feild.dart';
import 'package:to_do_project/Feature/Auth/text_form_feild_widget.dart';

class AuthForm extends StatefulWidget {
  // final AuthType type;
  const AuthForm({
    super.key,
    //  required this.type
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Future<void> _handleSubmit(BuildContext context) async {
  //   if (!formKey.currentState!.validate()) {
  //     setState(() {
  //       autoValidate = AutovalidateMode.onUserInteraction;
  //     });
  //     return;
  //   }

  //   final data = {
  //     'email': emailController.text.trim(),
  //     'password': passwordController.text.trim(),
  //   };

  //   await context.read<AuthCubit>().authHandler(type: widget.type, data: data);
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StaticSpacer.spacer16,
          TextFormFieldWidget(
            controller: emailController,
            // validator: (value) => FormValidato.textValidate(value),
            hint: 'your_email',
            keyboardType: TextInputType.emailAddress,
          ),
          StaticSpacer.spacer16,
          PasswordField(
            hintText: 'your_password',
            passwordController: passwordController,
            validator: (String? p1) {},
            // validator: (value) => FormValidato.textValidate(value),
          ),
          StaticSpacer.spacer32,
          MainButton(
            text: "login",

            // text: widget.type == AuthType.login
            //     ? "login".tr()
            //     : "signup".tr(),
            width: double.infinity,
            // isDisabled: state is AuthStateLoading,
            onPressed: () {},

            // _handleSubmit(context)
          ),
        ],
      ),
    );
  }
}
