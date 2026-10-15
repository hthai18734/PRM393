import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
class ProductGridScreen extends StatelessWidget {
  const ProductGridScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Danh sách sản phẩm')),
    body: LayoutBuilder(builder: (_, constraints) => GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth < 550 ? 2 : 4,
        childAspectRatio: 0.78, mainAxisSpacing: 12, crossAxisSpacing: 12),
      itemCount: 24, itemBuilder: (_, index) => ProductCard(index: index))));
}
