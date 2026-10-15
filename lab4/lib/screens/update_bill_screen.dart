import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/bill.dart';
import '../utils/formatters.dart';
import '../widgets/custom_dialogs.dart';

class UpdateBillScreen extends StatefulWidget {
  final Bill bill;

  const UpdateBillScreen({super.key, required this.bill});

  @override
  State<UpdateBillScreen> createState() => _UpdateBillScreenState();
}

class _UpdateBillScreenState extends State<UpdateBillScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _billNameController;
  late TextEditingController _amountController;
  late TextEditingController _dueDateController;

  late String _selectedCategory;
  late String _selectedStatus;

  final List<String> _statusOptions = ['Unpaid', 'Paid'];

  @override
  void initState() {
    super.initState();
    _billNameController = TextEditingController(text: widget.bill.billName);
    // Display amount without unnecessary decimal point if integer
    final amount = widget.bill.amount;
    _amountController = TextEditingController(
      text: amount % 1 == 0 ? amount.toInt().toString() : amount.toString(),
    );
    _dueDateController = TextEditingController(text: widget.bill.dueDate);
    _selectedCategory = widget.bill.category;
    _selectedStatus = widget.bill.status;
  }

  @override
  void dispose() {
    _billNameController.dispose();
    _amountController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    DateTime initialDate = DateTime.now();
    try {
      if (_dueDateController.text.isNotEmpty) {
        initialDate = DateTime.parse(_dueDateController.text);
      }
    } catch (_) {
      initialDate = DateTime.now();
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF673AB7),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _handleUpdate() async {
    final billName = _billNameController.text.trim();
    if (billName.isEmpty) {
      await CustomDialogs.showValidationDialog(context, 'Please enter bill name');
      return;
    }

    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);
    if (amountText.isEmpty || amount == null || amount <= 0) {
      await CustomDialogs.showValidationDialog(context, 'Please enter a valid amount');
      return;
    }

    final dueDate = _dueDateController.text.trim();
    if (dueDate.isEmpty) {
      await CustomDialogs.showValidationDialog(context, 'Please enter due date');
      return;
    }

    // Update bill in SQLite
    final updatedBill = widget.bill.copyWith(
      billName: billName,
      category: _selectedCategory,
      amount: amount,
      status: _selectedStatus,
      dueDate: dueDate,
    );

    await DatabaseHelper.instance.updateBill(updatedBill);

    if (!mounted) return;

    // Show success dialog and navigate back
    await CustomDialogs.showSuccessDialog(
      context,
      'Bill updated successfully',
      onOk: () {
        Navigator.pop(context, true);
      },
    );
  }

  Future<void> _handleDelete() async {
    // Show confirm delete dialog
    final confirmed = await CustomDialogs.showConfirmDeleteDialog(context);
    if (!confirmed) return;

    if (widget.bill.id != null) {
      await DatabaseHelper.instance.deleteBill(widget.bill.id!);
    }

    if (!mounted) return;

    // Show success dialog
    await CustomDialogs.showSuccessDialog(
      context,
      'Bill deleted',
      onOk: () {
        Navigator.pop(context, true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Update Bill'),
        backgroundColor: const Color(0xFF673AB7),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bill Name
                  const Text(
                    'Bill Name *',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _billNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF673AB7), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Category
                  const Text(
                    'Category *',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF673AB7), width: 1.5),
                      ),
                    ),
                    items: Formatters.categories.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat,
                        child: Row(
                          children: [
                            Icon(Formatters.getCategoryIcon(cat),
                                color: Formatters.getCategoryColor(cat), size: 18),
                            const SizedBox(width: 8),
                            Text(cat),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 18),

                  // Amount (VND)
                  const Text(
                    'Amount (VND) *',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF673AB7), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Due Date (YYYY-MM-DD)
                  const Text(
                    'Due Date (YYYY-MM-DD) *',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _dueDateController,
                    readOnly: true,
                    onTap: _pickDueDate,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month, color: Color(0xFF673AB7)),
                        onPressed: _pickDueDate,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF673AB7), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Status
                  const Text(
                    'Status *',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedStatus,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF673AB7), width: 1.5),
                      ),
                    ),
                    items: _statusOptions.map((st) {
                      return DropdownMenuItem<String>(
                        value: st,
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: st == 'Paid'
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFFF9800),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(st),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 28),

                  // Three buttons on the same row: Update, Delete, Back (matching Figure 4)
                  Row(
                    children: [
                      // Update Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _handleUpdate,
                          icon: const Icon(Icons.check, size: 16),
                          label: const Text(
                            'Update',
                            style: TextStyle(fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Delete Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _handleDelete,
                          icon: const Icon(Icons.delete_outline, size: 16),
                          label: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Back Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, size: 16),
                          label: const Text(
                            'Back',
                            style: TextStyle(fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF757575),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
