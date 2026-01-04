// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurrence_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RecurrenceRule _$RecurrenceRuleFromJson(Map<String, dynamic> json) {
  return _RecurrenceRule.fromJson(json);
}

/// @nodoc
mixin _$RecurrenceRule {
  RecurrenceFrequency get frequency => throw _privateConstructorUsedError;
  int get interval => throw _privateConstructorUsedError;
  List<int>? get byWeekDay => throw _privateConstructorUsedError;
  List<int>? get byMonthDay => throw _privateConstructorUsedError;
  List<int>? get byMonth => throw _privateConstructorUsedError;
  DateTime? get until => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  /// Serializes this RecurrenceRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecurrenceRuleCopyWith<RecurrenceRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurrenceRuleCopyWith<$Res> {
  factory $RecurrenceRuleCopyWith(
    RecurrenceRule value,
    $Res Function(RecurrenceRule) then,
  ) = _$RecurrenceRuleCopyWithImpl<$Res, RecurrenceRule>;
  @useResult
  $Res call({
    RecurrenceFrequency frequency,
    int interval,
    List<int>? byWeekDay,
    List<int>? byMonthDay,
    List<int>? byMonth,
    DateTime? until,
    int? count,
  });
}

/// @nodoc
class _$RecurrenceRuleCopyWithImpl<$Res, $Val extends RecurrenceRule>
    implements $RecurrenceRuleCopyWith<$Res> {
  _$RecurrenceRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? interval = null,
    Object? byWeekDay = freezed,
    Object? byMonthDay = freezed,
    Object? byMonth = freezed,
    Object? until = freezed,
    Object? count = freezed,
  }) {
    return _then(
      _value.copyWith(
            frequency: null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                      as RecurrenceFrequency,
            interval: null == interval
                ? _value.interval
                : interval // ignore: cast_nullable_to_non_nullable
                      as int,
            byWeekDay: freezed == byWeekDay
                ? _value.byWeekDay
                : byWeekDay // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            byMonthDay: freezed == byMonthDay
                ? _value.byMonthDay
                : byMonthDay // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            byMonth: freezed == byMonth
                ? _value.byMonth
                : byMonth // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            until: freezed == until
                ? _value.until
                : until // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            count: freezed == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecurrenceRuleImplCopyWith<$Res>
    implements $RecurrenceRuleCopyWith<$Res> {
  factory _$$RecurrenceRuleImplCopyWith(
    _$RecurrenceRuleImpl value,
    $Res Function(_$RecurrenceRuleImpl) then,
  ) = __$$RecurrenceRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    RecurrenceFrequency frequency,
    int interval,
    List<int>? byWeekDay,
    List<int>? byMonthDay,
    List<int>? byMonth,
    DateTime? until,
    int? count,
  });
}

/// @nodoc
class __$$RecurrenceRuleImplCopyWithImpl<$Res>
    extends _$RecurrenceRuleCopyWithImpl<$Res, _$RecurrenceRuleImpl>
    implements _$$RecurrenceRuleImplCopyWith<$Res> {
  __$$RecurrenceRuleImplCopyWithImpl(
    _$RecurrenceRuleImpl _value,
    $Res Function(_$RecurrenceRuleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? interval = null,
    Object? byWeekDay = freezed,
    Object? byMonthDay = freezed,
    Object? byMonth = freezed,
    Object? until = freezed,
    Object? count = freezed,
  }) {
    return _then(
      _$RecurrenceRuleImpl(
        frequency: null == frequency
            ? _value.frequency
            : frequency // ignore: cast_nullable_to_non_nullable
                  as RecurrenceFrequency,
        interval: null == interval
            ? _value.interval
            : interval // ignore: cast_nullable_to_non_nullable
                  as int,
        byWeekDay: freezed == byWeekDay
            ? _value._byWeekDay
            : byWeekDay // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        byMonthDay: freezed == byMonthDay
            ? _value._byMonthDay
            : byMonthDay // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        byMonth: freezed == byMonth
            ? _value._byMonth
            : byMonth // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        until: freezed == until
            ? _value.until
            : until // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        count: freezed == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurrenceRuleImpl extends _RecurrenceRule {
  const _$RecurrenceRuleImpl({
    required this.frequency,
    this.interval = 1,
    final List<int>? byWeekDay,
    final List<int>? byMonthDay,
    final List<int>? byMonth,
    this.until,
    this.count,
  }) : _byWeekDay = byWeekDay,
       _byMonthDay = byMonthDay,
       _byMonth = byMonth,
       super._();

  factory _$RecurrenceRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurrenceRuleImplFromJson(json);

  @override
  final RecurrenceFrequency frequency;
  @override
  @JsonKey()
  final int interval;
  final List<int>? _byWeekDay;
  @override
  List<int>? get byWeekDay {
    final value = _byWeekDay;
    if (value == null) return null;
    if (_byWeekDay is EqualUnmodifiableListView) return _byWeekDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _byMonthDay;
  @override
  List<int>? get byMonthDay {
    final value = _byMonthDay;
    if (value == null) return null;
    if (_byMonthDay is EqualUnmodifiableListView) return _byMonthDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _byMonth;
  @override
  List<int>? get byMonth {
    final value = _byMonth;
    if (value == null) return null;
    if (_byMonth is EqualUnmodifiableListView) return _byMonth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? until;
  @override
  final int? count;

  @override
  String toString() {
    return 'RecurrenceRule(frequency: $frequency, interval: $interval, byWeekDay: $byWeekDay, byMonthDay: $byMonthDay, byMonth: $byMonth, until: $until, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurrenceRuleImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            const DeepCollectionEquality().equals(
              other._byWeekDay,
              _byWeekDay,
            ) &&
            const DeepCollectionEquality().equals(
              other._byMonthDay,
              _byMonthDay,
            ) &&
            const DeepCollectionEquality().equals(other._byMonth, _byMonth) &&
            (identical(other.until, until) || other.until == until) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    frequency,
    interval,
    const DeepCollectionEquality().hash(_byWeekDay),
    const DeepCollectionEquality().hash(_byMonthDay),
    const DeepCollectionEquality().hash(_byMonth),
    until,
    count,
  );

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurrenceRuleImplCopyWith<_$RecurrenceRuleImpl> get copyWith =>
      __$$RecurrenceRuleImplCopyWithImpl<_$RecurrenceRuleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurrenceRuleImplToJson(this);
  }
}

abstract class _RecurrenceRule extends RecurrenceRule {
  const factory _RecurrenceRule({
    required final RecurrenceFrequency frequency,
    final int interval,
    final List<int>? byWeekDay,
    final List<int>? byMonthDay,
    final List<int>? byMonth,
    final DateTime? until,
    final int? count,
  }) = _$RecurrenceRuleImpl;
  const _RecurrenceRule._() : super._();

  factory _RecurrenceRule.fromJson(Map<String, dynamic> json) =
      _$RecurrenceRuleImpl.fromJson;

  @override
  RecurrenceFrequency get frequency;
  @override
  int get interval;
  @override
  List<int>? get byWeekDay;
  @override
  List<int>? get byMonthDay;
  @override
  List<int>? get byMonth;
  @override
  DateTime? get until;
  @override
  int? get count;

  /// Create a copy of RecurrenceRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurrenceRuleImplCopyWith<_$RecurrenceRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
