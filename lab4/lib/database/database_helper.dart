import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/bill.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  static const String tableName = 'bills';
  static const String columnId = 'id';
  static const String columnBillName = 'bill_name';
  static const String columnCategory = 'category';
  static const String columnAmount = 'amount';
  static const String columnStatus = 'status';
  static const String columnDueDate = 'due_date';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bills.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // If running on desktop platforms (Windows, Linux, macOS), use sqflite_common_ffi
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnBillName TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnStatus TEXT NOT NULL,
        $columnDueDate TEXT NOT NULL
      )
    ''');
  }

  // Insert a new bill
  Future<int> insertBill(Bill bill) async {
    final db = await instance.database;
    return await db.insert(tableName, bill.toMap());
  }

  // Retrieve all bills
  Future<List<Bill>> getAllBills() async {
    final db = await instance.database;
    final result = await db.query(tableName, orderBy: '$columnDueDate ASC');
    return result.map((map) => Bill.fromMap(map)).toList();
  }

  // Retrieve only unpaid bills
  Future<List<Bill>> getUnpaidBills() async {
    final db = await instance.database;
    final result = await db.query(
      tableName,
      where: '$columnStatus = ?',
      whereArgs: ['Unpaid'],
      orderBy: '$columnDueDate ASC',
    );
    return result.map((map) => Bill.fromMap(map)).toList();
  }

  // Retrieve a bill by its ID
  Future<Bill?> getBillById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Bill.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Update an existing bill
  Future<int> updateBill(Bill bill) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      bill.toMap(),
      where: '$columnId = ?',
      whereArgs: [bill.id],
    );
  }

  // Delete a bill by ID
  Future<int> deleteBill(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Get total outstanding amount of all unpaid bills
  Future<double> getTotalUnpaidAmount() async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT SUM($columnAmount) as total FROM $tableName WHERE $columnStatus = ?',
      ['Unpaid'],
    );
    final total = result.first['total'];
    if (total != null) {
      return (total as num).toDouble();
    }
    return 0.0;
  }

  // Close the database
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
