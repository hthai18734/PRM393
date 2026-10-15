import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dashboard_app/main.dart';

void main() {
  testWidgets('App renders Product Dashboard Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProductDashboardApp());
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Quản lý sản phẩm dễ dàng'), findsOneWidget);
  });
}
