import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/reminders_table.dart';
import 'tables/categories_table.dart';
import 'tables/reminder_categories_table.dart';
import 'tables/notification_log_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Reminders, Categories, ReminderCategories, NotificationLog],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Seed default categories
          await batch((batch) {
            batch.insertAll(categories, [
              CategoriesCompanion.insert(
                name: 'Work',
                color: 0xFF2196F3,
                createdAt: DateTime.now(),
              ),
              CategoriesCompanion.insert(
                name: 'Personal',
                color: 0xFF4CAF50,
                createdAt: DateTime.now(),
              ),
              CategoriesCompanion.insert(
                name: 'Health',
                color: 0xFFE91E63,
                createdAt: DateTime.now(),
              ),
              CategoriesCompanion.insert(
                name: 'Finance',
                color: 0xFFFF9800,
                createdAt: DateTime.now(),
              ),
            ]);
          });
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle future migrations here
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  // Reminder operations
  Future<List<Reminder>> getAllReminders() => select(reminders).get();

  Future<List<Reminder>> getUpcomingReminders() {
    return (select(reminders)
          ..where((r) => r.isCompleted.equals(false))
          ..orderBy([(r) => OrderingTerm.asc(r.dueDate)]))
        .get();
  }

  Future<List<Reminder>> getRemindersInRange(DateTime start, DateTime end) {
    return (select(reminders)
          ..where((r) =>
              r.dueDate.isBiggerOrEqualValue(start) &
              r.dueDate.isSmallerThanValue(end) &
              r.isCompleted.equals(false)))
        .get();
  }

  Future<Reminder?> getReminderById(int id) {
    return (select(reminders)..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertReminder(RemindersCompanion reminder) {
    return into(reminders).insert(reminder);
  }

  Future<bool> updateReminder(RemindersCompanion reminder) {
    return update(reminders).replace(reminder);
  }

  Future<int> deleteReminder(int id) {
    return (delete(reminders)..where((r) => r.id.equals(id))).go();
  }

  Future<void> toggleReminderComplete(int id) async {
    final reminder = await getReminderById(id);
    if (reminder != null) {
      await (update(reminders)..where((r) => r.id.equals(id))).write(
        RemindersCompanion(
          isCompleted: Value(!reminder.isCompleted),
          completedAt: Value(reminder.isCompleted ? null : DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Category operations
  Future<List<Category>> getAllCategories() => select(categories).get();

  Future<Category?> getCategoryById(int id) {
    return (select(categories)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  Future<bool> updateCategory(CategoriesCompanion category) {
    return update(categories).replace(category);
  }

  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((c) => c.id.equals(id))).go();
  }

  // Reminder-Category junction operations
  Future<List<Category>> getCategoriesForReminder(int reminderId) async {
    final query = select(categories).join([
      innerJoin(
        reminderCategories,
        reminderCategories.categoryId.equalsExp(categories.id),
      ),
    ])
      ..where(reminderCategories.reminderId.equals(reminderId));

    final results = await query.get();
    return results.map((row) => row.readTable(categories)).toList();
  }

  Future<List<Reminder>> getRemindersForCategory(int categoryId) async {
    final query = select(reminders).join([
      innerJoin(
        reminderCategories,
        reminderCategories.reminderId.equalsExp(reminders.id),
      ),
    ])
      ..where(reminderCategories.categoryId.equals(categoryId));

    final results = await query.get();
    return results.map((row) => row.readTable(reminders)).toList();
  }

  Future<void> setReminderCategories(
      int reminderId, List<int> categoryIds) async {
    await (delete(reminderCategories)
          ..where((rc) => rc.reminderId.equals(reminderId)))
        .go();

    await batch((batch) {
      batch.insertAll(
        reminderCategories,
        categoryIds
            .map((categoryId) => ReminderCategoriesCompanion.insert(
                  reminderId: reminderId,
                  categoryId: categoryId,
                ))
            .toList(),
      );
    });
  }

  // Notification log operations
  Future<List<NotificationLogData>> getPendingNotifications() {
    return (select(notificationLog)
          ..where((n) => n.status.equals('pending'))
          ..orderBy([(n) => OrderingTerm.asc(n.scheduledTime)]))
        .get();
  }

  Future<int> insertNotificationLog(NotificationLogCompanion log) {
    return into(notificationLog).insert(log);
  }

  Future<void> updateNotificationStatus(
      int id, String status, {String? errorMessage}) {
    return (update(notificationLog)..where((n) => n.id.equals(id))).write(
      NotificationLogCompanion(
        status: Value(status),
        sentTime: Value(status == 'sent' ? DateTime.now() : null),
        errorMessage: Value(errorMessage),
      ),
    );
  }

  Stream<List<Reminder>> watchAllReminders() => select(reminders).watch();

  Stream<List<Reminder>> watchUpcomingReminders() {
    return (select(reminders)
          ..where((r) => r.isCompleted.equals(false))
          ..orderBy([(r) => OrderingTerm.asc(r.dueDate)]))
        .watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'reminder_app.db'));
    return NativeDatabase.createInBackground(file);
  });
}
