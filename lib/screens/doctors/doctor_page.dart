import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/repository/doctor_repository.dart';
import 'package:doctor_app/screens/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/doctor.dart';
import '../../widget/alert_widget.dart';
import '../../widget/delete_bg_item.dart';
import '../../widget/doctor/doctor_actions_widget.dart';
import '../../widget/doctor/doctor_data_widget.dart';
import '../../widget/info_widget.dart';
import 'add_doctor_page.dart';

class DoctorPage extends StatefulWidget {
  final User userFire;
  const DoctorPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  List<Doctor> apiDoctor = [];
  DoctorController doctorController = DoctorController(DoctorRepository());
  late Future<List<Doctor>> futureDoctor;
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle propStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureDoctor = doctorController.fetchDoctorList(widget.userFire.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctores'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => WelcomePage(
                          userFire: widget.userFire,
                        ))),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDoctorPage(
                            userFire: widget.userFire,
                          ))).then((value) => _refreshDoctor()),
              icon: const Icon(Icons.add)),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() {
              _refreshDoctor();
            }),
          )
        ],
      ),
      body: FutureBuilder<List<Doctor>>(
        future: futureDoctor,
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
                List<Doctor> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(data[index].id.toString()),
                      onDismissed: (direction) {
                        _showSnackBar(context, data[index], index);
                        _removeEntity(data[index]);
                      },
                      background: const DeleteBgItem(),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.blue[50],
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              DoctorDataWidget(
                                data: data,
                                titleStyle: titleStyle,
                                propStyle: propStyle,
                                position: index,
                              ),
                              DoctorActionsWidget(
                                data: data,
                                doctorController: doctorController,
                                position: index,
                                userFire: widget.userFire,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const InfoWidget(
                    info: "No hay doctores disponibles", color: Colors.red);
              }
          }
        },
      ),
    );
  }

  _refreshDoctor() {
    setState(() {
      futureDoctor = doctorController.fetchDoctorList(widget.userFire.uid);
    });
  }

  void _showSnackBar(BuildContext context, Doctor data, int index) {
    SnackBar snackBar = SnackBar(content: Text("Eliminaste a ${data!.nombre}"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _removeEntity(Doctor doctor) async {
    String result = await doctorController.deleteDoctor(doctor);
    if (result.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertWidget(
              title: 'Doctor eliminado con éxito.',
              content: 'El doctor se eliminó satisfactoriamente.',
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DoctorPage(userFire: widget.userFire!),
                    ));
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }
}
