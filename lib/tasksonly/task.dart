import 'package:authenticationprac/constants/constants.dart';
import 'package:authenticationprac/tasksonly/taskmodel.dart';
import 'package:authenticationprac/tasksonly/piechart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task extends StatefulWidget {
  final List<Map<String, String>> tasks;
  const Task({super.key, this.tasks = const []});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int inProgressCount = 0;
  int onHoldCount = 0;
  int completedCount = 0;

  List<Map<String, String>> tasks = [];
  List<Map<String, String>> completedTasks = [];

  @override
  void initState() {
    super.initState();
    tasks = List.from(widget.tasks); // Create a mutable copy of widget.tasks
    _calculateTaskCounts();
  }

  void _calculateTaskCounts() {
    setState(() {
      inProgressCount = tasks
          .where((task) => _isInProgress(task['startTime'], task['endTime']))
          .length;
      onHoldCount = tasks.where((task) => task['status'] == 'On Hold').length;
      completedCount =
          completedTasks.length; // Count completed tasks properly
    });
  }

  bool _isInProgress(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) return false;
    try {
      DateTime now = DateTime.now();
      DateTime start = DateFormat('hh:mm a').parse(startTime);
      DateTime end = DateFormat('hh:mm a').parse(endTime);

      // Ensure it's compared with today's date
      start = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      end = DateTime(now.year, now.month, now.day, end.hour, end.minute);

      return now.isAfter(start) && now.isBefore(end);
    } catch (e) {
      print("Error parsing time: $e");
      return false;
    }
  }

  void _markTaskAsCompleted(int index) {
    setState(() {
      Map<String, String> completedTask = Map.from(tasks[index]);
      completedTask['status'] = 'Completed';
      completedTasks.add(completedTask);
      tasks.removeAt(index);
      _calculateTaskCounts();
    });
  }

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
            child: SingleChildScrollView(
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
                  widget.tasks.isEmpty
                      ? Text(
                          "No tasks assigned yet!",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Impact',
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: tasks.length, // ✅ Use local tasks list
                          itemBuilder: (context, index) {
                            bool isInProgress = _isInProgress(
                                tasks[index]['startTime'],
                                tasks[index]['endTime']);
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              color: isInProgress ? Colors.blue.shade200 : null,
                              child: ListTile(
                                title:
                                    Text(tasks[index]['title'] ?? "No Title"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tasks[index]['description'] ??
                                        "No Description"),
                                    SizedBox(height: 5),
                                    Text(
                                        "Start Time: ${tasks[index]['startTime'] ?? 'Not Set'}"),
                                    Text(
                                        "End Time: ${tasks[index]['endTime'] ?? 'Not Set'}"),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _markTaskAsCompleted(index),
                                      child: Text("Complete Task"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  SizedBox(height: 20),
                  Text(
                    'Task Summary',
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
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.3,
                    children: [
                      SummaryCard(
                        count: '$inProgressCount',
                        label: 'In Progress',
                        color: Colors.blue.shade200,
                      ),
                      SummaryCard(
                        count: '$onHoldCount',
                        label: 'On Hold',
                        color: Colors.amber.shade200,
                      ),
                      SummaryCard(
                        count: '$completedCount',
                        label: 'Completed',
                        color: Colors.green.shade200,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Piechart(
                        inProgress: inProgressCount,
                        completed: completedCount,
                        onHold: onHoldCount,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
