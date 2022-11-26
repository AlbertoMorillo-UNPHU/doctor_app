import 'package:flutter/material.dart';

class DoctorDetailWidget extends StatelessWidget {
  final IconData propIcon;
  final String propTitle;
  final String propDetail;
  final TextStyle propStyle;
  const DoctorDetailWidget(
      {Key? key,
      required this.propIcon,
      required this.propTitle,
      required this.propDetail,
      required this.propStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          propIcon,
          size: 15.0,
          color: Colors.orange.shade900,
        ),
        const SizedBox(width: 5.0),
        Text(
          propTitle,
          style: propStyle,
        ),
        Text(propDetail),
      ],
    );
  }
}
