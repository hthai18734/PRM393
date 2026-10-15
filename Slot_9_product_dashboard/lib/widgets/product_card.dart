import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final int index;
  const ProductCard({super.key, required this.index});
  @override Widget build(BuildContext context) => Card(clipBehavior: Clip.antiAlias,
    child: InkWell(onTap: () => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn sản phẩm ${index + 1}'))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(child: Stack(children: [
          Positioned.fill(child: ColoredBox(color: Colors.blue.shade50,
            child: const Icon(Icons.inventory_2_outlined, size: 58, color: Colors.blue))),
          if (index % 3 == 0) Positioned(top: 8, left: 8,
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.red, child: const Text('SALE', style: TextStyle(color: Colors.white)))),
        ])),
        Padding(padding: const EdgeInsets.all(10), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Sản phẩm ${index + 1}', maxLines: 1, overflow: TextOverflow.ellipsis),
            Text('${(index + 1) * 50}.000 đ', style: const TextStyle(fontWeight: FontWeight.bold)),
          ])),
      ])));
}
