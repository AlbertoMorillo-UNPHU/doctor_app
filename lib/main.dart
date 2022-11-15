import 'package:doctor_app/login_page.dart';
import 'package:doctor_app/screens/home_page.dart';
import 'package:doctor_app/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.orange[100],
          appBarTheme: const AppBarTheme(elevation: 0.0)),
      home: const HomePage(),
    );
  }
}
