import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
void main() => runApp(const SmartRegistrationApp());
class SmartRegistrationApp extends StatelessWidget {
  const SmartRegistrationApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Smart Registration', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    routes: {'/': (_) => const RegisterScreen()}, initialRoute: '/');
}
