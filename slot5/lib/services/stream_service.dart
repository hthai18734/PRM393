import 'dart:async';
import 'package:flutter/foundation.dart';

/// Service quản lý và phát dữ liệu Stream cho ứng dụng.
/// Tuân thủ nguyên tắc:
/// - UI KHÔNG tạo Stream
/// - UI KHÔNG xử lý logic đếm dữ liệu
/// - StreamService là nguồn phát (Data Source / Logic Layer)
class StreamService {
  // Sử dụng broadcast controller để hỗ trợ nhiều listener (debug listen & StreamBuilder)
  final StreamController<int> _controller = StreamController<int>.broadcast();
  int _counter = 0;
  Timer? _timer;
  bool _isRunning = false;

  /// Expose Stream ra ngoài cho UI lắng nghe (UI chỉ đọc stream)
  Stream<int> get stream => _controller.stream;

  /// Getter trạng thái chạy của stream
  bool get isRunning => _isRunning;

  /// Getter giá trị hiện tại của counter
  int get currentCount => _counter;

  /// Bắt đầu phát dữ liệu mỗi 1 giây
  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _counter++;
      debugPrint('Stream emits: $_counter');
      if (!_controller.isClosed) {
        _controller.add(_counter);
      }
    });
  }

  /// Tạm dừng phát dữ liệu (Bài tập mở rộng)
  void pause() {
    _timer?.cancel();
    _isRunning = false;
    debugPrint('Stream paused at: $_counter');
  }

  /// Tiếp tục phát dữ liệu (Bài tập mở rộng)
  void resume() {
    if (!_isRunning) {
      start();
    }
  }

  /// Mô phỏng lỗi từ Stream để UI hiển thị hasError
  void emitError() {
    if (!_controller.isClosed) {
      debugPrint('Stream emitting simulated error');
      _controller.addError('Lỗi mô phỏng từ Stream (Simulated Stream Error)!');
    }
  }

  /// Reset counter về 0 và phát dữ liệu mới
  void reset() {
    _counter = 0;
    if (!_controller.isClosed) {
      _controller.add(_counter);
    }
  }

  /// Đóng StreamController & hủy Timer để tránh memory leak
  void dispose() {
    _timer?.cancel();
    _controller.close();
    debugPrint('StreamService disposed');
  }
}

