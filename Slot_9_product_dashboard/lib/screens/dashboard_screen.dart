import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Dashboard')),
    body: Column(children: [
      const DashboardHeader(),
      Expanded(child: Center(child: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(20), child: Column(children: [
          Icon(Icons.dashboard_customize_rounded, color: Theme.of(context).colorScheme.primary, size: 88),
          const SizedBox(height: 16), const Text('Quản lý sản phẩm dễ dàng',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _Stat(label: 'Sản phẩm', value: '24')),
            const SizedBox(width: 12),
            Expanded(child: _Stat(label: 'Đơn hàng', value: '120')),
          ]),
          const SizedBox(height: 24),
          FilledButton.icon(onPressed: () => Navigator.pushNamed(context, '/products'),
            icon: const Icon(Icons.grid_view), label: const Text('Xem sản phẩm')),
        ]))))),
    ]));
}
class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat({required this.label, required this.value});
  @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(18),
    child: Column(children: [Text(value, style: Theme.of(context).textTheme.headlineMedium), Text(label)])));
}
