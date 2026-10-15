import 'package:flutter/material.dart';
import '../models/student.dart';
class StudentTile extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;
  const StudentTile({super.key, required this.student, required this.onTap});
  @override Widget build(BuildContext context) => Card(child: ListTile(
    leading: CircleAvatar(child: Text(student.name.characters.first)),
    title: Text(student.name), subtitle: Text('ID: ${student.id} | Tuổi: ${student.age}'),
    trailing: const Icon(Icons.chevron_right), onTap: onTap,
  ));
}
