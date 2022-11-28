import 'package:flutter/material.dart';

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
          "${data[position].doctorId!} ${data[position].pacienteId!}",
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        CitaDetailWidget(
            propIcon: Icons.bloodtype,
            propTitle: 'Tipo Sangre: ',
            propDetail: data[position].cita1!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        CitaDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Nombre: ',
            propDetail: data[position].cita1!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        CitaDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Apellidos: ',
            propDetail: '${data[position].cita1}',
            propStyle: propStyle),
      ],
    );
  }
}
