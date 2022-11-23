import 'package:doctor_app/components/top_doctors_card.dart';
import 'package:doctor_app/models/doctor.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TopDoctorsList extends StatelessWidget {
  const TopDoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: topDoctors.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/doctor_details', arguments: Doctor(
              doctorName: topDoctors[index].doctorName,
              doctorDescription: topDoctors[index].doctorDescription,
              doctorHospital: topDoctors[index].doctorHospital,
              doctorIsOpen: topDoctors[index].doctorIsOpen,
              doctorNumberOfPatient: topDoctors[index].doctorNumberOfPatient,
              doctorPicture: topDoctors[index].doctorPicture,
              doctorRating: topDoctors[index].doctorRating,
              doctorSpecialty: topDoctors[index].doctorSpecialty,
              doctorYearOfExperience: topDoctors[index].doctorYearOfExperience,
            ),);
          },
          child: TopDoctorsCard(
          doctor: topDoctors[index],
            )
        );
      }),
    );
  }
}
