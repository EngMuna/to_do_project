import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_project/Feature/Auth/ForgetPassword/forget_password_screen.dart';
import 'package:to_do_project/Feature/Auth/Login/login_screen.dart';
import 'package:to_do_project/Feature/Auth/signup/signup_screen.dart';
import 'package:to_do_project/Feature/Splash/splash_screen.dart';

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: SplashScreen.id,
  routes: [
    GoRoute(
      path: SplashScreen.id,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: LoginScreen.id,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: FogetPasswordScreen.id,
      builder: (context, state) => const FogetPasswordScreen(),
    ),
    GoRoute(
      path: SignUpScreen.id,
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
