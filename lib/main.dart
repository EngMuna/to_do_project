import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_project/Core/text_theme_style.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_to_do_Screen.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_to_do_body.dart';
import 'package:to_do_project/Feature/Splash/splash_screen.dart';
import 'package:to_do_project/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        TextThemeStyle.setTextTheme(context);
        return MaterialApp(debugShowCheckedModeBanner: false, home: child);
      },
      child: const ShowAllToDoBody(),
    );
  }
}
