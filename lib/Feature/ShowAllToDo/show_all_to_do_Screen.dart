import 'package:flutter/material.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_to_do_body.dart';

class ShowAllToDoScreen extends StatefulWidget {
  const ShowAllToDoScreen({super.key});

  @override
  State<ShowAllToDoScreen> createState() => _ShowAllToDoScreenState();
}

class _ShowAllToDoScreenState extends State<ShowAllToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ShowAllToDoBody());
  }
}
