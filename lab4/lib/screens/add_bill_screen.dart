import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/bill.dart';
import '../utils/formatters.dart';
import '../widgets/custom_dialogs.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({super.key});

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _billNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dueDateController = TextEditingController();

  String? _selectedCategory;
  final String _status = 'Unpaid'; // Note: status defaults to "Unpaid"

  @override
  void initState() {
    super.initState();
    // Default due date to today or leave empty with prompt
    _dueDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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

  Future<void> _handleSave() async {
    final billName = _billNameController.text.trim();
    if (billName.isEmpty) {
      await CustomDialogs.showValidationDialog(context, 'Please enter bill name');
      return;
    }

    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      await CustomDialogs.showValidationDialog(context, 'Please select a category');
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

    // Insert bill into SQLite
    final newBill = Bill(
      billName: billName,
      category: _selectedCategory!,
      amount: amount,
      status: _status,
      dueDate: dueDate,
    );

    await DatabaseHelper.instance.insertBill(newBill);

    if (!mounted) return;

    // Show success dialog and navigate back
    await CustomDialogs.showSuccessDialog(
      context,
      'Bill added successfully',
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
        title: const Text('Add Bill'),
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
                      hintText: 'e.g. Electricity - September',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
                      hintText: 'Select category',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
                      setState(() {
                        _selectedCategory = value;
                      });
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
                      hintText: 'e.g. 850000',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
                      hintText: 'e.g. 2025-10-30',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: _status,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Action Buttons: Save & Back
                  Row(
                    children: [
                      // Save Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _handleSave,
                          icon: const Icon(Icons.check, size: 18),
                          label: const Text('Save'),
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
                      const SizedBox(width: 12),
                      // Back Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, size: 18),
                          label: const Text('Back'),
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
