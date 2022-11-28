import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import 'paciente_detail_widget.dart';

class PacienteDataWidget extends StatelessWidget {
  const PacienteDataWidget({
    Key? key,
    required this.data,
    required this.titleStyle,
    required this.propStyle,
    required this.position,
  }) : super(key: key);

  final List<Paciente> data;
  final TextStyle titleStyle;
  final TextStyle propStyle;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${data[position].nombre!} ${data[position].apellidos!}",
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        PacienteDetailWidget(
            propIcon: Icons.bloodtype,
            propTitle: 'Tipo Sangre: ',
            propDetail: data[position].tipoSangre!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        PacienteDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Nombre: ',
            propDetail: data[position].nombre!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        PacienteDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Apellidos: ',
            propDetail: '${data[position].apellidos}',
            propStyle: propStyle),
      ],
    );
  }
}
