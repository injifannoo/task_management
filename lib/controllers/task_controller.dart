import 'package:flutter/foundation.dart';
import '../models/task_model.dart';
import '../services/local_storage_service.dart';

class TaskController with ChangeNotifier {
  List<Task> _tasks = [];
  final LocalStorageService _storage = LocalStorageService();

  TaskController() {
    loadTasks();
  }

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    _storage.saveTasks(_tasks);
    notifyListeners();
  }

  void editTask(int index, Task updatedTask) {
    _tasks[index] = updatedTask;
    _storage.saveTasks(_tasks);
    notifyListeners();
  }

  void loadTasks() async {
    _tasks = await _storage.loadTasks();
     print('Loaded tasks: $_tasks');  // Debugging
    notifyListeners();
  }
}
