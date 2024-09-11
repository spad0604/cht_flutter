import 'package:cht_flutter/database/user_database.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class StudentInfoScreen extends StatelessWidget {
  final userdb = Userdb();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (text) {

                  },
                  controller: nameController,
                  style: const TextStyle(
                    color: Colors.black, // Màu chữ đen
                    fontWeight: FontWeight.bold, // Chữ in đậm
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Họ và tên',
                    labelStyle: TextStyle(
                      color: Colors.black, // Màu label đen
                      fontWeight: FontWeight.bold, // Label in đậm
                    ),
                    border: InputBorder.none, // Không viền
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    hintText: 'Nhập họ và tên',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Khoảng cách giữa hai TextField

              // Container để thêm bo góc và đổ bóng cho TextField
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Màu nền cho TextField
                  borderRadius: BorderRadius.circular(24.0), // Bo góc
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Màu đổ bóng
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Đổ bóng theo chiều dọc
                    ),
                  ],
                ),
                child: TextField(
                  controller: classController,
                  style: const TextStyle(
                    color: Colors.black, // Màu chữ đen
                    fontWeight: FontWeight.bold, // Chữ in đậm
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Tên lớp (VD: 12T1, 12T2, 10TR, 10SU..)',
                    labelStyle: TextStyle(
                      color: Colors.black, // Màu label đen
                      fontWeight: FontWeight.bold, // Label in đậm
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    hintText: 'Nhập tên lớp',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Khoảng cách giữa TextFields và nút Submit

              // Nút Submit
              ElevatedButton(
                onPressed: () async {
                  await userdb.create(name: nameController.text, className: classController.text);
                  Restart.restartApp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent, // Nền xanh đậm hơn
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white, // Màu chữ trắng
                    fontSize: 18, // Cỡ chữ cho nút Submit
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}