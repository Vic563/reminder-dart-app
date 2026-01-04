// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeModeHash() => r'd3a20be32798497f0a1c9e5aa10d14652287d48d';

/// See also [AppThemeMode].
@ProviderFor(AppThemeMode)
final appThemeModeProvider =
    AutoDisposeNotifierProvider<AppThemeMode, ThemeMode>.internal(
      AppThemeMode.new,
      name: r'appThemeModeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appThemeModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppThemeMode = AutoDisposeNotifier<ThemeMode>;
String _$notificationsEnabledHash() =>
    r'87bba23b46b391c3d9cc2a0eae454031aed2f769';

/// See also [NotificationsEnabled].
@ProviderFor(NotificationsEnabled)
final notificationsEnabledProvider =
    AutoDisposeNotifierProvider<NotificationsEnabled, bool>.internal(
      NotificationsEnabled.new,
      name: r'notificationsEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationsEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationsEnabled = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
