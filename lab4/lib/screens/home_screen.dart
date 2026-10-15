import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/bill.dart';
import '../utils/formatters.dart';
import 'add_bill_screen.dart';
import 'update_bill_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onDataChanged;

  const HomeScreen({super.key, this.onDataChanged});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Bill> _bills = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBills();
  }

  Future<void> loadBills() async {
    setState(() {
      _isLoading = true;
    });
    final bills = await DatabaseHelper.instance.getAllBills();
    if (mounted) {
      setState(() {
        _bills = bills;
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToAddBill() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddBillScreen()),
    );
    if (result == true) {
      loadBills();
      widget.onDataChanged?.call();
    }
  }

  Future<void> _navigateToUpdateBill(Bill bill) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateBillScreen(bill: bill)),
    );
    if (result == true) {
      loadBills();
      widget.onDataChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Banner Image as requested in Requirement 1 & Figure 1
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/banner.jpg',
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Graceful fallback if image has issue
                    return Container(
                      height: 110,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF5E35B1), Color(0xFF3949AB)],
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        children: [
                          Icon(Icons.receipt_long, color: Colors.white, size: 40),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'RECURRING BILLS MANAGER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Track and automate your monthly payments',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Header Section: Title & Total Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recurring Bills',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF673AB7).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_bills.length} bills',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF673AB7),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bills List / Empty State
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _bills.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: loadBills,
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
                            itemCount: _bills.length,
                            itemBuilder: (context, index) {
                              final bill = _bills[index];
                              return _buildBillCard(bill);
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF673AB7),
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: _navigateToAddBill,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  // Empty State matching Figure 1
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No bills yet!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Press '+' button to add your recurring bills",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Bill Card item matching Figure 1
  Widget _buildBillCard(Bill bill) {
    final isPaid = bill.status.toLowerCase() == 'paid';
    final categoryColor = Formatters.getCategoryColor(bill.category);
    final categoryIcon = Formatters.getCategoryIcon(bill.category);

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToUpdateBill(bill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Category Icon Circle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(categoryIcon, color: categoryColor, size: 22),
              ),
              const SizedBox(width: 14),

              // Title, Due Date, Category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.billName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF263238),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 13,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          bill.dueDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            bill.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Amount and Status Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Formatters.formatVND(bill.amount),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPaid ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isPaid ? const Color(0xFF4CAF50) : const Color(0xFFFF9800),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      bill.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isPaid ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
