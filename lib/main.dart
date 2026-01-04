import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window manager for desktop
  await windowManager.ensureInitialized();

  // Configure window options
  await windowManager.setTitle('Reminder App');
  await windowManager.setSize(const Size(1000, 700));
  await windowManager.setMinimumSize(const Size(600, 400));
  await windowManager.center();

  runApp(
    const ProviderScope(
      child: ReminderApp(),
    ),
  );

  // Show window after app starts
  await windowManager.show();
  await windowManager.focus();
}
