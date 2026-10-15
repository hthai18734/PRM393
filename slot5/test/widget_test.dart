import 'package:flutter_test/flutter_test.dart';
import 'package:live_counter_stream/main.dart';
import 'package:live_counter_stream/services/stream_service.dart';

void main() {
  testWidgets('Live Counter Stream App renders and reacts to Stream emits',
      (WidgetTester tester) async {
    final streamService = StreamService();

    // Pump MyApp widget tree
    await tester.pumpWidget(MyApp(streamService: streamService));

    // Initially waiting for data or loading indicator
    expect(find.text('Live Counter Stream App'), findsOneWidget);

    // Let the timer tick 1 second
    await tester.pump(const Duration(seconds: 1));

    // Counter value 1 should be visible
    expect(find.text('Counter: 1'), findsOneWidget);

    // Let the timer tick another second
    await tester.pump(const Duration(seconds: 1));

    // Counter value 2 should be visible
    expect(find.text('Counter: 2'), findsOneWidget);

    // Clean up
    streamService.dispose();
  });
}
