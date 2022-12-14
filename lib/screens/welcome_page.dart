import 'dart:ffi';

import 'package:doctor_app/controller/auth_controller.dart';
import 'package:doctor_app/screens/citas/cita_page.dart';
import 'package:doctor_app/screens/diagnosticos/diagnostico_page.dart';
import 'package:doctor_app/screens/doctors/doctor_page.dart';
import 'package:doctor_app/screens/pacientes/paciente_page.dart';
import 'package:doctor_app/screens/tratamientos/tratamiento_page.dart';
import 'package:doctor_app/screens/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cita_controller.dart';
import '../models/cita.dart';
import '../repository/cita_repository.dart';
import '../widget/cita/cita_data_widget.dart';
import '../widget/info_widget.dart';

class WelcomePage extends StatefulWidget {
  final User? userFire;
  const WelcomePage({super.key, required this.userFire});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle propStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  List<Cita> apiCita = [];
  CitaController citaController = CitaController(CitaRepository());
  late Future<List<Cita>> futureCita;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCita = citaController.fetchCitaListProximas();
  }

  @override
  Widget build(BuildContext context) {
    // List images = ["g.png", "t.png", "f.png"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú Principal"),
        backgroundColor: Colors.grey[500],
      ),
      drawer: NavigationDrawer(userFire: widget.userFire),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Cita>>(
          future: futureCita,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  final error = "${snapshot.error}";
                  return InfoWidget(info: error, color: Colors.red);
                } else if (snapshot.data!.isNotEmpty) {
                  List<Cita> data = snapshot.data!;
                  return Column(
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
                      const SizedBox(
                        height: 10,
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
                              widget.userFire!.email!,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: w,
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Citas próximas",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10),
                            color: Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  CitaDataWidget(
                                    data: data,
                                    titleStyle: titleStyle,
                                    propStyle: propStyle,
                                    position: index,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                      const SizedBox(
                        height: 10,
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
                  );
                } else {
                  return Column(
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
                              widget.userFire!.email!,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                  );
                }
            }
          }),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final User? userFire;
  const NavigationDrawer({Key? key, required this.userFire}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        buidHeader(context),
        buildMenuItems(context),
      ]),
    );
  }

  Widget buidHeader(BuildContext context) {
    String? username = userFire!.email.toString();
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserPage(
                    userFire: userFire,
                  )));
        },
        child: Container(
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: AssetImage("img/profile1.png"),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(username,
                  style: TextStyle(fontSize: 16, color: Colors.green[500]))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(runSpacing: 16, children: [
        ListTile(
          leading: const Icon(Icons.accessibility_new),
          title: const Text('Doctores'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DoctorPage(userFire: userFire!),
            ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.airline_seat_flat),
          title: const Text('Pacientes'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PacientePage(userFire: userFire!),
            ));
          },
        ),
        const Divider(color: Colors.black54),
        ListTile(
          leading: const Icon(Icons.analytics_rounded),
          title: const Text('Diagnósticos'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiagnosticoPage(userFire: userFire!),
            ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.medication_liquid),
          title: const Text('Tratamientos'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TratamientoPage(userFire: userFire!),
            ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.assignment),
          title: const Text('Citas'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CitaPage(userFire: userFire!),
            ));
          },
        ),
      ]),
    );
  }
}
