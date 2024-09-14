import 'dart:io';

import 'package:cht_flutter/contact.dart';
import 'package:cht_flutter/data/teacher.dart';
import 'package:cht_flutter/database/notification.dart';
import 'package:cht_flutter/database/teacher_database.dart';
import 'package:cht_flutter/database/user_database.dart';
import 'package:cht_flutter/homepage/home_page_presenter.dart';
import 'package:cht_flutter/model/user.dart';
import 'package:cht_flutter/news/news.dart';
import 'package:cht_flutter/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:cht_flutter/timetable/time_table_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import '../database/class_choose_database.dart';
import '../model/class_choose.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> implements HomePagePresenter {
  final classdb = Classdb();
  final teacherdb = Teacherdb();
  final userdb = Userdb();
  File? _image;

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
    return _isLoading == false
        ? SingleChildScrollView(
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: _image != null ? FileImage(_image!) : const NetworkImage('data:image/png;base64,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'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      nameuser,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '|',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      userclass,
                      style: const TextStyle(
                          fontSize: 15, color: Colors.black),
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
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                            size: 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Thời khoá biểu',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Tra cứu thời khoá biểu',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
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
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Icon(
                            Icons.credit_score_outlined,
                            color: Colors.blue,
                            size: 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Kết quả',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Kết quả học tập',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Icon(
                            Icons.newspaper,
                            color: Colors.blue,
                            size: 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Thông tin',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Thông tin từ website',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Contact()));
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
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Icon(
                            Icons.contact_support,
                            color: Colors.blue,
                            size: 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Liên hệ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Thông tin liên hệ',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
        : const SizedBox();
  }

  @override
  void news() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const News()));
  }

  @override
  void search() {
    Fluttertoast.showToast(
        msg: 'Tính năng đang phát triển',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void timeTable() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TimeTable()));
  }

  Future<void> createDatabase() async {
    List<ClassChoose> classChooseList = await classdb.fetchAll();

    if (classChooseList.isEmpty) {
      classdb.create(classChoose: userclass);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> userData() async {
    List<User> userList = await userdb.fetchAll();
    setState(() {
      if(userList[0].imagePath != null) {
        _image = File(userList[0].imagePath!);
      }
      else {
        _image = null;
      }
      nameuser = userList[0].name;
      userclass = userList[0].className;
    });
    await createDatabase();
  }
}
