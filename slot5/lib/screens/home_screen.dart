import 'package:flutter/material.dart';
import '../services/stream_service.dart';

/// Màn hình HomeScreen - Minh họa UI Reactive với StreamBuilder
/// Tuân thủ quy tắc:
/// - UI KHÔNG tính toán counter++
/// - UI KHÔNG gọi setState để cập nhật số
/// - UI CHỈ lắng nghe Stream thông qua StreamBuilder và phản ứng (render)
class HomeScreen extends StatefulWidget {
  final StreamService service;

  const HomeScreen({super.key, required this.service});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Bắt đầu Stream khi màn hình được khởi tạo
    widget.service.start();
  }

  @override
  void dispose() {
    // Bước 8: Đóng Stream khi Widget bị hủy để tránh Memory Leak
    widget.service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Counter Stream App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thông tin định hướng kiến trúc Reactive
              Card(
                elevation: 2,
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'REACTIVE THINKING (SLOT 5)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Luồng chuẩn: StreamService (Phát data) ➔ StreamBuilder (Lắng nghe) ➔ UI tự Rebuild (Không setState)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Vùng hiển thị dữ liệu Reactive thông qua StreamBuilder
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: StreamBuilder<int>(
                  stream: widget.service.stream,
                  builder: (context, snapshot) {
                    // Bước 6: Quan sát UI Rebuild trên console
                    debugPrint('UI rebuild: ${snapshot.data} | State: ${snapshot.connectionState}');

                    // 1. Trạng thái Loading / Chờ dữ liệu đầu tiên
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Đang kết nối Stream...',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      );
                    }

                    // 2. Trạng thái Error (Mô phỏng lỗi từ Stream)
                    if (snapshot.hasError) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 52),
                          const SizedBox(height: 12),
                          Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }

                    // 3. Trạng thái Chưa có dữ liệu
                    if (!snapshot.hasData) {
                      return const Text(
                        'No data',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      );
                    }

                    // 4. Trạng thái Có dữ liệu hợp lệ (hasData)
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'REALTIME COUNTER',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Counter: ${snapshot.data}',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Chip(
                          avatar: const Icon(Icons.check_circle, size: 18, color: Colors.green),
                          label: Text(
                            'ConnectionState: ${snapshot.connectionState.name}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: Colors.green.shade50,
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 36),

              // Bảng điều khiển kiểm thử & bài tập mở rộng
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Bảng điều khiển kiểm thử Stream:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.pause),
                            label: const Text('Pause Stream'),
                            onPressed: () => widget.service.pause(),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Resume Stream'),
                            onPressed: () => widget.service.resume(),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.bug_report, color: Colors.orange),
                            label: const Text('Mô phỏng Error'),
                            onPressed: () => widget.service.emitError(),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset Counter'),
                            onPressed: () => widget.service.reset(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

