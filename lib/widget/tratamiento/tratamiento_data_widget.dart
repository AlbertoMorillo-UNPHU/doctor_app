import 'package:flutter/material.dart';

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
            propIcon: Icons.person,
            propTitle: 'Fecha Inicio: ',
            propDetail: data[position].fechaInicio!,
            propStyle: propStyle),
        const SizedBox(height: 5.0),
        TratamientoDetailWidget(
            propIcon: Icons.person,
            propTitle: 'Fecha Fin: ',
            propDetail: '${data[position].fechaFin}',
            propStyle: propStyle),
      ],
    );
  }
}
