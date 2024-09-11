class User {
  final String name;
  final String className;

  const User({required this.name, required this.className});

  factory User.fromSqfliteDatabase(Map<String, dynamic> map)
    => User(name: map['name'], className: map['class']);
}