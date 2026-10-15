# PRM393 - Mobile Programming (Flutter)

Kho lưu trữ tổng hợp các bài thực hành Slots và Labs môn **PRM393**.

##  Danh sách bài tập & Cấu trúc thư mục

| Thư mục | Tên bài / Chủ đề | Mô tả chi tiết |
|---|---|---|
| [`slot2/`](./slot2) | **Slot 2 - Exercise 1** | *My Daily Planner App* - Ứng dụng quản lý kế hoạch hàng ngày |
| [`slot3/`](./slot3) | **Slot 3 - Exercise 1** | *Function Processor* - Xử lý hàm và logic Dart |
| [`slot4/`](./slot4) | **Slot 4 - Exercise 1** | *Async Product Loader* - Tải danh sách sản phẩm bất đồng bộ (`Future`, `async/await`) |
| [`slot5/`](./slot5) | **Slot 5 - Exercise 2** | *Live Counter Stream App* - Bộ đếm thời gian thực sử dụng `Stream` & `StreamBuilder` (Reactive UI) |
| [`slot6/`](./slot6) | **Slot 6** | *Student List Interaction App* - Danh sách sinh viên với `ListView.builder`, `Card` & `ListTile` |
| [`slot7/`](./slot7) | **Slot 7 - Exercise 1** | *Simple Planner App* - User Interaction (Pickers Date/Time), Theming & Navigation 1.0 (Push/Pop) |
| [`lab4/`](./lab4) | **Lab 4** | *Manage Recurring Bills App* - Quản lý hóa đơn định kỳ lưu trữ bằng SQLite (`sqflite`) |

## Hướng dẫn chạy từng bài

Mỗi thư mục là một dự án Flutter hoàn chỉnh và độc lập. Để chạy bất kỳ bài nào:

1. Di chuyển vào thư mục bài tập tương ứng:
   ```bash
   cd slot2    # hoặc slot3, slot4, slot5, slot6, slot7, lab4
   ```

2. Cài đặt các gói phụ thuộc:
   ```bash
   flutter pub get
   ```

3. Chạy ứng dụng:
   ```bash
   # Chạy trên thiết bị mặc định hoặc giả lập đã mở
   flutter run

   # Hoặc chạy trên Windows Desktop
   flutter run -d windows
   ```
