import 'package:flutter/material.dart';
import '../../models/task_model.dart';
import 'package:intl/intl.dart'; 

class TaskItem extends StatelessWidget {
  final Task task;
  final int index;
    final VoidCallback onEdit;  


  const TaskItem({
    super.key,
    required this.task,
    required this.index,
    required this.onEdit,  
  });

  @override
  Widget build(BuildContext context) {
    final dueDateFormatted = DateFormat('yyyy-MM-dd HH:mm').format(task.dueDate);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.grey,
          size: 32,
        ),
        title: Text(
          task.title,
          style:const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Due: $dueDateFormatted',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey[600],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: onEdit,
        ),
      ),
    );
  }
}