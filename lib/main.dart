import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200146/page/home.dart';

//NAMA : FAQI HIMMAKA MUSHOFFA
//NIM  : 123200146
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Home(),
    );
  }
}
