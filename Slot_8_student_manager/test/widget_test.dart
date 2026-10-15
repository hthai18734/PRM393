import 'package:flutter_test/flutter_test.dart';
import 'package:student_manager_app/main.dart';

void main() {
  testWidgets('App renders Student Manager Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentManagerApp());
    expect(find.text('Student Manager - Home'), findsOneWidget);
    expect(find.text('Xem danh sách sinh viên'), findsOneWidget);
  });
}
