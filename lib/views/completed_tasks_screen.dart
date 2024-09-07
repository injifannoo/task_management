import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import 'edit_task_screen.dart';
import 'widgets/task_item.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    final completedTasks =
        taskController.tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          //return TaskItem(completedTasks[index]);
          final task = completedTasks[index]; // Get task at the given index
          return TaskItem(
            task: task,
            index: index,
            onEdit: () {
              // Provide an empty function or handle edit logic if needed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    task: task,
                    taskIndex: index,
                  ),
                ),
              );
            },
          ); // Pass task and index as positional arguments
        },
      ),
    );
  }
}
