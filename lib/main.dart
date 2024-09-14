import 'package:cht_flutter/database/copy_database.dart';
import 'package:cht_flutter/database/user_database.dart';
import 'package:cht_flutter/firebase/fire_api.dart';
import 'package:cht_flutter/homepage/home_page.dart';
import 'package:cht_flutter/model/user.dart';
import 'package:cht_flutter/search/search_page.dart';
import 'package:cht_flutter/setting/setting_page.dart';
import 'package:cht_flutter/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final userdb = Userdb();
List<User> userList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDlmVHXUt1-mt7prdzvIqtxlnwOwTpvetU',
          appId: '1:967848729104:android:f4d32de1ed9780f8710895',
          messagingSenderId: '967848729104',
          projectId: 'chtflutter-30e78'));
  await FirebaseApi().initNotifications();
  await copyDatabase();
  await firstTime();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _Main createState() => _Main();
}

class _Main extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: userList.isNotEmpty
            ? SafeArea(
              child: Scaffold(
                  bottomNavigationBar: Obx(
                  () => NavigationBar(
                    backgroundColor: Colors.white,
                    selectedIndex: controller.selectedIndex.value,
                    elevation: 0,
                    onDestinationSelected: (index) =>
                        controller.selectedIndex.value = index,
                    destinations: const [
                      NavigationDestination(
                          icon: Icon(Icons.home), label: 'Trang chủ'),
                      NavigationDestination(
                          icon: Icon(Icons.search), label: 'Tìm kiếm'),
                      NavigationDestination(
                          icon: Icon(Icons.settings), label: 'Cài đặt')
                    ],
                  ),
                ),
                      body: Obx(() => controller.screens[controller.selectedIndex.value],)),
            )
            : StudentInfoScreen());
  }
}

Future<void> firstTime() async {
  userList = await userdb.fetchAll();
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomePage(), const SearchPage(), const SettingPage()];
}
