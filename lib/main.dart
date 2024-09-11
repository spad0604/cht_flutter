import 'package:cht_flutter/database/copy_database.dart';
import 'package:cht_flutter/database/user_database.dart';
import 'package:cht_flutter/homepage/home_page.dart';
import 'package:cht_flutter/model/user.dart';
import 'package:cht_flutter/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final userdb = Userdb();
List<User> userList = [];

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDlmVHXUt1-mt7prdzvIqtxlnwOwTpvetU',
        appId: '1:967848729104:android:f4d32de1ed9780f8710895',
        messagingSenderId: '967848729104',
        projectId: 'chtflutter-30e78')
  );
  await copyDatabase();
  await firstTime();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: userList.isNotEmpty ? const HomePage() : StudentInfoScreen()),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
Future<void> firstTime() async {
  userList = await userdb.fetchAll();
}

