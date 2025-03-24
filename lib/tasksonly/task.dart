import 'package:authenticationprac/constants/constants.dart';
import 'package:authenticationprac/tasksonly/task_provider.dart';
import 'package:authenticationprac/tasksonly/piechart.dart';
import 'package:authenticationprac/tasksonly/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: true);
    final tasks = taskProvider.tasks;

    return Scaffold(
      drawer: myDrawer,
      appBar: myAppBar,
      body: Stack(
        children: [
          mybackground,
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
                  tasks.isEmpty
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
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            bool isInProgress = taskProvider.tasks[index]
                                    ['status'] ==
                                'In Progress';
                            String? rawDate = tasks[index]['date'];
                            String formattedDate = rawDate != null
                                ? DateFormat('dd MMM yyyy')
                                    .format(DateTime.parse(rawDate))
                                : "No Date Set";
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) =>
                                        taskProvider.removeTask(index),
                                    label: 'Delete',
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ],
                              ),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                color: tasks[index]['status'] == 'Completed'
                                    ? Colors.green.shade200
                                    : tasks[index]['status'] == 'On Hold'
                                        ? Colors.amber
                                            .shade200 // Ensure "On Hold" is Yellow
                                        : isInProgress
                                            ? Colors.blue.shade200
                                            : null,
                                child: ListTile(
                                  title:
                                      Text(tasks[index]['title'] ?? "No Title"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(tasks[index]['description'] ??
                                          "No Description"),
                                      SizedBox(height: 5),
                                      Text("Task Date: $formattedDate"),
                                      Text(
                                          "Start Time: ${tasks[index]['startTime'] ?? 'Not Set'}"),
                                      Text(
                                          "End Time: ${tasks[index]['endTime'] ?? 'Not Set'}"),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: tasks[index]['status'] ==
                                                    'Completed'
                                                ? null
                                                : () => taskProvider
                                                    .markTaskAsCompleted(index),
                                            child: tasks[index]['status'] ==
                                                    'Completed'
                                                ? Icon(Icons.check,
                                                    color: Colors.green)
                                                : Text("Complete Task"),
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: tasks[index]['status'] ==
                                                    'Completed'
                                                ? null
                                                : () => taskProvider
                                                    .toggleTaskOnHold(index),
                                            child: tasks[index]['status'] ==
                                                    'On Hold'
                                                ? Text(
                                                    "Resume") // Show "Resume" when task is on hold
                                                : Text("On Hold"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
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
                        count: '${taskProvider.completedTaskCount}',
                        label: 'Completed',
                        color: Colors.green.shade200,
                      ),
                      SummaryCard(
                        count: '${taskProvider.inProgressTaskCount}',
                        label: 'In Progress',
                        color: Colors.blue.shade200,
                      ),
                      SummaryCard(
                        count: '${taskProvider.totalTaskCount}',
                        label: 'Total Tasks',
                        color: Colors.purple.shade200, // Choose any color
                      ),
                      SummaryCard(
                        count: '${taskProvider.onHoldTaskCount}',
                        label: 'On Hold',
                        color: Colors.amber.shade200,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Piechart(
                        inProgress: taskProvider.inProgressTaskCount,
                        completed: taskProvider.completedTaskCount,
                        totalTasks: taskProvider.totalTaskCount,
                        toggleTaskOnHold: taskProvider.onHoldTaskCount,
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
