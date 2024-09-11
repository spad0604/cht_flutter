import 'package:cht_flutter/class_id.dart';
import 'package:cht_flutter/data/data.dart';
import 'package:cht_flutter/database/class_choose_database.dart';
import 'package:cht_flutter/model/class_choose.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  _TimeTable createState() => _TimeTable();
}

class _TimeTable extends State<TimeTable> {
  final classdb = Classdb();

  String dropDownValue = '12T1';
  List<List<String>> data = [];

  bool _isLoading = true;

  DateTime _dateTime = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    featchData();
    super.initState();
  }

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
                  child: const Center(
                    child: Text(
                      'Thời khoá biểu',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                            Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back, color: Colors.white,),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: DropdownButton(
                          value: dropDownValue,
                          icon: const Icon(Icons.filter_list_alt, color: Colors.white,),
                          dropdownColor: Colors.black,
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                              classdb.update(newClass: newValue);
                              featchData();
                            });
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),
                          items: const [
                            DropdownMenuItem<String>(
                                value: '12T1',
                                child: Text('12T1',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12T2',
                                child: Text('12T2',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12L',
                                child: Text('12L',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12H',
                                child: Text('12H',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12SINH',
                                child: Text('12SINH',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12TIN',
                                child: Text('12TIN',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12V',
                                child: Text('12V',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12A1',
                                child: Text('12A1',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12A2',
                                child: Text('12A2',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12P',
                                child: Text('12P',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12SU',
                                child: Text('12SU',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '12DIA',
                                child: Text('12DIA',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11T1',
                                child: Text('11T1',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11T2',
                                child: Text('11T2',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11L',
                                child: Text('11L',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11H',
                                child: Text('11H',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11SINH',
                                child: Text('11SINH',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11TIN',
                                child: Text('11TIN',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11V',
                                child: Text('11V',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11A1',
                                child: Text('11A1',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11A2',
                                child: Text('11A2',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11P',
                                child: Text('11P',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11SU',
                                child: Text('11SU',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '11DIA',
                                child: Text('11DIA',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10T1',
                                child: Text('10T1',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10T2',
                                child: Text('10T2',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10L',
                                child: Text('10L',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10H',
                                child: Text('10H',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10SINH',
                                child: Text('10SINH',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10TIN',
                                child: Text('10TIN',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10V',
                                child: Text('10V',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10A1',
                                child: Text('10A1',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10A2',
                                child: Text('10A2',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10P',
                                child: Text('10P',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10SU',
                                child: Text('10SU',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10DIA',
                                child: Text('10DIA',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            DropdownMenuItem<String>(
                                value: '10TR',
                                child: Text('10TR',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) {
                return isSameDay(_dateTime, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _dateTime = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            (_dateTime.weekday != 7 && _isLoading == false)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: data[_dateTime.weekday].length - 1,
                      itemBuilder: (context, index) {
                        // Danh sách thời gian bắt đầu và kết thúc
                        List<Map<String, String>> timeSlots = [
                          {'start': '6:45', 'end': '7:30'},
                          {'start': '7:35', 'end': '8:20'},
                          {'start': '8:35', 'end': '9:20'},
                          {'start': '9:25', 'end': '10:05'},
                          {'start': '10:20', 'end': '11:05'}
                        ];

                        var time = timeSlots[(index % timeSlots.length)];

                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 255, 241, 233),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      time['start']!, // Thời gian bắt đầu
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    const Text(
                                      '|',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 15),
                                    ),
                                    Text(
                                      time['end']!, // Thời gian kết thúc
                                      style: const TextStyle(
                                          color: Colors.black45, fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Môn học: ${data[_dateTime.weekday][index + 1]}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Sáng thứ ${_dateTime.weekday + 1}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Giáo viên: Null',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  void featchData() async {
    List<ClassChoose> classChooseList = await classdb.fetchAll();

    String className = classChooseList[0].class_name;

    int id = getClassId(className);

    data = await fetchTableData(id);

    setState(() {
      _isLoading = false;
      dropDownValue = classChooseList[0].class_name;
    });
  }

}
