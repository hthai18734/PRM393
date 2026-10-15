class Bill {
  final int? id;
  final String billName;
  final String category;
  final double amount;
  final String status;
  final String dueDate;

  Bill({
    this.id,
    required this.billName,
    required this.category,
    required this.amount,
    this.status = 'Unpaid',
    required this.dueDate,
  });

  // Convert a Bill into a Map. The keys correspond to the column names in SQLite.
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'bill_name': billName,
      'category': category,
      'amount': amount,
      'status': status,
      'due_date': dueDate,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Construct a Bill from a Map retrieved from SQLite.
  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as int?,
      billName: map['bill_name'] as String,
      category: map['category'] as String,
      amount: (map['amount'] as num).toDouble(),
      status: map['status'] as String? ?? 'Unpaid',
      dueDate: map['due_date'] as String,
    );
  }

  Bill copyWith({
    int? id,
    String? billName,
    String? category,
    double? amount,
    String? status,
    String? dueDate,
  }) {
    return Bill(
      id: id ?? this.id,
      billName: billName ?? this.billName,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
