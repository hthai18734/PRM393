import 'package:flutter/material.dart';
class SuccessScreen extends StatelessWidget {
  final String name;
  const SuccessScreen({super.key, required this.name});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Thành công')),
    body: Center(child: Padding(padding: const EdgeInsets.all(24), child:
      Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 80),
        const SizedBox(height: 16),
        Text('Đăng ký thành công!', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8), Text('Chào mừng $name'),
        const SizedBox(height: 20), FilledButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
          child: const Text('Về màn hình đăng ký')),
      ]))));
}
