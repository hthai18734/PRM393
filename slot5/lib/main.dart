import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/stream_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Bước 2: Tạo StreamService bên ngoài UI (Data Source / Logic Layer)
  final streamService = StreamService();

  // Bước 3: Kiểm tra Stream bằng listen (Chứng minh Stream chạy độc lập với UI)
  streamService.stream.listen((value) {
    debugPrint('Stream emits (listen in main): $value');
  });

  runApp(MyApp(streamService: streamService));
}

class MyApp extends StatelessWidget {
  final StreamService streamService;

  const MyApp({super.key, required this.streamService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Counter Stream App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(service: streamService),
    );
  }
}
