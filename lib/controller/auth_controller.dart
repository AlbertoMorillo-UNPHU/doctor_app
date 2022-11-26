//import 'dart:html';

import 'package:doctor_app/screens/home_page.dart';
import 'package:doctor_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/usuarios.dart';
import '../repository/usuario_repository.dart';
import '../screens/welcome_page.dart';
import 'usuario_controller.dart';

//import 'package:get/get.dart';

class AuthController extends GetxController {
  //AuthController.instance...
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      ('login page');
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => WelcomePage(
            userFire: user,
          ));
      //Get.offAll(() => const HomePage());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Account creation failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
    UsuarioController usuarioController =
        UsuarioController(UsuarioRepository());
    Usuarios usuarios =
        Usuarios(username: email, uidFire: auth.currentUser?.uid);

    usuarioController.postUsario(usuarios);
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Login failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
