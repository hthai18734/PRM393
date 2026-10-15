# Slot 5 - Live Counter Stream App (Exercise 2)

## 📌 Tổng quan dự án
Ứng dụng Flutter mô phỏng dữ liệu thay đổi liên tục theo thời gian (realtime counter) sử dụng **Stream** và **StreamBuilder** theo tư duy **Reactive UI** (Slot 5).

- **Không sử dụng `setState()`** để điều khiển số tăng dần.
- Dữ liệu được phát ra từ `StreamService` (Data Source / Logic Layer).
- `HomeScreen` (UI Layer) chỉ đóng vai trò lắng nghe qua `StreamBuilder` và tự động cập nhật khi có `snapshot` mới.

---

## 🏗️ Cấu trúc thư mục
```
lib/
├── main.dart                          # Khởi tạo StreamService, kiểm tra listen độc lập & chạy app
├── services/
│   └── stream_service.dart            # Quản lý StreamController, emit dữ liệu & dispose
└── screens/
    └── home_screen.dart               # UI Reactive thuần túy với StreamBuilder
```

---

## 🎯 Các chức năng chính
1. **Counter Realtime**: Tự động tăng giá trị mỗi 1 giây qua `StreamController`.
2. **UI Reactive**: Tự động vẽ lại (rebuild) theo các trạng thái của `AsyncSnapshot`:
   - `ConnectionState.waiting`: Hiển thị loading indicator.
   - `snapshot.hasError`: Hiển thị thông báo lỗi.
   - `snapshot.hasData`: Hiển thị giá trị counter thời gian thực.
3. **Các tính năng mở rộng**:
   - Tạm dừng (`Pause Stream`) / Tiếp tục (`Resume Stream`).
   - Mô phỏng lỗi Stream (`Mô phỏng Error`).
   - Đặt lại giá trị (`Reset Counter`).
4. **Lifecycle & Quản lý bộ nhớ**: Hủy `Timer` và gọi `_controller.close()` khi `dispose` để tránh memory leak.