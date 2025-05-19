import 'package:flutter/material.dart';
import 'home_page.dart'; // fayl adını sən necə adlandırmısansa onu yaz

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Objects Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // <- burda istifadə olunur
    );
  }
}
