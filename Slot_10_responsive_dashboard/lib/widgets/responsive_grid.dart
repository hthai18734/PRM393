import 'package:flutter/material.dart';
class ResponsiveProductGrid extends StatelessWidget {
  const ResponsiveProductGrid({super.key});
  @override Widget build(BuildContext context) => LayoutBuilder(builder: (_, constraints) {
    final width = constraints.maxWidth;
    final columns = width < 450 ? 2 : width < 800 ? 3 : 4;
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, crossAxisSpacing: 12, mainAxisSpacing: 12,
        childAspectRatio: width < 450 ? 1.1 : 1.5),
      itemCount: 12, itemBuilder: (_, index) => Card(child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.apps_rounded, color: Colors.teal), const SizedBox(height: 5),
          Text('Item ${index + 1}', overflow: TextOverflow.ellipsis),
        ]))));
  });
}
