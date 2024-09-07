import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../services/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

// class AddTaskScreen extends StatefulWidget {
//   @override
//   _AddTaskScreenState createState() => _AddTaskScreenState();
// }

// class _AddTaskScreenState extends State<AddTaskScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   String _description = '';
//   DateTime _dueDate = DateTime.now();
//   bool _isCompleted = false;

//   @override
//   Widget build(BuildContext context) {
//     final taskController = Provider.of<TaskController>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Task')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Title'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a title' : null,
//                 onSaved: (value) => _title = value!,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a description' : null,
//                 onSaved: (value) => _description = value!,
//               ),
//               ListTile(
//                 title: Text('Due Date: ${_dueDate.toLocal()}'.split(' ')[0]),
//                 trailing: const Icon(Icons.calendar_today),
//                 onTap: _pickDueDate,
//               ),
//               SwitchListTile(
//                 title: const Text('Completed'),
//                 value: _isCompleted,
//                 onChanged: (value) => setState(() => _isCompleted = value),
//               ),
//               ElevatedButton(
//                 child: const Text('Save Task'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     final task = Task(
//                       title: _title,
//                       description: _description,
//                       dueDate: _dueDate,
//                       isCompleted: _isCompleted,
//                     );
//                     taskController.addTask(task);
//                     Navigator.pop(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickDueDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _dueDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _dueDate) {
//       setState(() {
//         _dueDate = picked;
//       });
//     }
//   }
// }

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  bool _isCompleted = false;
  TimeOfDay? _time; // Add a field for time

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
                onSaved: (value) => _description = value!,
              ),
              ListTile(
                title: Text('Due Date: ${_dueDate.toLocal()}'.split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDueDate,
              ),
              ListTile(
                title: Text(
                    'Due Time: ${_time?.format(context) ?? 'Select Time'}'),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              SwitchListTile(
                title: const Text('Completed'),
                value: _isCompleted,
                onChanged: (value) => setState(() => _isCompleted = value),
              ),
              ElevatedButton(
                child: const Text('Save Task'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final task = Task(
                      title: _title,
                      description: _description,
                      dueDate: DateTime(
                        _dueDate.year,
                        _dueDate.month,
                        _dueDate.day,
                        _time?.hour ?? 0,
                        _time?.minute ?? 0,
                      ),
                      isCompleted: _isCompleted,
                    );
                    taskController.addTask(task);

                    // Schedule the notification
                    _scheduleNotification(task);

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDueDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  Future<void> _scheduleNotification(Task task) async {
    // Initialize notification only if it hasn't been initialized
    final notificationService = NotificationService();
    await notificationService.initNotification();

    final dueDateTime = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
      task.dueDate.hour,
      task.dueDate.minute,
    );

    final scheduledDate = dueDateTime.subtract(
        const Duration(minutes: 1)); // Notify 1 hour before the due date

    await notificationService.scheduleNotification(
      'Task Reminder',
      'Reminder: "${task.title}" is due soon!',
      tz.TZDateTime.from(scheduledDate, tz.local),
      task.hashCode, // Unique ID for each task
    );
  }
}
