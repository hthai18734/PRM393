import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/models/bill.dart';
import 'package:lab4/utils/formatters.dart';

void main() {
  group('Bill Model Tests', () {
    test('Bill toMap and fromMap works correctly', () {
      final bill = Bill(
        id: 1,
        billName: 'Electricity - September',
        category: 'Utilities',
        amount: 850000.0,
        status: 'Unpaid',
        dueDate: '2025-10-30',
      );

      final map = bill.toMap();
      expect(map['id'], 1);
      expect(map['bill_name'], 'Electricity - September');
      expect(map['category'], 'Utilities');
      expect(map['amount'], 850000.0);
      expect(map['status'], 'Unpaid');
      expect(map['due_date'], '2025-10-30');

      final fromMap = Bill.fromMap(map);
      expect(fromMap.id, bill.id);
      expect(fromMap.billName, bill.billName);
      expect(fromMap.category, bill.category);
      expect(fromMap.amount, bill.amount);
      expect(fromMap.status, bill.status);
      expect(fromMap.dueDate, bill.dueDate);
    });

    test('Bill copyWith works correctly', () {
      final bill = Bill(
        id: 1,
        billName: 'Rent - October',
        category: 'Rent',
        amount: 4500000.0,
        status: 'Unpaid',
        dueDate: '2025-11-05',
      );

      final updated = bill.copyWith(status: 'Paid', amount: 5000000.0);
      expect(updated.status, 'Paid');
      expect(updated.amount, 5000000.0);
      expect(updated.billName, 'Rent - October');
      expect(updated.id, 1);
    });
  });

  group('Formatter Tests', () {
    test('formatVND formats numbers with dot separator and currency symbol', () {
      expect(Formatters.formatVND(850000), contains('850'));
      expect(Formatters.formatVND(850000), contains('đ'));
      expect(Formatters.formatVND(4500000), contains('4'));
    });

    test('category icons and colors are defined', () {
      expect(Formatters.categories.length, 5);
      for (final cat in Formatters.categories) {
        expect(Formatters.getCategoryIcon(cat), isNotNull);
        expect(Formatters.getCategoryColor(cat), isNotNull);
      }
    });
  });
}
