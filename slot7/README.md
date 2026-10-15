# PRM393 - Slot 7: Simple Planner App (Bài tập tổng hợp 1)

Ứng dụng Flutter đa màn hình quản lý kế hoạch đơn giản, kết hợp:
- **Pickers (Date & Time)**: `showDatePicker` và `showTimePicker` với xử lý `async/await` và kiểm tra `null`.
- **Theming & UI Polishing**: Khai báo `ThemeData` tập trung với `ColorScheme.fromSeed`, chuẩn hoá `AppBarTheme` và `InputDecorationTheme`.
- **Navigator 1.0**: Điều hướng luồng chuẩn `Navigator.push` và `Navigator.pop(context, result)` truyền nhận dữ liệu giữa màn hình Home và Create Plan.

## Cấu trúc thư mục dự án
- `lib/main.dart`: Điểm khởi chạy app, áp dụng theme toàn app vào `MaterialApp`.
- `lib/theme/app_theme.dart`: Định nghĩa `AppTheme.lightTheme`.
- `lib/models/plan.dart`: Model dữ liệu `Plan` (tiêu đề, ngày, giờ).
- `lib/widgets/primary_button.dart`: Widget nút bấm tùy chỉnh tái sử dụng.
- `lib/screens/home_screen.dart`: Màn hình danh sách kế hoạch + nút tạo mới.
- `lib/screens/create_plan_screen.dart`: Màn hình form nhập tiêu đề, chọn ngày/giờ và lưu kế hoạch.
