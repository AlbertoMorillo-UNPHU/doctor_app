import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: 100,
          height: 100,
          child: const CircularProgressIndicator(backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}