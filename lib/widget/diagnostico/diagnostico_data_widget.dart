import 'package:flutter/material.dart';

import '../../models/diagnostico.dart';
import 'diagnostico_detail_widget.dart';

class DiagnosticoDataWidget extends StatelessWidget {
  const DiagnosticoDataWidget({
    Key? key,
    required this.data,
    required this.titleStyle,
    required this.propStyle,
    required this.position,
  }) : super(key: key);

  final List<Diagnostico> data;
  final TextStyle titleStyle;
  final TextStyle propStyle;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${data[position].diagnosticoDesc}",
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        DiagnosticoDetailWidget(
            propIcon: Icons.person,
            propTitle: 'PacienteId: ',
            propDetail: '${data[position].pacienteId}',
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        DiagnosticoDetailWidget(
            propIcon: Icons.health_and_safety,
            propTitle: 'DoctorId: ',
            propDetail: '${data[position].doctorId}',
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        DiagnosticoDetailWidget(
            propIcon: Icons.note_rounded,
            propTitle: 'Diagnostico: ',
            propDetail: data[position].diagnosticoDesc!,
            propStyle: propStyle),
      ],
    );
  }
}
