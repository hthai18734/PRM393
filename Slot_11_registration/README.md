# Slot 11 - Smart Registration App

Bài tập tổng hợp của Slot 11 Registration.

## Chạy dự án
1. Cài Flutter SDK stable, Android Studio / VS Code.
2. Trong thư mục dự án: `flutter create . --platforms=android,ios` (lệnh này tạo platform files còn thiếu, không ghi đè lib hiện tại).
3. `flutter pub get` rồi `flutter run`.

Không sử dụng thư viện bên ngoài.

## Kiểm tra
1. Bỏ trống form: tất cả ô bắt buộc báo lỗi.
2. Email không đúng định dạng: báo lỗi.
3. Mật khẩu dưới 6 ký tự: báo lỗi.
4. Xác nhận khác mật khẩu: báo lỗi.
5. `test@error.com`: loading 2 giây rồi SnackBar lỗi.
6. Email hợp lệ khác: loading rồi vào Success. Nút bị khóa khi loading để tránh gửi trùng.
