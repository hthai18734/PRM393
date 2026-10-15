# Slot 9 - Simple Product Dashboard App

Bài tập tổng hợp của Slot 9 Product Dashboard.

## Chạy dự án
1. Cài Flutter SDK stable, Android Studio / VS Code.
2. Trong thư mục dự án: `flutter create . --platforms=android,ios` (lệnh này tạo platform files còn thiếu, không ghi đè lib hiện tại).
3. `flutter pub get` rồi `flutter run`.

Không sử dụng thư viện bên ngoài.

## iOS URL Scheme (kiến thức định hướng theo đề)
Ví dụ `myapp://products`: hệ điều hành nhận URL Scheme, mở ứng dụng, router chuyển đến `/products`. Phần iOS URL Scheme trong bài tập chỉ yêu cầu giải thích, không bắt buộc cấu hình native.
