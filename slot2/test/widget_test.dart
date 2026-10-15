import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_daily_planner/main.dart';

void main() {
  testWidgets('Daily Planner adds task test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify initially no task item is present.
    expect(find.text('Công việc số 1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our first task has been added.
    expect(find.text('Công việc số 1'), findsOneWidget);
  });
}
