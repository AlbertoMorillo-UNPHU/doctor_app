import 'package:doctor_app/controller/paciente_controller.dart';
import 'package:doctor_app/repository/paciente_repository.dart';
import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import '../../models/tratamiento.dart';
import 'tratamiento_detail_widget.dart';

class TratamientoDataWidget extends StatelessWidget {
  final List<Tratamiento> data;
  final TextStyle titleStyle;
  final TextStyle propStyle;
  final int position;
  const TratamientoDataWidget(
      {Key? key,
      required this.data,
      required this.titleStyle,
      required this.propStyle,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data[position].tratamientoDesc!,
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        TratamientoDetailWidget(
            propIcon: Icons.bloodtype,
            propTitle: 'Tratamiento: ',
            propDetail: data[position].tratamientoDesc!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        TratamientoDetailWidget(
            propIcon: Icons.timelapse,
            propTitle: 'Fecha Inicio: ',
            propDetail: data[position].fechaInicio!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        TratamientoDetailWidget(
            propIcon: Icons.timelapse_outlined,
            propTitle: 'Fecha Fin: ',
            propDetail: '${data[position].fechaFin}',
            propStyle: propStyle),
        TratamientoDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Paciente: ',
            propDetail:
                '${data[position].paciente!.nombre} ${data[position].paciente!.apellidos}',
            propStyle: propStyle),
        TratamientoDetailWidget(
            propIcon: Icons.medical_information,
            propTitle: 'Doctor: ',
            propDetail:
                '${data[position].doctor!.nombre} ${data[position].doctor!.apellidos}',
            propStyle: propStyle),
      ],
    );
  }

  Future<Paciente> getPaciente(int id) {
    PacienteController pacienteController =
        PacienteController(PacienteRepository());
    return pacienteController.getPaciente(id);
  }
}
