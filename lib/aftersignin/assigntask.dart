import 'package:flutter/material.dart';
class Assigntask extends StatefulWidget {
  const Assigntask({super.key});

  @override
  State<Assigntask> createState() => _AssigntaskState();
}

class _AssigntaskState extends State<Assigntask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('yo'),
      ),
    );
  }
}