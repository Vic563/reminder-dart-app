import 'package:drift/drift.dart';
import 'reminders_table.dart';

class NotificationLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reminderId => integer().references(Reminders, #id)();
  DateTimeColumn get scheduledTime => dateTime()();
  DateTimeColumn get sentTime => dateTime().nullable()();
  TextColumn get status => text()(); // pending, sent, failed, dismissed
  TextColumn get errorMessage => text().nullable()();
}
