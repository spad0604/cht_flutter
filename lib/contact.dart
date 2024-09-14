import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                      child: Text('Thông tin liên hệ')
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.facebook, color: Colors.blue, size: 30,),
                  SizedBox(width: 5,),
                  DefaultTextStyle(
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      child: Text('facebook.com/nguyengiap04')
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.redAccent, size: 30,),
                  SizedBox(width: 5,),
                  DefaultTextStyle(
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      child: Text('giapt2k29@cht.edu.vn')
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.redAccent, size: 30,),
                  SizedBox(width: 5,),
                  DefaultTextStyle(
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      child: Text('giap.nv225126@sis.hust.edu.vn')
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.green, size: 30,),
                  SizedBox(width: 5,),
                  DefaultTextStyle(
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      child: Text('0982097315')
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                      child: Text('Cảm ơn!')
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
