import 'package:doctor_app/components/top_doctors_card.dart';
import 'package:doctor_app/models/doctor.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TopDoctorList extends StatelessWidget {
  const TopDoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: topDoctors.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {
            
          },
          child: TopDoctorsCard(
          doctor: topDoctors[index],
            )
        );
      }),
    );
  }
}
