import 'package:doctor_app/auth_controller.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  String? email;
  WelcomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // List images = ["g.png", "t.png", "f.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: w,
            height: h * 0.37,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/signup.png"), fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.18,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: AssetImage("img/profile1.png"),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  email!,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          GestureDetector(
            onTap: (() {
              AuthController.instance.logOut();
            }),
            child: Container(
              width: w * 0.5,
              height: h * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                      image: AssetImage("img/loginbtn.png"),
                      fit: BoxFit.cover)),
              child: const Center(
                  child: Text("Sign out",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}
