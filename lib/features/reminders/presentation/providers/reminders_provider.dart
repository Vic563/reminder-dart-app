import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../database/database.dart';
import '../../domain/entities/priority.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/entities/recurrence_rule.dart';
import '../../../categories/domain/entities/category_entity.dart';

part 'reminders_provider.g.dart';

// Database provider
@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

// Reminder filter state
enum ReminderSortOrder { dueDate, priority, createdAt }

class ReminderFilterState {
  final int? categoryId;
  final Priority? priority;
  final bool showCompleted;
  final ReminderSortOrder sortOrder;

  const ReminderFilterState({
    this.categoryId,
    this.priority,
    this.showCompleted = false,
    this.sortOrder = ReminderSortOrder.dueDate,
  });

  ReminderFilterState copyWith({
    int? categoryId,
    Priority? priority,
    bool? showCompleted,
    ReminderSortOrder? sortOrder,
    bool clearCategoryId = false,
    bool clearPriority = false,
  }) {
    return ReminderFilterState(
      categoryId: clearCategoryId ? null : (categoryId ?? this.categoryId),
      priority: clearPriority ? null : (priority ?? this.priority),
      showCompleted: showCompleted ?? this.showCompleted,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

@riverpod
class ReminderFilter extends _$ReminderFilter {
  @override
  ReminderFilterState build() => const ReminderFilterState();

  void setCategory(int? categoryId) {
    state = state.copyWith(categoryId: categoryId, clearCategoryId: categoryId == null);
  }

  void setPriority(Priority? priority) {
    state = state.copyWith(priority: priority, clearPriority: priority == null);
  }

  void setShowCompleted(bool show) {
    state = state.copyWith(showCompleted: show);
  }

  void setSortOrder(ReminderSortOrder order) {
    state = state.copyWith(sortOrder: order);
  }

  void clearFilters() {
    state = const ReminderFilterState();
  }
}

// Convert database Reminder to ReminderEntity
ReminderEntity _toEntity(Reminder r, List<CategoryEntity> categories) {
  return ReminderEntity(
    id: r.id,
    title: r.title,
    description: r.description,
    dueDate: r.dueDate,
    priority: Priority.fromValue(r.priority),
    isCompleted: r.isCompleted,
    isRecurring: r.isRecurring,
    recurrenceRule: r.recurrenceRule != null
        ? RecurrenceRule.fromRRuleString(r.recurrenceRule!)
        : null,
    parentReminderId: r.parentReminderId,
    categories: categories,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
    completedAt: r.completedAt,
  );
}

@riverpod
Stream<List<ReminderEntity>> remindersStream(Ref ref) async* {
  final db = ref.watch(databaseProvider);

  await for (final reminders in db.watchAllReminders()) {
    final entities = <ReminderEntity>[];
    for (final r in reminders) {
      final dbCategories = await db.getCategoriesForReminder(r.id);
      final categories = dbCategories
          .map((c) => CategoryEntity(
                id: c.id,
                name: c.name,
                colorValue: c.color,
                iconName: c.iconName,
                createdAt: c.createdAt,
              ))
          .toList();
      entities.add(_toEntity(r, categories));
    }
    yield entities;
  }
}

@riverpod
Future<List<ReminderEntity>> filteredReminders(Ref ref) async {
  final reminders = await ref.watch(remindersStreamProvider.future);
  final filter = ref.watch(reminderFilterProvider);

  var filtered = reminders.where((r) {
    if (!filter.showCompleted && r.isCompleted) return false;
    if (filter.categoryId != null &&
        !r.categories.any((c) => c.id == filter.categoryId)) return false;
    if (filter.priority != null && r.priority != filter.priority) return false;
    return true;
  }).toList();

  // Sort
  switch (filter.sortOrder) {
    case ReminderSortOrder.dueDate:
      filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      break;
    case ReminderSortOrder.priority:
      filtered.sort((a, b) => b.priority.value.compareTo(a.priority.value));
      break;
    case ReminderSortOrder.createdAt:
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      break;
  }

  return filtered;
}

@riverpod
class RemindersNotifier extends _$RemindersNotifier {
  @override
  FutureOr<void> build() {}

  Future<int> addReminder({
    required String title,
    String? description,
    required DateTime dueDate,
    required Priority priority,
    bool isRecurring = false,
    RecurrenceRule? recurrenceRule,
    List<int>? categoryIds,
  }) async {
    final db = ref.read(databaseProvider);
    final now = DateTime.now();

    final id = await db.insertReminder(
      RemindersCompanion.insert(
        title: title,
        description: Value(description),
        dueDate: dueDate,
        priority: Value(priority.value),
        isRecurring: Value(isRecurring),
        recurrenceRule: Value(recurrenceRule?.toRRuleString()),
        createdAt: now,
        updatedAt: now,
      ),
    );

    if (categoryIds != null && categoryIds.isNotEmpty) {
      await db.setReminderCategories(id, categoryIds);
    }

    ref.invalidate(remindersStreamProvider);
    return id;
  }

  Future<void> updateReminder({
    required int id,
    required String title,
    String? description,
    required DateTime dueDate,
    required Priority priority,
    bool isRecurring = false,
    RecurrenceRule? recurrenceRule,
    List<int>? categoryIds,
  }) async {
    final db = ref.read(databaseProvider);

    await db.updateReminder(
      RemindersCompanion(
        id: Value(id),
        title: Value(title),
        description: Value(description),
        dueDate: Value(dueDate),
        priority: Value(priority.value),
        isRecurring: Value(isRecurring),
        recurrenceRule: Value(recurrenceRule?.toRRuleString()),
        updatedAt: Value(DateTime.now()),
      ),
    );

    if (categoryIds != null) {
      await db.setReminderCategories(id, categoryIds);
    }

    ref.invalidate(remindersStreamProvider);
  }

  Future<void> toggleComplete(int id) async {
    final db = ref.read(databaseProvider);
    await db.toggleReminderComplete(id);
    ref.invalidate(remindersStreamProvider);
  }

  Future<void> deleteReminder(int id) async {
    final db = ref.read(databaseProvider);
    await db.deleteReminder(id);
    ref.invalidate(remindersStreamProvider);
  }
}
