import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> get tasks => List.unmodifiable(_tasks);

  void addTask(Map<String, dynamic> task) {
    _tasks.add(task);
    notifyListeners();
  }

  void markTaskAsCompleted(int index) {
    if (index >= 0 && index < _tasks.length && _tasks[index]['status'] != 'Completed') {
      _tasks[index]['status'] = 'Completed';
      notifyListeners();
    }
  }

  void removeTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void setTasks(List<Map<String, dynamic>> newTasks) {
    _tasks.clear();
    _tasks.addAll(newTasks);
    notifyListeners();
  }

  // Get tasks for a specific day (for TableCalendar eventLoader)
  List<Map<String, dynamic>> getTasksForDay(DateTime day) {
    return _tasks.where((task) {
      String? dateString = task["date"];
      if (dateString == null) return false;

      DateTime taskDate = DateTime.parse(dateString);
      return taskDate.year == day.year &&
             taskDate.month == day.month &&
             taskDate.day == day.day;
    }).toList();
  }

  // Get tasks based on status
  int get completedTaskCount => _tasks.where((task) => task['status'] == 'Completed').length;
  int get onHoldTaskCount => _tasks.where((task) => task['status'] == 'On Hold').length;
  int get inProgressTaskCount => _tasks.where((task) => _isInProgress(task)).length;
  int get totalTaskCount => _tasks.length;

  // Helper: Check if task is "In Progress"
  bool _isInProgress(Map<String, dynamic> task) {
  if (task['status'] == 'Completed') return false; // Ignore completed tasks
  if (task['startTime'] == null || task['endTime'] == null || task['date'] == null) return false;

  try {
    DateTime now = DateTime.now();
    DateTime taskDate = DateTime.parse(task["date"]);

    DateTime start = DateFormat('hh:mm a').parse(task['startTime']);
    DateTime end = DateFormat('hh:mm a').parse(task['endTime']);

    DateTime fullStart = DateTime(taskDate.year, taskDate.month, taskDate.day, start.hour, start.minute);
    DateTime fullEnd = DateTime(taskDate.year, taskDate.month, taskDate.day, end.hour, end.minute);

    return now.isAfter(fullStart) && now.isBefore(fullEnd);
  } catch (e) {
    print("Error parsing time: $e");
    return false;
  }
}
void markTaskAsOnHold(int index) {
  if (index >= 0 && index < _tasks.length &&
      _tasks[index]['status'] != 'Completed') {  // Prevent on hold if completed

    if (_tasks[index]['status'] == 'On Hold') {
      // Resume Task
      _tasks[index]['status'] = 'In Progress';
      _tasks[index].remove('holdTime'); // Remove hold time on resume
    } else {
      // Put Task on Hold
      _tasks[index]['status'] = 'On Hold';
      _tasks[index]['holdTime'] = DateTime.now().toIso8601String();
    }
    notifyListeners();
  }
}
}
