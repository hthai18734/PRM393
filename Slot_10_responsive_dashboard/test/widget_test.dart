import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_dashboard/main.dart';

void main() {
  testWidgets('App renders Responsive Dashboard Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ResponsiveApp());
    expect(find.text('Responsive Dashboard'), findsOneWidget);
    expect(find.text('Revenue'), findsOneWidget);
  });
}
