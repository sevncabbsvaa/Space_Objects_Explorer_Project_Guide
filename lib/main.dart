import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(SpaceObjectsApp());
}

class SpaceObjectsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Objects Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
