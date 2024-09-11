import 'package:cht_flutter/database/teacher_database.dart';
import 'package:cht_flutter/model/teacher.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> teacherData() async {
  final teacherDb = Teacherdb();

  List<Teacher> teacherList = await teacherDb.fetchAll();

  final databaseFirebase = FirebaseDatabase.instance.ref();

  final snapshot = await databaseFirebase.child('sl').get();
  int values = int.parse(snapshot.value.toString());

  if (teacherList.length < values) {
    for (int i = teacherList.length; i < values; i++) {
      final root = databaseFirebase.child(i.toString());

      final birthSnapshot = await root.child('birth').get();
      final emailSnapshot = await root.child('email').get();
      final imageSnapshot = await root.child('image').get();
      final nameSnapshot = await root.child('name').get();
      final phonenumberSnapshot = await root.child('phonenumber').get();
      final subjectSnapshot = await root.child('subject').get();

      final birth = birthSnapshot.value?.toString() ?? '';
      final email = emailSnapshot.value?.toString() ?? '';
      final image = imageSnapshot.value?.toString() ?? '';
      final name = nameSnapshot.value?.toString() ?? '';
      final phonenumber = phonenumberSnapshot.value?.toString() ?? '';
      final subject = subjectSnapshot.value?.toString() ?? '';

      teacherDb.create(id: i, birth: birth, email: email, image: image, name: name, phonenumber: phonenumber, subject: subject);
    }
  }

}
