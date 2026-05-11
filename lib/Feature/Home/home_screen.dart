import 'package:flutter/material.dart';
import 'package:to_do_project/Feature/Home/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: HomeBody()));
  }
}
