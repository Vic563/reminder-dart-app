import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurrence_rule.freezed.dart';
part 'recurrence_rule.g.dart';

enum RecurrenceFrequency {
  daily,
  weekly,
  monthly,
  yearly;

  String get label {
    switch (this) {
      case RecurrenceFrequency.daily:
        return 'Daily';
      case RecurrenceFrequency.weekly:
        return 'Weekly';
      case RecurrenceFrequency.monthly:
        return 'Monthly';
      case RecurrenceFrequency.yearly:
        return 'Yearly';
    }
  }

  String get rruleFreq {
    switch (this) {
      case RecurrenceFrequency.daily:
        return 'DAILY';
      case RecurrenceFrequency.weekly:
        return 'WEEKLY';
      case RecurrenceFrequency.monthly:
        return 'MONTHLY';
      case RecurrenceFrequency.yearly:
        return 'YEARLY';
    }
  }

  static RecurrenceFrequency fromRruleFreq(String freq) {
    switch (freq.toUpperCase()) {
      case 'DAILY':
        return RecurrenceFrequency.daily;
      case 'WEEKLY':
        return RecurrenceFrequency.weekly;
      case 'MONTHLY':
        return RecurrenceFrequency.monthly;
      case 'YEARLY':
        return RecurrenceFrequency.yearly;
      default:
        return RecurrenceFrequency.daily;
    }
  }
}

@freezed
class RecurrenceRule with _$RecurrenceRule {
  const RecurrenceRule._();

  const factory RecurrenceRule({
    required RecurrenceFrequency frequency,
    @Default(1) int interval,
    List<int>? byWeekDay,
    List<int>? byMonthDay,
    List<int>? byMonth,
    DateTime? until,
    int? count,
  }) = _RecurrenceRule;

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRuleFromJson(json);

  /// Convert to RRULE string (RFC 5545)
  String toRRuleString() {
    final parts = <String>['FREQ=${frequency.rruleFreq}'];

    if (interval > 1) {
      parts.add('INTERVAL=$interval');
    }

    if (byWeekDay != null && byWeekDay!.isNotEmpty) {
      final days = byWeekDay!.map(_weekDayToString).join(',');
      parts.add('BYDAY=$days');
    }

    if (byMonthDay != null && byMonthDay!.isNotEmpty) {
      parts.add('BYMONTHDAY=${byMonthDay!.join(',')}');
    }

    if (byMonth != null && byMonth!.isNotEmpty) {
      parts.add('BYMONTH=${byMonth!.join(',')}');
    }

    if (until != null) {
      parts.add('UNTIL=${_formatDateTime(until!)}');
    }

    if (count != null) {
      parts.add('COUNT=$count');
    }

    return 'RRULE:${parts.join(';')}';
  }

  /// Parse from RRULE string
  static RecurrenceRule? fromRRuleString(String rrule) {
    if (!rrule.startsWith('RRULE:')) {
      return null;
    }

    final ruleStr = rrule.substring(6);
    final parts = ruleStr.split(';');
    final params = <String, String>{};

    for (final part in parts) {
      final keyValue = part.split('=');
      if (keyValue.length == 2) {
        params[keyValue[0]] = keyValue[1];
      }
    }

    if (!params.containsKey('FREQ')) {
      return null;
    }

    return RecurrenceRule(
      frequency: RecurrenceFrequency.fromRruleFreq(params['FREQ']!),
      interval: int.tryParse(params['INTERVAL'] ?? '1') ?? 1,
      byWeekDay: params['BYDAY']?.split(',').map(_stringToWeekDay).toList(),
      byMonthDay:
          params['BYMONTHDAY']?.split(',').map(int.parse).toList(),
      byMonth: params['BYMONTH']?.split(',').map(int.parse).toList(),
      until: params['UNTIL'] != null ? _parseDateTime(params['UNTIL']!) : null,
      count: params['COUNT'] != null ? int.tryParse(params['COUNT']!) : null,
    );
  }

  static String _weekDayToString(int day) {
    const days = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
    return days[day.clamp(0, 6)];
  }

  static int _stringToWeekDay(String day) {
    const days = {'MO': 0, 'TU': 1, 'WE': 2, 'TH': 3, 'FR': 4, 'SA': 5, 'SU': 6};
    return days[day.toUpperCase()] ?? 0;
  }

  static String _formatDateTime(DateTime dt) {
    return '${dt.year}${dt.month.toString().padLeft(2, '0')}${dt.day.toString().padLeft(2, '0')}T${dt.hour.toString().padLeft(2, '0')}${dt.minute.toString().padLeft(2, '0')}${dt.second.toString().padLeft(2, '0')}Z';
  }

  static DateTime? _parseDateTime(String str) {
    try {
      final year = int.parse(str.substring(0, 4));
      final month = int.parse(str.substring(4, 6));
      final day = int.parse(str.substring(6, 8));
      int hour = 0, minute = 0, second = 0;
      if (str.length > 8 && str[8] == 'T') {
        hour = int.parse(str.substring(9, 11));
        minute = int.parse(str.substring(11, 13));
        second = int.parse(str.substring(13, 15));
      }
      return DateTime.utc(year, month, day, hour, minute, second);
    } catch (e) {
      return null;
    }
  }

  /// Calculate next occurrence after a given date
  DateTime? getNextOccurrence(DateTime after) {
    DateTime candidate = after;

    // Start from the next day for daily, or appropriate start
    switch (frequency) {
      case RecurrenceFrequency.daily:
        candidate = DateTime(
          after.year,
          after.month,
          after.day + interval,
          after.hour,
          after.minute,
        );
        break;
      case RecurrenceFrequency.weekly:
        candidate = after.add(Duration(days: 7 * interval));
        if (byWeekDay != null && byWeekDay!.isNotEmpty) {
          // Find the next matching weekday
          for (int i = 1; i <= 7; i++) {
            final check = after.add(Duration(days: i));
            if (byWeekDay!.contains(check.weekday - 1)) {
              candidate = check;
              break;
            }
          }
        }
        break;
      case RecurrenceFrequency.monthly:
        candidate = DateTime(
          after.year,
          after.month + interval,
          byMonthDay?.isNotEmpty == true ? byMonthDay!.first : after.day,
          after.hour,
          after.minute,
        );
        break;
      case RecurrenceFrequency.yearly:
        candidate = DateTime(
          after.year + interval,
          byMonth?.isNotEmpty == true ? byMonth!.first : after.month,
          byMonthDay?.isNotEmpty == true ? byMonthDay!.first : after.day,
          after.hour,
          after.minute,
        );
        break;
    }

    // Check if we've exceeded the until date or count
    if (until != null && candidate.isAfter(until!)) {
      return null;
    }

    return candidate;
  }

  String get description {
    switch (frequency) {
      case RecurrenceFrequency.daily:
        if (interval == 1) return 'Every day';
        return 'Every $interval days';
      case RecurrenceFrequency.weekly:
        if (interval == 1) return 'Every week';
        return 'Every $interval weeks';
      case RecurrenceFrequency.monthly:
        if (interval == 1) return 'Every month';
        return 'Every $interval months';
      case RecurrenceFrequency.yearly:
        if (interval == 1) return 'Every year';
        return 'Every $interval years';
    }
  }
}
