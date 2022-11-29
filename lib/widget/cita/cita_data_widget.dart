import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/cita.dart';
import 'cita_detail_widget.dart';

class CitaDataWidget extends StatelessWidget {
  const CitaDataWidget({
    Key? key,
    required this.data,
    required this.titleStyle,
    required this.propStyle,
    required this.position,
  }) : super(key: key);

  final List<Cita> data;
  final TextStyle titleStyle;
  final TextStyle propStyle;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat("d MMMM, yyyy")
              .add_jm()
              .format(DateTime.parse(data[position].cita1!)),
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        CitaDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Paciente:',
            propDetail:
                '${data[position].paciente!.nombre} ${data[position].paciente!.apellidos}',
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        CitaDetailWidget(
            propIcon: Icons.health_and_safety,
            propTitle: 'Doctor:',
            propDetail:
                '${data[position].doctor!.nombre} ${data[position].doctor!.apellidos}',
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        CitaDetailWidget(
            propIcon: Icons.note_rounded,
            propTitle: 'Fecha Cita: ',
            propDetail: data[position].cita1!,
            propStyle: propStyle),
      ],
    );
  }
}
