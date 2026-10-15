import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/student_store.dart';
import 'student_form_screen.dart';
class StudentDetailScreen extends StatefulWidget {
  final String studentId;
  const StudentDetailScreen({super.key, required this.studentId});
  @override State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}
class _StudentDetailScreenState extends State<StudentDetailScreen> {
  Future<void> _edit(Student student) async {
    final edited = await Navigator.push<Student>(context,
      MaterialPageRoute(builder: (_) => StudentFormScreen(student: student)));
    if (edited != null) setState(() => StudentStore.instance.save(edited));
  }
  @override Widget build(BuildContext context) {
    final student = StudentStore.instance.find(widget.studentId);
    return Scaffold(appBar: AppBar(title: const Text('Chi tiết sinh viên')),
      body: student == null ? const Center(child: Text('Không tìm thấy sinh viên')) :
        Padding(padding: const EdgeInsets.all(24), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(student.name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16), Text('Mã sinh viên: ${student.id}'),
          Text('Tuổi: ${student.age}'), const SizedBox(height: 20),
          FilledButton.icon(onPressed: () => _edit(student),
            icon: const Icon(Icons.edit), label: const Text('Chỉnh sửa')),
        ])));
  }
}
