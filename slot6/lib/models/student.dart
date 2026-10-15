class Student {
  final String id;
  final String name;
  final String email;
  final String major;
  bool isSelected;

  Student({
    required this.id,
    required this.name,
    this.email = '',
    this.major = '',
    this.isSelected = false,
  });
}

