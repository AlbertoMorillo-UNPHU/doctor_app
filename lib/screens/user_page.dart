import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  User? userFire;
  UserPage({Key? key, required this.userFire}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userFire!.email!),
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                  image: AssetImage("img/profile1.png"), fit: BoxFit.cover)),
        ));
  }
}
