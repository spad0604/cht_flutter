import 'package:cht_flutter/data/teacher.dart';
import 'package:cht_flutter/database/teacher_database.dart';
import 'package:cht_flutter/database/user_database.dart';
import 'package:cht_flutter/homepage/home_page_presenter.dart';
import 'package:cht_flutter/model/user.dart';
import 'package:cht_flutter/news/news.dart';
import 'package:cht_flutter/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:cht_flutter/timetable/time_table_page.dart';
import 'package:sqflite/sqflite.dart';
import '../database/class_choose_database.dart';
import '../model/class_choose.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> implements HomePagePresenter{
  final classdb = Classdb();
  final teacherdb = Teacherdb();
  final userdb = Userdb();

  bool _isLoading = true;

  String nameuser = '';
  String userclass = '';

  Database? database;

  @override
  void initState() {
    userData();
    teacherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == false ? SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'CHT',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 70,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.people_alt_sharp,
                  size: 50,
                ),
                const SizedBox(width: 10,),
                Text(
                  nameuser,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                const SizedBox(width: 10,),
                const Text(
                  '|',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                  userclass,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      timeTable();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Center(
                    child: Text(
                      'Thời khoá biểu',
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Tra cứu thời khoá biểu',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      search();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.blue,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Center(
                    child: Text(
                      'Tra cứu',
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Tra cứu thông tin',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      news();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: const Icon(
                        Icons.newspaper,
                        color: Colors.blue,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Center(
                    child: Text(
                      'Thông tin',
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Thông tin từ website',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3)
                        )
                      ]
                    ),
                    child: const Icon(
                      Icons.credit_score,
                      color: Colors.blue,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Center(
                    child: Text(
                      'Kêt quả',
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Kết quả học tập',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ) : const SizedBox();
  }
  
  @override
  void news() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const News()));
  }
  
  @override
  void search() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
  }
  
  @override
  void timeTable() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeTable()));
  }

  Future<void> createDatabase() async {
      List<ClassChoose> classChooseList = await classdb.fetchAll();

      if(classChooseList.isEmpty) {
        classdb.create(classChoose: userclass);
      }

      setState(() {
        _isLoading = false;
      });
  }

  Future<void> userData() async {
    List<User> userList = await userdb.fetchAll();
    setState(() {
      nameuser = userList[0].name;
      userclass = userList[0].className;
      print(nameuser);
    });
    await createDatabase();
  }
}