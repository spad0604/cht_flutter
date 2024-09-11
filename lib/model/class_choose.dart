class ClassChoose {
  final String class_name;

  const ClassChoose({required this.class_name});

  factory ClassChoose.fromSqfliteDatabase(Map<String, dynamic> map)
    => ClassChoose(class_name: map['class']);
}