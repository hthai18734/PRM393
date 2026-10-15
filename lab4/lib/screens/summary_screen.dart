import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/bill.dart';
import '../utils/formatters.dart';
import 'update_bill_screen.dart';

class SummaryScreen extends StatefulWidget {
  final VoidCallback? onDataChanged;

  const SummaryScreen({super.key, this.onDataChanged});

  @override
  State<SummaryScreen> createState() => SummaryScreenState();
}

class SummaryScreenState extends State<SummaryScreen> {
  List<Bill> _unpaidBills = [];
  double _totalOutstanding = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUnpaidBills();
  }

  Future<void> loadUnpaidBills() async {
    setState(() {
      _isLoading = true;
    });

    final unpaidBills = await DatabaseHelper.instance.getUnpaidBills();
    final total = await DatabaseHelper.instance.getTotalUnpaidAmount();

    if (mounted) {
      setState(() {
        _unpaidBills = unpaidBills;
        _totalOutstanding = total;
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToUpdateBill(Bill bill) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateBillScreen(bill: bill)),
    );
    if (result == true) {
      loadUnpaidBills();
      widget.onDataChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: loadUnpaidBills,
                child: Column(
                  children: [
                    // Top Header Section matching Figure 5
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFF9800),
                            ),
                            child: const Center(
                              child: Text(
                                '!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Unpaid Bills',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263238),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_unpaidBills.length} bills unpaid',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // List of Unpaid Bills matching Figure 5
                    Expanded(
                      child: _unpaidBills.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 64,
                                    color: Colors.green.shade400,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'All bills paid!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'No outstanding payments',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _unpaidBills.length,
                              itemBuilder: (context, index) {
                                final bill = _unpaidBills[index];
                                final categoryColor = Formatters.getCategoryColor(bill.category);

                                return Card(
                                  elevation: 1,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => _navigateToUpdateBill(bill),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFFF9800),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bill.billName,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF263238),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  bill.category,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: categoryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            Formatters.formatVND(bill.amount),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFE65100),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    // Outstanding Summary Card at Bottom matching Figure 5
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Card Header
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.receipt_long,
                                  size: 18,
                                  color: Color(0xFF1976D2),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Outstanding Summary',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Content Rows
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Number of unpaid bills',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    Text(
                                      '${_unpaidBills.length}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF263238),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total Outstanding',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF263238),
                                      ),
                                    ),
                                    Text(
                                      Formatters.formatVND(_totalOutstanding),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE65100),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
