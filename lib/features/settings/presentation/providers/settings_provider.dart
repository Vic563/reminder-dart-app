import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

@riverpod
class NotificationsEnabled extends _$NotificationsEnabled {
  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
}
