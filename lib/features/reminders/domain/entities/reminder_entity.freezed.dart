// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReminderEntity _$ReminderEntityFromJson(Map<String, dynamic> json) {
  return _ReminderEntity.fromJson(json);
}

/// @nodoc
mixin _$ReminderEntity {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  Priority get priority => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  RecurrenceRule? get recurrenceRule => throw _privateConstructorUsedError;
  int? get parentReminderId => throw _privateConstructorUsedError;
  List<CategoryEntity> get categories => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this ReminderEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderEntityCopyWith<ReminderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderEntityCopyWith<$Res> {
  factory $ReminderEntityCopyWith(
    ReminderEntity value,
    $Res Function(ReminderEntity) then,
  ) = _$ReminderEntityCopyWithImpl<$Res, ReminderEntity>;
  @useResult
  $Res call({
    int? id,
    String title,
    String? description,
    DateTime dueDate,
    Priority priority,
    bool isCompleted,
    bool isRecurring,
    RecurrenceRule? recurrenceRule,
    int? parentReminderId,
    List<CategoryEntity> categories,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? completedAt,
  });

  $RecurrenceRuleCopyWith<$Res>? get recurrenceRule;
}

/// @nodoc
class _$ReminderEntityCopyWithImpl<$Res, $Val extends ReminderEntity>
    implements $ReminderEntityCopyWith<$Res> {
  _$ReminderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? dueDate = null,
    Object? priority = null,
    Object? isCompleted = null,
    Object? isRecurring = null,
    Object? recurrenceRule = freezed,
    Object? parentReminderId = freezed,
    Object? categories = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as Priority,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRecurring: null == isRecurring
                ? _value.isRecurring
                : isRecurring // ignore: cast_nullable_to_non_nullable
                      as bool,
            recurrenceRule: freezed == recurrenceRule
                ? _value.recurrenceRule
                : recurrenceRule // ignore: cast_nullable_to_non_nullable
                      as RecurrenceRule?,
            parentReminderId: freezed == parentReminderId
                ? _value.parentReminderId
                : parentReminderId // ignore: cast_nullable_to_non_nullable
                      as int?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<CategoryEntity>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecurrenceRuleCopyWith<$Res>? get recurrenceRule {
    if (_value.recurrenceRule == null) {
      return null;
    }

    return $RecurrenceRuleCopyWith<$Res>(_value.recurrenceRule!, (value) {
      return _then(_value.copyWith(recurrenceRule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReminderEntityImplCopyWith<$Res>
    implements $ReminderEntityCopyWith<$Res> {
  factory _$$ReminderEntityImplCopyWith(
    _$ReminderEntityImpl value,
    $Res Function(_$ReminderEntityImpl) then,
  ) = __$$ReminderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String title,
    String? description,
    DateTime dueDate,
    Priority priority,
    bool isCompleted,
    bool isRecurring,
    RecurrenceRule? recurrenceRule,
    int? parentReminderId,
    List<CategoryEntity> categories,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? completedAt,
  });

  @override
  $RecurrenceRuleCopyWith<$Res>? get recurrenceRule;
}

/// @nodoc
class __$$ReminderEntityImplCopyWithImpl<$Res>
    extends _$ReminderEntityCopyWithImpl<$Res, _$ReminderEntityImpl>
    implements _$$ReminderEntityImplCopyWith<$Res> {
  __$$ReminderEntityImplCopyWithImpl(
    _$ReminderEntityImpl _value,
    $Res Function(_$ReminderEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? dueDate = null,
    Object? priority = null,
    Object? isCompleted = null,
    Object? isRecurring = null,
    Object? recurrenceRule = freezed,
    Object? parentReminderId = freezed,
    Object? categories = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$ReminderEntityImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as Priority,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRecurring: null == isRecurring
            ? _value.isRecurring
            : isRecurring // ignore: cast_nullable_to_non_nullable
                  as bool,
        recurrenceRule: freezed == recurrenceRule
            ? _value.recurrenceRule
            : recurrenceRule // ignore: cast_nullable_to_non_nullable
                  as RecurrenceRule?,
        parentReminderId: freezed == parentReminderId
            ? _value.parentReminderId
            : parentReminderId // ignore: cast_nullable_to_non_nullable
                  as int?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<CategoryEntity>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReminderEntityImpl extends _ReminderEntity {
  const _$ReminderEntityImpl({
    this.id,
    required this.title,
    this.description,
    required this.dueDate,
    this.priority = Priority.medium,
    this.isCompleted = false,
    this.isRecurring = false,
    this.recurrenceRule,
    this.parentReminderId,
    final List<CategoryEntity> categories = const [],
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  }) : _categories = categories,
       super._();

  factory _$ReminderEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReminderEntityImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime dueDate;
  @override
  @JsonKey()
  final Priority priority;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  final RecurrenceRule? recurrenceRule;
  @override
  final int? parentReminderId;
  final List<CategoryEntity> _categories;
  @override
  @JsonKey()
  List<CategoryEntity> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'ReminderEntity(id: $id, title: $title, description: $description, dueDate: $dueDate, priority: $priority, isCompleted: $isCompleted, isRecurring: $isRecurring, recurrenceRule: $recurrenceRule, parentReminderId: $parentReminderId, categories: $categories, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                other.recurrenceRule == recurrenceRule) &&
            (identical(other.parentReminderId, parentReminderId) ||
                other.parentReminderId == parentReminderId) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    dueDate,
    priority,
    isCompleted,
    isRecurring,
    recurrenceRule,
    parentReminderId,
    const DeepCollectionEquality().hash(_categories),
    createdAt,
    updatedAt,
    completedAt,
  );

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderEntityImplCopyWith<_$ReminderEntityImpl> get copyWith =>
      __$$ReminderEntityImplCopyWithImpl<_$ReminderEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderEntityImplToJson(this);
  }
}

abstract class _ReminderEntity extends ReminderEntity {
  const factory _ReminderEntity({
    final int? id,
    required final String title,
    final String? description,
    required final DateTime dueDate,
    final Priority priority,
    final bool isCompleted,
    final bool isRecurring,
    final RecurrenceRule? recurrenceRule,
    final int? parentReminderId,
    final List<CategoryEntity> categories,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? completedAt,
  }) = _$ReminderEntityImpl;
  const _ReminderEntity._() : super._();

  factory _ReminderEntity.fromJson(Map<String, dynamic> json) =
      _$ReminderEntityImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get dueDate;
  @override
  Priority get priority;
  @override
  bool get isCompleted;
  @override
  bool get isRecurring;
  @override
  RecurrenceRule? get recurrenceRule;
  @override
  int? get parentReminderId;
  @override
  List<CategoryEntity> get categories;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderEntityImplCopyWith<_$ReminderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
