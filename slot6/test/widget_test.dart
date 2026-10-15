import 'package:flutter_test/flutter_test.dart';
import 'package:student_list_app/main.dart';

void main() {
  testWidgets('App renders Student List and displays students', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentListApp());

    // Verify AppBar title is present
    expect(find.text('Student List'), findsOneWidget);

    // Verify first student is shown
    expect(find.text('Nguyễn Văn A'), findsOneWidget);
    expect(find.text('SV01'), findsOneWidget);

    // Tap on the first item to toggle status
    await tester.tap(find.text('Nguyễn Văn A'));
    await tester.pump();
  });
}
