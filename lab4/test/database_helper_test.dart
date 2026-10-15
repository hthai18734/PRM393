import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:lab4/models/bill.dart';

void main() {
  // Initialize ffi for testing SQLite
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE bills (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bill_name TEXT NOT NULL,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        status TEXT NOT NULL,
        due_date TEXT NOT NULL
      )
    ''');
  });

  tearDown(() async {
    await db.close();
  });

  test('Insert and query bills', () async {
    final bill1 = Bill(
      billName: 'Electricity - September',
      category: 'Utilities',
      amount: 850000,
      status: 'Unpaid',
      dueDate: '2025-10-30',
    );
    final id1 = await db.insert('bills', bill1.toMap());
    expect(id1, 1);

    final bill2 = Bill(
      billName: 'Internet - Viettel',
      category: 'Subscription',
      amount: 250000,
      status: 'Paid',
      dueDate: '2025-11-01',
    );
    final id2 = await db.insert('bills', bill2.toMap());
    expect(id2, 2);

    final all = await db.query('bills');
    expect(all.length, 2);

    // Query unpaid
    final unpaid = await db.query('bills', where: 'status = ?', whereArgs: ['Unpaid']);
    expect(unpaid.length, 1);
    expect(unpaid.first['bill_name'], 'Electricity - September');

    // Total unpaid sum
    final sumResult = await db.rawQuery('SELECT SUM(amount) as total FROM bills WHERE status = ?', ['Unpaid']);
    expect((sumResult.first['total'] as num).toDouble(), 850000.0);
  });

  test('Update bill', () async {
    final bill = Bill(
      billName: 'Electricity - September',
      category: 'Utilities',
      amount: 850000,
      status: 'Unpaid',
      dueDate: '2025-10-30',
    );
    final id = await db.insert('bills', bill.toMap());

    // Update to Paid
    final updatedBill = bill.copyWith(id: id, status: 'Paid', amount: 900000);
    await db.update('bills', updatedBill.toMap(), where: 'id = ?', whereArgs: [id]);

    final res = await db.query('bills', where: 'id = ?', whereArgs: [id]);
    expect(res.first['status'], 'Paid');
    expect((res.first['amount'] as num).toDouble(), 900000.0);
  });

  test('Delete bill', () async {
    final bill = Bill(
      billName: 'Apartment Rent - November',
      category: 'Rent',
      amount: 4500000,
      status: 'Unpaid',
      dueDate: '2025-11-05',
    );
    final id = await db.insert('bills', bill.toMap());

    await db.delete('bills', where: 'id = ?', whereArgs: [id]);
    final res = await db.query('bills', where: 'id = ?', whereArgs: [id]);
    expect(res, isEmpty);
  });
}
