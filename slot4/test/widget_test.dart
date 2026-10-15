import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:async_product_loader/main.dart';

void main() {
  testWidgets('Load and display products in HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Initially waiting for Future, CircularProgressIndicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Fast-forward 2 seconds to complete the fake API future
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // After future completes, products are shown
    expect(find.text('Táo'), findsOneWidget);
    expect(find.text('10000.0 VND'), findsOneWidget);
    expect(find.text('Cam'), findsOneWidget);
    expect(find.text('Chuối'), findsOneWidget);
  });
}
