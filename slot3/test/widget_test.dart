import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_3/main.dart';

void main() {
  test('Function Processor logic tests', () {
    expect(calculateTotal(5, 7), 12);
    expect(calculateAverage(6, 8), 7.0);
  });
}
