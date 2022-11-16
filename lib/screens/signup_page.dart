import 'package:doctor_app/controller/auth_controller.dart';
import 'package:doctor_app/controller/usuario_controller.dart';
import 'package:doctor_app/models/usuarios.dart';
import 'package:doctor_app/repository/usuario_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  UsuarioController usuarioController = UsuarioController(UsuarioRepository());

  @override
  Widget build(BuildContext context) {
    List images = ["g.png", "t.png", "f.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.37,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/signup.png"),
                        fit: BoxFit.cover)),
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
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefix: const Icon(
                                Icons.email,
                                color: Colors.blueAccent,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefix: const Icon(
                                Icons.password_outlined,
                                color: Colors.blueAccent,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 50),
                    ],
                  )),
              const SizedBox(
                height: 0,
              ),
              GestureDetector(
                onTap: () {
                  Usuarios usuarios = Usuarios(
                      username: emailController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());

                  usuarioController.postUsario(usuarios);
                  print(usuarios);
                  AuthController.instance.register(emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Container(
                  width: w * 0.5,
                  height: h * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          image: AssetImage("img/loginbtn.png"),
                          fit: BoxFit.cover)),
                  child: const Center(
                      child: Text("Sign up",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Have an account?",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.grey))),
              SizedBox(
                height: w * 0.08,
              ),
              RichText(
                  text: TextSpan(
                      text: "Sign up using one of the following methods?",
                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                      children: const [])),
              Wrap(
                children: List<Widget>.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.grey[500],
                      child: CircleAvatar(
                        radius: 2,
                        backgroundImage: AssetImage("img/${images[index]}"),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
