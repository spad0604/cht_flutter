import 'package:cht_flutter/database/teacher_database.dart';
import 'package:cht_flutter/model/teacher.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _MySearchPage createState() => _MySearchPage();
}

class _MySearchPage extends State<SearchPage> {
  String inputText = '';
  String selectedRole = 'GV';
  final teacherdb = Teacherdb();

  List<Teacher> teacherList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tìm kiếm',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Tìm kiếm',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        setState(() {
                          inputText = text;
                          searchTeacher(inputText);
                        });
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: [
                          Radio<String>(
                            value: 'GV',
                            groupValue: selectedRole,
                            onChanged: (String? value) {
                              setState(() {
                                selectedRole = value!;
                              });
                            },
                          ),
                          const Text('GV'),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'HS',
                            groupValue: selectedRole,
                            onChanged: (String? value) {
                              setState(() {
                                selectedRole = value!;
                              });
                            },
                          ),
                          const Text('HS'),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: (teacherList.isNotEmpty && selectedRole == 'GV')
                        ? ListView.builder(
                            itemCount: teacherList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Họ và tên: ${teacherList[index].name}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Ngày sinh: ${teacherList[index].birth}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Số điện thoại: ${teacherList[index].phonenumber}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Email: ${teacherList[index].email}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Môn dạy: ${teacherList[index].subject}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              teacherList[index].image,
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 100,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text('No results found'),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchTeacher(String name) async {
    var result = await teacherdb.searchByName(name);
    setState(() {
      teacherList = result;
    });
  }
}
