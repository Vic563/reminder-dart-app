import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reminder_app/app.dart';

void main() {
  testWidgets('App starts without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ReminderApp(),
      ),
    );

    // Pump a few frames to allow initial build
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify the app builds without errors
    // The app uses async providers so we just verify it doesn't crash
    expect(find.byType(ReminderApp), findsOneWidget);
  });
}
