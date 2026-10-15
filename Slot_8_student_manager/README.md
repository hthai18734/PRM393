# Slot 8 - Student Manager App

Bài tập tổng hợp của Slot 8 Student Manager.

## Chạy dự án
1. Cài Flutter SDK stable, Android Studio / VS Code.
2. Trong thư mục dự án: `flutter create . --platforms=android,ios` (lệnh này tạo platform files còn thiếu, không ghi đè lib hiện tại).
3. `flutter pub get` rồi `flutter run`.

Không sử dụng thư viện bên ngoài.

## Android deep link
Chèn `ANDROID_DEEP_LINK_MANIFEST_SNIPPET.xml` vào MainActivity AndroidManifest.xml. Thử trên Android: `adb shell am start -a android.intent.action.VIEW -d "studentmanager://students/S001"`. Với Flutter phiên bản mới, cấu hình deep linking mặc định có thể cần kiểm tra. Dữ liệu đang lưu in-memory, khởi động lại sẽ reset. Navigator 2.0 là phần khái niệm trong đề, không bắt buộc triển khai RouterDelegate.
