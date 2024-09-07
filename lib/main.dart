import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/task_controller.dart';
import 'controllers/theme_controller.dart';
import 'services/notification_service.dart';
import 'views/completed_tasks_screen.dart';
import 'views/home_screen.dart';
import 'views/setting_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Task Manager',
      theme: themeController.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/completed': (context) =>const CompletedTasksScreen(),
        '/settings': (context) =>const SettingsScreen(),
      },
    );
  }
}
