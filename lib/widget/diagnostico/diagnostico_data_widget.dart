import 'package:doctor_app/widget/doctor/doctor_detail_widget.dart';
import 'package:flutter/material.dart';

import '../../models/doctor.dart';

class DoctorDataWidget extends StatelessWidget {
  const DoctorDataWidget({
    Key? key,
    required this.data,
    required this.titleStyle,
    required this.propStyle,
    required this.position,
  }) : super(key: key);

  final List<Doctor> data;
  final TextStyle titleStyle;
  final TextStyle propStyle;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data[position].espacialidad!,
          style: titleStyle,
        ),
        const SizedBox(height: 5.0),
        DoctorDetailWidget(
            propIcon: Icons.medical_information,
            propTitle: 'Especialidad: ',
            propDetail: data[position].espacialidad!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        DoctorDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Nombre: ',
            propDetail: data[position].nombre!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        DoctorDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Apellidos: ',
            propDetail: '${data[position].apellidos}',
            propStyle: propStyle),
      ],
    );
  }
}
