class Teacher {
  final int id;
  final String birth;
  final String email;
  final String image;
  final String name;
  final String phonenumber;
  final String subject;


  Teacher({required this.id, required this.birth, required this.email, required this.image, required this.name,
      required this.phonenumber, required this.subject});

  factory Teacher.fromSqfliteDatabase(Map<String, dynamic> map)
    => Teacher(
      id: map['id'] ?? 0,
      birth: map['birth'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      subject: map['subject'] ?? '');
}