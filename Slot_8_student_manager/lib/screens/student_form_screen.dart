import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/student_store.dart';
class StudentFormScreen extends StatefulWidget {
  final Student? student;
  const StudentFormScreen({super.key, this.student});
  @override State<StudentFormScreen> createState() => _StudentFormScreenState();
}
class _StudentFormScreenState extends State<StudentFormScreen> {
  final keyForm = GlobalKey<FormState>();
  late final TextEditingController id;
  late final TextEditingController name;
  late final TextEditingController age;
  @override void initState() { super.initState();
    id = TextEditingController(text: widget.student?.id ?? '');
    name = TextEditingController(text: widget.student?.name ?? '');
    age = TextEditingController(text: widget.student?.age.toString() ?? '');
  }
  @override void dispose() {id.dispose(); name.dispose(); age.dispose(); super.dispose();}
  void save() {
    if (!keyForm.currentState!.validate()) return;
    Navigator.pop(context, Student(id: id.text.trim(), name: name.text.trim(), age: int.parse(age.text)));
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.student == null ? 'Thêm sinh viên' : 'Sửa sinh viên')),
    body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(20), child:
      Form(key: keyForm, child: Column(children: [
        TextFormField(controller: id, readOnly: widget.student != null,
          decoration: const InputDecoration(labelText: 'Mã sinh viên'),
          validator: (v) {if (v == null || v.trim().isEmpty) return 'Nhập mã sinh viên';
            if (widget.student == null && StudentStore.instance.find(v.trim()) != null) return 'Mã đã tồn tại'; return null;}),
        TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Họ tên'),
          validator: (v) => v == null || v.trim().isEmpty ? 'Nhập họ tên' : null),
        TextFormField(controller: age, keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Tuổi'),
          validator: (v) { final n = int.tryParse(v ?? ''); return n == null || n < 1 || n > 120 ? 'Tuổi không hợp lệ' : null; }),
        const SizedBox(height: 20), FilledButton(onPressed: save, child: const Text('Lưu')),
      ])))));
}
