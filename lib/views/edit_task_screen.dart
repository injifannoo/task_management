// // Implementation for task form with TextFormFields and a date picker.
// import 'package:flutter/material.dart';
// import '../models/task_model.dart';
// import 'package:provider/provider.dart';
// import '../controllers/task_controller.dart';

// class AddEditTaskScreen extends StatefulWidget {
//   final Task? task;
//   final int? taskIndex;

//   const AddEditTaskScreen({super.key, this.task, this.taskIndex});

//   @override
//   _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
// }

// class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   String _description = '';
//   DateTime _dueDate = DateTime.now();
//   bool _isCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.task != null) {
//       _title = widget.task!.title;
//       _description = widget.task!.description;
//       _dueDate = widget.task!.dueDate;
//       _isCompleted = widget.task!.isCompleted;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taskController = Provider.of<TaskController>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: _title,
//                 decoration: const InputDecoration(labelText: 'Title'),
//                 validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
//                 onSaved: (value) => _title = value!,
//               ),
//               TextFormField(
//                 initialValue: _description,
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
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
//                     if (widget.task == null) {
//                       taskController.addTask(task);
//                     } else {
//                       taskController.editTask(widget.taskIndex!, task);
//                     }
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
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final int taskIndex;

  const EditTaskScreen(
      {super.key, required this.task, required this.taskIndex});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _dueDate;
    TimeOfDay? _time; // Add a field for time
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _description = widget.task.description;
    _dueDate = widget.task.dueDate;
        _time = TimeOfDay(hour: _dueDate.hour, minute: _dueDate.minute);

    _isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
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
                title: Text('Due Time: ${_time?.format(context) ?? 'Select Time'}'),
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
                        _time?.hour ?? _dueDate.hour,  // Use existing hour if no time selected
                        _time?.minute ?? _dueDate.minute,  // Use existing minute if no time selected
                      ),
                      isCompleted: _isCompleted,
                    );
                    taskController.editTask(widget.taskIndex, task);
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

}

  