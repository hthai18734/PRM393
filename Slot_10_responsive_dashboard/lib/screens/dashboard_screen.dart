import 'package:flutter/material.dart';
import '../widgets/summary_card.dart';
import '../widgets/responsive_grid.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final gap = (size.width * 0.04).clamp(12.0, 32.0);
    final fontSize = (size.width * 0.06).clamp(22.0, 32.0);
    return Scaffold(appBar: AppBar(title: const Text('Responsive Dashboard')),
      body: SingleChildScrollView(child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(padding: EdgeInsets.all(gap), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Expanded(child: Text('Dashboard', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: fontSize))),
              const Icon(Icons.notifications_none)]),
            const SizedBox(height: 20),
            const _SummarySection(),
            const SizedBox(height: 24),
            Text('Danh sách item', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12), const ResponsiveProductGrid(),
          ]))))));
  }
}
class _SummarySection extends StatelessWidget {
  const _SummarySection();
  @override Widget build(BuildContext context) => LayoutBuilder(builder: (_, constraints) {
    final cards = [
      const SummaryCard(title: 'Revenue', value: '\$12,300', icon: Icons.payments, color: Colors.blue),
      const SummaryCard(title: 'Orders', value: '320', icon: Icons.shopping_cart, color: Colors.green),
      const SummaryCard(title: 'Customers', value: '89', icon: Icons.people, color: Colors.purple),
    ];
    if (constraints.maxWidth < 600) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [for (final c in cards) Padding(padding: const EdgeInsets.only(bottom: 12), child: c)]);
    }
    return Row(children: [for (var i = 0; i < cards.length; i++) ...[
      if (i > 0) const SizedBox(width: 12), Expanded(child: cards[i]),
    ]]);
  });
}
