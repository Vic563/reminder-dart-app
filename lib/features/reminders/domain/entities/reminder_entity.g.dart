// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderEntityImpl _$$ReminderEntityImplFromJson(Map<String, dynamic> json) =>
    _$ReminderEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority:
          $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ??
          Priority.medium,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurrenceRule: json['recurrenceRule'] == null
          ? null
          : RecurrenceRule.fromJson(
              json['recurrenceRule'] as Map<String, dynamic>,
            ),
      parentReminderId: (json['parentReminderId'] as num?)?.toInt(),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$ReminderEntityImplToJson(
  _$ReminderEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'dueDate': instance.dueDate.toIso8601String(),
  'priority': _$PriorityEnumMap[instance.priority]!,
  'isCompleted': instance.isCompleted,
  'isRecurring': instance.isRecurring,
  'recurrenceRule': instance.recurrenceRule,
  'parentReminderId': instance.parentReminderId,
  'categories': instance.categories,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
};

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
};
