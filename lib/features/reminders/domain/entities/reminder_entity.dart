import 'package:freezed_annotation/freezed_annotation.dart';
import 'priority.dart';
import 'recurrence_rule.dart';
import '../../../categories/domain/entities/category_entity.dart';

part 'reminder_entity.freezed.dart';
part 'reminder_entity.g.dart';

@freezed
class ReminderEntity with _$ReminderEntity {
  const ReminderEntity._();

  const factory ReminderEntity({
    int? id,
    required String title,
    String? description,
    required DateTime dueDate,
    @Default(Priority.medium) Priority priority,
    @Default(false) bool isCompleted,
    @Default(false) bool isRecurring,
    RecurrenceRule? recurrenceRule,
    int? parentReminderId,
    @Default([]) List<CategoryEntity> categories,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
  }) = _ReminderEntity;

  factory ReminderEntity.fromJson(Map<String, dynamic> json) =>
      _$ReminderEntityFromJson(json);

  bool get isOverdue =>
      !isCompleted && dueDate.isBefore(DateTime.now());

  bool get isDueToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return dueDay.isAtSameMomentAs(today);
  }

  bool get isDueTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return dueDay.isAtSameMomentAs(tomorrow);
  }

  bool get isDueThisWeek {
    final now = DateTime.now();
    final weekEnd = now.add(Duration(days: 7 - now.weekday));
    return dueDate.isBefore(weekEnd) && dueDate.isAfter(now);
  }

  String get dueDateLabel {
    if (isDueToday) return 'Today';
    if (isDueTomorrow) return 'Tomorrow';
    if (isOverdue) return 'Overdue';
    return '';
  }
}
