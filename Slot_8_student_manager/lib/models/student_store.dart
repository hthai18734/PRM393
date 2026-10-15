import 'student.dart';
class StudentStore {
  StudentStore._();
  static final StudentStore instance = StudentStore._();
  final students = <Student>[
    const Student(id: 'S001', name: 'Nguyễn Văn A', age: 20),
    const Student(id: 'S002', name: 'Trần Thị B', age: 21),
    const Student(id: 'S003', name: 'Lê Văn C', age: 19),
  ];
  Student? find(String id) { for (final s in students) { if (s.id == id) return s; } return null; }
  void save(Student student) {
    final i = students.indexWhere((s) => s.id == student.id);
    if (i < 0) { students.add(student); } else { students[i] = student; }
  }
}
