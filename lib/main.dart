import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/providers/contact.dart';
import 'package:hive_test/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox("contacts-box");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

