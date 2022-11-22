import 'package:doctor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class HomeScreenNavbar extends StatelessWidget {
  const HomeScreenNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: const BoxDecoration
          (image: DecorationImage(
            image: Svg('assets/svg/icon-burger.svg',
          size: Size(
            24,
            24,
          )
          ),
          ),
          ),
        ),
        Container(
          width: 36,
          height: 36,
          child: const CircleAvatar(
            backgroundColor: kBlueColor,
            backgroundImage: NetworkImage('https://preview.redd.it/ywjftkrjl2d81.jpg?width=640&crop=smart&auto=webp&s=f8c1960d55d639361a6d847a0198085232566bc0'),
          ),
        )
      ],
    );


  }
}