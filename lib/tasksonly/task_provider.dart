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
    if (index >= 0 &&
        index < _tasks.length &&
        _tasks[index]['status'] != 'Completed') {
      _tasks[index]['status'] = 'Completed';
      notifyListeners();
    }
  }

  void toggleTaskOnHold(int index) {
    if (index >= 0 && index < _tasks.length) {
      if (_tasks[index]['status'] == 'On Hold') {
        // Resume task: Change status back to Pending or In Progress
        _tasks[index]['status'] =
            _isInProgress(_tasks[index]) ? 'In Progress' : 'Pending';
      } else {
        // Put task on hold
        _tasks[index]['status'] = 'On Hold';
      }
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
  int get completedTaskCount =>
      _tasks.where((task) => task['status'] == 'Completed').length;
  int get onHoldTaskCount =>
      _tasks.where((task) => task['status'] == 'On Hold').length;
  int get inProgressTaskCount =>
      _tasks.where((task) => _isInProgress(task)).length;
  int get totalTaskCount => _tasks.length;

  // Helper: Check if task is "In Progress"
  bool _isInProgress(Map<String, dynamic> task) {
    if (task['status'] == 'Completed' || task['status'] == 'On Hold')
      return false; // Ignore completed and on-hold tasks

    if (task['startTime'] == null ||
        task['endTime'] == null ||
        task['date'] == null) return false;

    try {
      DateTime now = DateTime.now();

      // Parse task date properly
      DateTime taskDate = DateTime.parse(task["date"]);

      // Parse start and end time with AM/PM format
      DateTime startTime = DateFormat('hh:mm a').parse(task['startTime']);
      DateTime endTime = DateFormat('hh:mm a').parse(task['endTime']);

      // Merge taskDate with start and end times
      DateTime fullStart = DateTime(taskDate.year, taskDate.month, taskDate.day,
          startTime.hour, startTime.minute);
      DateTime fullEnd = DateTime(taskDate.year, taskDate.month, taskDate.day,
          endTime.hour, endTime.minute);

      // Ensure we are comparing the correct date
      if (now.year == taskDate.year &&
          now.month == taskDate.month &&
          now.day == taskDate.day) {
        bool inProgress = now.isAfter(fullStart) && now.isBefore(fullEnd);

        // Update task status in provider
        int taskIndex = _tasks.indexOf(task);
        if (taskIndex != -1) {
          if (inProgress && _tasks[taskIndex]['status'] != 'In Progress') {
            _tasks[taskIndex]['status'] = 'In Progress';
            notifyListeners(); // Notify UI of the change
          } else if (!inProgress &&
              _tasks[taskIndex]['status'] == 'In Progress') {
            _tasks[taskIndex]['status'] =
                'Pending'; // Reset if outside time range
            notifyListeners();
          }
        }

        return inProgress;
      }

      return false; // If it's not the same day, it's not in progress
    } catch (e) {
      print("Error parsing time: $e");
      return false;
    }
  }
}
