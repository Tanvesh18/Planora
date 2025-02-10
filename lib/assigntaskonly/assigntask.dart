import 'package:authenticationprac/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Assigntask extends StatefulWidget {
  const Assigntask({super.key});

  @override
  State<Assigntask> createState() => _AssigntaskState();
}

class _AssigntaskState extends State<Assigntask> {
  DateTime today = DateTime.now();
  Map<DateTime, List> events = {};
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
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
                image: AssetImage('background/newbg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          TableCalendar(
            focusedDay: today,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            onDaySelected: _onDaySelected,
            eventLoader: (day) {
                  return events[day] ?? [];
                },
          ),
          ],
      ),
    );
  }
}
