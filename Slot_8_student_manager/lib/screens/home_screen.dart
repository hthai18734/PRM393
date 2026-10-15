import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student Manager - Home')),
    body: Center(child: FilledButton.icon(icon: const Icon(Icons.people),
      onPressed: () => Navigator.pushNamed(context, AppRoutes.studentList),
      label: const Text('Xem danh sách sinh viên'))),
  );
}
