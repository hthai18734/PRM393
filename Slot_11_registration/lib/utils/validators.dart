class Validators {
  static String? requiredField(String? text) => text == null || text.trim().isEmpty
      ? 'Vui lòng nhập thông tin' : null;
  static String? email(String? text) {
    if (text == null || text.trim().isEmpty) return 'Vui lòng nhập email';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(text.trim())) return 'Email không hợp lệ';
    return null;
  }
  static String? password(String? text) => text == null || text.length < 6
      ? 'Mật khẩu phải có ít nhất 6 ký tự' : null;
}
