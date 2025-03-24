import 'dart:ui';

import 'package:authenticationprac/constants/constants.dart';
import 'package:authenticationprac/tasksonly/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Assigntask extends StatefulWidget {
  const Assigntask({super.key});

  @override
  State<Assigntask> createState() => _AssigntaskState();
}

class _AssigntaskState extends State<Assigntask> {
  DateTime today = DateTime.now();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Future<void> _pickTime({required bool isStart}) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _saveTask() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      taskProvider.addTask({
        "title": _titleController.text,
        "description": _descriptionController.text,
        "startTime": startTime?.format(context) ?? "Not Set",
        "endTime": endTime?.format(context) ?? "Not Set",
        "date": today.toIso8601String(),
        "status": "Pending",
      });

      // Clear input fields
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        startTime = null;
        endTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task added successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: Stack(
        children: [
          mybackground,
          SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  onDaySelected: _onDaySelected,
                  eventLoader: (day) {
                    return taskProvider.getTasksForDay(day);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Impact',
                              letterSpacing: 1.5,
                              fontSize: 20)),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: "Enter Task Title",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 16),
                          prefixIcon:
                              Icon(Icons.edit, color: Colors.blueAccent),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        style: TextStyle(fontSize: 18),
                        cursorColor: Colors.blueAccent,
                      ),
                      SizedBox(height: 10),
                      Text("Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Impact',
                              letterSpacing: 1.5,
                              fontSize: 20)),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter Task Description",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 16),
                          prefixIcon:
                              Icon(Icons.description, color: Colors.blueAccent),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        style: TextStyle(fontSize: 18),
                        cursorColor: Colors.blueAccent,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () => _pickTime(isStart: true),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    startTime?.format(context) ?? "Start Time",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () => _pickTime(isStart: false),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    endTime?.format(context) ?? "End Time",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _titleController.clear();
                              _descriptionController.clear();
                              setState(() {
                                startTime = null;
                                endTime = null;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.redAccent, // Red for cancel
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5, // Adds shadow effect
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _saveTask,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Green for save
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5, // Adds shadow effect
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
