import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/student_store.dart';
import '../routes/app_routes.dart';
import '../widgets/student_tile.dart';
import 'student_form_screen.dart';
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});
  @override State<StudentListScreen> createState() => _StudentListScreenState();
}
class _StudentListScreenState extends State<StudentListScreen> {
  Future<void> _form([Student? original]) async {
    final result = await Navigator.push<Student>(context,
      MaterialPageRoute(builder: (_) => StudentFormScreen(student: original)));
    if (result != null) setState(() => StudentStore.instance.save(result));
  }
  @override Widget build(BuildContext context) {
    final students = StudentStore.instance.students;
    return Scaffold(appBar: AppBar(title: const Text('Danh sách sinh viên')),
      body: ListView.builder(padding: const EdgeInsets.all(12), itemCount: students.length,
        itemBuilder: (_, i) => StudentTile(student: students[i], onTap: () async {
          await Navigator.pushNamed(context, AppRoutes.studentDetail, arguments: students[i]);
          if (mounted) setState(() {});
        })),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _form(),
        icon: const Icon(Icons.add), label: const Text('Thêm sinh viên')));
  }
}
