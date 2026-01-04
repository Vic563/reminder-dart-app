import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../database/database.dart';
import '../../reminders/domain/entities/priority.dart' as app;
import '../../reminders/domain/entities/recurrence_rule.dart';
import '../../reminders/presentation/providers/reminders_provider.dart';

part 'notification_service.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  final db = ref.watch(databaseProvider);
  final service = NotificationService(db);
  ref.onDispose(() => service.dispose());
  return service;
}

class NotificationService {
  final AppDatabase _db;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  Timer? _checkTimer;
  final _tapController = StreamController<String?>.broadcast();

  NotificationService(this._db);

  Stream<String?> get onNotificationTap => _tapController.stream;

  Future<void> initialize() async {
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open reminder',
    );

    const initSettings = InitializationSettings(
      macOS: darwinSettings,
      linux: linuxSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );

    // Start checking for due reminders
    _startScheduler();
  }

  void _handleNotificationTap(NotificationResponse response) {
    _tapController.add(response.payload);
  }

  void _startScheduler() {
    // Check every minute for due reminders
    _checkTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _checkAndTriggerReminders(),
    );
    // Also check immediately
    _checkAndTriggerReminders();
  }

  Future<void> _checkAndTriggerReminders() async {
    final now = DateTime.now();
    final windowEnd = now.add(const Duration(minutes: 1));

    try {
      final dueReminders = await _db.getRemindersInRange(now, windowEnd);

      for (final reminder in dueReminders) {
        await showNotification(
          id: reminder.id,
          title: reminder.title,
          body: reminder.description ?? 'Reminder due now',
          priority: app.Priority.fromValue(reminder.priority),
          payload: reminder.id.toString(),
        );

        // If recurring, schedule next occurrence
        if (reminder.isRecurring && reminder.recurrenceRule != null) {
          await _scheduleNextOccurrence(reminder);
        }
      }
    } catch (e) {
      // Log error but don't crash
      print('Error checking reminders: $e');
    }
  }

  Future<void> _scheduleNextOccurrence(Reminder reminder) async {
    final rule = RecurrenceRule.fromRRuleString(reminder.recurrenceRule!);
    if (rule == null) return;

    final nextDate = rule.getNextOccurrence(reminder.dueDate);
    if (nextDate == null) return;

    final now = DateTime.now();
    await _db.insertReminder(
      RemindersCompanion.insert(
        title: reminder.title,
        description: Value(reminder.description),
        dueDate: nextDate,
        priority: Value(reminder.priority),
        isRecurring: const Value(true),
        recurrenceRule: Value(reminder.recurrenceRule),
        parentReminderId: Value(reminder.id),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required app.Priority priority,
    String? payload,
  }) async {
    final platformChannelSpecifics = NotificationDetails(
      macOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        threadIdentifier: 'reminders',
      ),
      linux: LinuxNotificationDetails(
        urgency: _getLinuxUrgency(priority),
      ),
    );

    await _plugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  LinuxNotificationUrgency _getLinuxUrgency(app.Priority priority) {
    switch (priority) {
      case app.Priority.high:
        return LinuxNotificationUrgency.critical;
      case app.Priority.medium:
        return LinuxNotificationUrgency.normal;
      case app.Priority.low:
        return LinuxNotificationUrgency.low;
    }
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  void dispose() {
    _checkTimer?.cancel();
    _tapController.close();
  }
}
