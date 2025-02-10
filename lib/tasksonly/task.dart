import 'package:authenticationprac/constants/constants.dart';
import 'package:authenticationprac/tasksonly/taskmodel.dart';
import 'package:authenticationprac/tasksonly/piechart.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      drawer: myDrawer,
      appBar: myAppBar,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('background/newbg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${user?.displayName}!',
                  style: TextStyle(
                    fontFamily: 'Impact',
                    fontSize: 30,
                    wordSpacing: 3.5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Project Summary',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 24,
                    fontFamily: 'Impact',
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                  children: [
                    SummaryCard(
                      count: '24',
                      label: 'In Progress',
                      color: Colors.blue.shade200,
                    ),
                    SummaryCard(
                      count: '56',
                      label: 'In Review',
                      color: Colors.purple.shade200,
                    ),
                    SummaryCard(
                      count: '16',
                      label: 'On Hold',
                      color: Colors.amber.shade200,
                    ),
                    SummaryCard(
                      count: '45',
                      label: 'Completed',
                      color: Colors.green.shade200,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Piechart()
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
