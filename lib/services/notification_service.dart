import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    initNotification();
  }

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _localNotifications.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(String title, String body,
      tz.TZDateTime scheduledDate, int taskId) async {
    const androidDetails = AndroidNotificationDetails(
      'task_channel',
      'Task Reminders',
      importance: Importance.max,
      priority: Priority.max,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      print("The date must be in the future");
      return;
    }
    await _localNotifications.zonedSchedule(
      taskId, // Unique ID for each notification
      title,
      body,
      scheduledDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    print("Scheduled Date: ${scheduledDate}");

  }
  
//schedule task reminder for tasks in local storage
  Future<void> scheduleTaskReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks') ?? [];
    final tasks = taskList
        .map((taskJson) => Task.fromJson(json.decode(taskJson)))
        .toList();

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    for (final task in tasks) {
      final tz.TZDateTime dueDate = tz.TZDateTime.from(task.dueDate, tz.local);
      final tz.TZDateTime reminderDate = now.subtract(const Duration(hours: 1));

      if (reminderDate.isAfter(now)) {
        await scheduleNotification(
          'Task Reminder',
          'Your task "${task.title}" is due soon!',
          reminderDate,
          task.hashCode,
        );
      }
    }
  }
}
