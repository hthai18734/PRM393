import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
void main() => runApp(const ResponsiveApp());
class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Responsive Dashboard', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const DashboardScreen());
}
