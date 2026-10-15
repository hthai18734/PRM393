import 'package:flutter_test/flutter_test.dart';
import 'package:smart_registration_app/main.dart';

void main() {
  testWidgets('App renders Smart Registration Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartRegistrationApp());
    expect(find.text('Smart Registration'), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
  });
}
