// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecurrenceRuleImpl _$$RecurrenceRuleImplFromJson(Map<String, dynamic> json) =>
    _$RecurrenceRuleImpl(
      frequency: $enumDecode(_$RecurrenceFrequencyEnumMap, json['frequency']),
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      byWeekDay: (json['byWeekDay'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      byMonthDay: (json['byMonthDay'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      byMonth: (json['byMonth'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      until: json['until'] == null
          ? null
          : DateTime.parse(json['until'] as String),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RecurrenceRuleImplToJson(
  _$RecurrenceRuleImpl instance,
) => <String, dynamic>{
  'frequency': _$RecurrenceFrequencyEnumMap[instance.frequency]!,
  'interval': instance.interval,
  'byWeekDay': instance.byWeekDay,
  'byMonthDay': instance.byMonthDay,
  'byMonth': instance.byMonth,
  'until': instance.until?.toIso8601String(),
  'count': instance.count,
};

const _$RecurrenceFrequencyEnumMap = {
  RecurrenceFrequency.daily: 'daily',
  RecurrenceFrequency.weekly: 'weekly',
  RecurrenceFrequency.monthly: 'monthly',
  RecurrenceFrequency.yearly: 'yearly',
};
