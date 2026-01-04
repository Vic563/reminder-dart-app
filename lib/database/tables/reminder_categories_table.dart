import 'package:drift/drift.dart';
import 'reminders_table.dart';
import 'categories_table.dart';

class ReminderCategories extends Table {
  IntColumn get reminderId => integer().references(Reminders, #id)();
  IntColumn get categoryId => integer().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {reminderId, categoryId};
}
