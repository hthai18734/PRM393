import 'package:flutter_test/flutter_test.dart';
import 'package:simple_planner_app/main.dart';

void main() {
  testWidgets('Simple Planner smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that AppBar title and empty message appear.
    expect(find.text('My Planner'), findsOneWidget);
    expect(find.text('Create Plan'), findsOneWidget);
    expect(find.text('No plans yet.\nTap "Create Plan" to add one.'), findsOneWidget);
  });
}
