// ============================================================
// EXERCISE - DỰ ÁN THỰC HÀNH 1
// Function Processor – Xử lý dữ liệu bằng Dart Function
// ============================================================

// 4️⃣ PHẦN 1 – FUNCTION LÀ “HỘP XỬ LÝ” (INPUT → OUTPUT)
int calculateTotal(int a, int b) {
  int total = a + b;
  return total;
}

// 5️⃣ PHẦN 2 – FUNCTION ≠ UI (Chỉ xử lý logic, không tự print)
double calculateAverage(int a, int b) {
  return (a + b) / 2;
}

// 6️⃣ PHẦN 3 – CALLBACK: FUNCTION LÀ DỮ LIỆU
// Bước 1: Function nhận callback
void processNumber(int number, Function(int) callback) {
  callback(number);
}

// Bước 2: Function dùng làm callback
void printNumber(int value) {
  print("Value is: $value");
}

// 7️⃣ PHẦN 4 – ANONYMOUS FUNCTION (ĐỂ ĐỌC CODE FLUTTER)
void process(int number, Function(int) callback) {
  callback(number);
}

void main() {
  // --- Kiểm tra Phần 1: Input -> Process -> Output ---
  int result = calculateTotal(5, 7);
  print(result); // Kết quả mong đợi: 12

  // --- Kiểm tra Phần 2: Function ≠ UI ---
  double avg = calculateAverage(6, 8);
  print("Average: $avg"); // Kết quả mong đợi: Average: 7.0

  // --- Kiểm tra Phần 3: Callback Function ---
  processNumber(10, printNumber); // Kết quả mong đợi: Value is: 10

  // --- Kiểm tra Phần 4: Anonymous Function ---
  process(5, (value) {
    print("Anonymous value: $value"); // Kết quả mong đợi: Anonymous value: 5
  });
}
