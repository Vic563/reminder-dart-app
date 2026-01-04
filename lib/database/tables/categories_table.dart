import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100).unique()();
  IntColumn get color => integer()();
  TextColumn get iconName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
