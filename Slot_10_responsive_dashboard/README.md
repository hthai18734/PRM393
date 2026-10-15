# Slot 10 - Responsive Dashboard App

Bài tập tổng hợp của Slot 10 Responsive Dashboard.

## Chạy dự án
1. Cài Flutter SDK stable, Android Studio / VS Code.
2. Trong thư mục dự án: `flutter create . --platforms=android,ios` (lệnh này tạo platform files còn thiếu, không ghi đè lib hiện tại).
3. `flutter pub get` rồi `flutter run`.

Không sử dụng thư viện bên ngoài.

## Kiểm thử Responsive
- Mobile 360 px: summary cards xếp dọc, Grid 2 cột.
- Tablet 700 px: summary cards nằm ngang, Grid 3 cột.
- Desktop 1100 px: Grid 4 cột.
- Không đặt chiều rộng cố định cho card. MediaQuery dùng cho padding/font, LayoutBuilder dùng cho thay đổi bố cục.
