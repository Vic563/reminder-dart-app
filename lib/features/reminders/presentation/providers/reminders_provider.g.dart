// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'd66464688f3f3beae31aa517238455b4413086f1';

/// See also [database].
@ProviderFor(database)
final databaseProvider = Provider<AppDatabase>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = ProviderRef<AppDatabase>;
String _$remindersStreamHash() => r'7366bca156f279f185e33eb869e051d8f132dc67';

/// See also [remindersStream].
@ProviderFor(remindersStream)
final remindersStreamProvider =
    AutoDisposeStreamProvider<List<ReminderEntity>>.internal(
      remindersStream,
      name: r'remindersStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remindersStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemindersStreamRef = AutoDisposeStreamProviderRef<List<ReminderEntity>>;
String _$filteredRemindersHash() => r'def4d7d0e550c0076f73996192cec85f25f42735';

/// See also [filteredReminders].
@ProviderFor(filteredReminders)
final filteredRemindersProvider =
    AutoDisposeFutureProvider<List<ReminderEntity>>.internal(
      filteredReminders,
      name: r'filteredRemindersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredRemindersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredRemindersRef =
    AutoDisposeFutureProviderRef<List<ReminderEntity>>;
String _$reminderFilterHash() => r'999605689ddec3ce9a5cee8885a3461bcfce859a';

/// See also [ReminderFilter].
@ProviderFor(ReminderFilter)
final reminderFilterProvider =
    AutoDisposeNotifierProvider<ReminderFilter, ReminderFilterState>.internal(
      ReminderFilter.new,
      name: r'reminderFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reminderFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReminderFilter = AutoDisposeNotifier<ReminderFilterState>;
String _$remindersNotifierHash() => r'1ecd811fdf057b00b42dcee291452e101c2b7506';

/// See also [RemindersNotifier].
@ProviderFor(RemindersNotifier)
final remindersNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RemindersNotifier, void>.internal(
      RemindersNotifier.new,
      name: r'remindersNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remindersNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RemindersNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
