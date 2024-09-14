import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                color: Colors.blue,
                child: const Center(
                  child: Text('Thông báo', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),),
                ),
              ),
              const Center(child: Text('Không có thông báo nào'),),
            ],
          )),
    );
  }
}
