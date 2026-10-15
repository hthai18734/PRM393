import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/product_grid_screen.dart';
void main() => runApp(const ProductDashboardApp());
class ProductDashboardApp extends StatelessWidget {
  const ProductDashboardApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Simple Product Dashboard', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    initialRoute: '/', routes: {
      '/': (_) => const DashboardScreen(),
      '/products': (_) => const ProductGridScreen(),
    },
  );
}
