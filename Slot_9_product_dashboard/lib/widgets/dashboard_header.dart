import 'package:flutter/material.dart';
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16), child: Row(children: [
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Xin chào!', style: TextStyle(fontSize: 16)),
        Text('Product Dashboard', maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      ])),
      Stack(clipBehavior: Clip.none, children: [
        const Icon(Icons.notifications_outlined, size: 32),
        Positioned(top: 0, right: 0, child: Container(width: 10, height: 10,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red))),
      ]),
    ]));
}
