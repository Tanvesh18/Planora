import 'package:authenticationprac/constants/constants.dart';
import 'package:flutter/material.dart';
class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: myDrawer,
      appBar: myAppBar,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background/newbg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}