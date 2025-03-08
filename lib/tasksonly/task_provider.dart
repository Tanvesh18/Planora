import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<Map<String, String>> _tasks = [];

  List<Map<String, String>> get tasks => List.unmodifiable(_tasks); // Prevent external modification

  void addTask(Map<String, String> task) {
    _tasks.add(task);
    notifyListeners();
  }

  void markTaskAsCompleted(int index) {
    if (index >= 0 && index < _tasks.length) {
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

  void setTasks(List<Map<String, String>> newTasks) {
    _tasks.clear();
    _tasks.addAll(newTasks);
    notifyListeners();
  }

  // **NEW**: Get tasks for a specific date (for TableCalendar eventLoader)
  List<Map<String, String>> getTasksForDay(DateTime day) {
    return _tasks.where((task) {
      String? dateString = task["date"];
      if (dateString == null) return false;

      DateTime taskDate = DateTime.parse(dateString);
      return taskDate.year == day.year &&
             taskDate.month == day.month &&
             taskDate.day == day.day;
    }).toList();
  }
}
