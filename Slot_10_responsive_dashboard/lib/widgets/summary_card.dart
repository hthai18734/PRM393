import 'package:flutter/material.dart';
class SummaryCard extends StatelessWidget {
  final String title, value;
  final Color color;
  final IconData icon;
  const SummaryCard({super.key, required this.title, required this.value,
    required this.color, required this.icon});
  @override Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(18), child: Row(children: [
      CircleAvatar(backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(icon, color: color)),
      const SizedBox(width: 12), Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
        children: [Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
            child: Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)))],
      )),
    ])));
}
