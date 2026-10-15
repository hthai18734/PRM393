import 'package:flutter/material.dart';
import 'models/student.dart';
import 'routes/app_routes.dart';
import 'screens/home_screen.dart';
import 'screens/student_list_screen.dart';
import 'screens/student_detail_screen.dart';
void main() => runApp(const StudentManagerApp());
class StudentManagerApp extends StatelessWidget {
  const StudentManagerApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Student Manager', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    initialRoute: AppRoutes.home,
    onGenerateRoute: (settings) {
      final rawName = settings.name ?? '/';
      final uri = Uri.tryParse(rawName);
      if (rawName == AppRoutes.home) return MaterialPageRoute(settings: settings, builder: (_) => const HomeScreen());
      if (rawName == AppRoutes.studentList) return MaterialPageRoute(settings: settings, builder: (_) => const StudentListScreen());
      // Also supports android scheme: studentmanager://students/S001
      final deepId = uri != null && uri.scheme == 'studentmanager' && uri.host == 'students' && uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      final pathId = uri != null && uri.pathSegments.length == 2 && uri.pathSegments.first == 'students' ? uri.pathSegments.last : null;
      if (rawName == AppRoutes.studentDetail || deepId != null || pathId != null) {
        final arg = settings.arguments;
        final id = arg is Student ? arg.id : (arg is String ? arg : deepId ?? pathId);
        return MaterialPageRoute(settings: settings, builder: (_) => id == null
          ? const Scaffold(body: Center(child: Text('Thiếu mã sinh viên')))
          : StudentDetailScreen(studentId: id));
      }
      return MaterialPageRoute(settings: settings, builder: (_) => const Scaffold(body: Center(child: Text('Route không tồn tại'))));
    },
  );
}
