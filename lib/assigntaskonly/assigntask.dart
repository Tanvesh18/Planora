import 'package:authenticationprac/constants/constants.dart';
import 'package:authenticationprac/tasksonly/task.dart';
import 'package:flutter/material.dart';
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
  Map<DateTime, List> events = {};
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
      setState(() {
        events[today] = [
          ...events[today] ?? [],
          {
            "title": _titleController.text,
            "description": _descriptionController.text,
            "startTime": startTime?.format(context) ?? "Not Set",
            "endTime": endTime?.format(context) ?? "Not Set",
          }
        ];
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Task(
            tasks: events.values
                .expand((e) => e)
                .cast<Map<String, String>>()
                .toList(),
          ),
        ),
      );

      _titleController.clear();
      _descriptionController.clear();
      startTime = null;
      endTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("background/newbg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
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
                  return events[day] ?? [];
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
                            fontSize: 20)),
                    TextField(
                        controller: _titleController,
                        decoration: InputDecoration(hintText: "Task Title")),
                    SizedBox(height: 10),
                    Text("Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontFamily: 'Impact',
                            fontSize: 20,
                            ),
                            ),
                    TextField(
                        controller: _descriptionController,
                        decoration:
                            InputDecoration(hintText: "Task Description"),
                        maxLines: 3),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Time",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Impact',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  ),
                                  ),
                            ElevatedButton(
                              onPressed: () => _pickTime(isStart: true),
                              child: Text(startTime == null
                                  ? "Pick Start Time"
                                  : startTime!.format(context)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("End Time",
                                style: TextStyle(
                                  fontFamily: 'Impact',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                            ElevatedButton(
                              onPressed: () => _pickTime(isStart: false),
                              child: Text(endTime == null
                                  ? "Pick End Time"
                                  : endTime!.format(context)),
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
                            startTime = null;
                            endTime = null;
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _saveTask,
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
