class User {
  final String name;
  final String className;
  final String? imagePath;

  const User({required this.name, required this.className, required this.imagePath});

  factory User.fromSqfliteDatabase(Map<String, dynamic> map)
    => User(name: map['name'], className: map['class'], imagePath: map['image']);
}