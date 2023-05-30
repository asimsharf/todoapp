import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/the_colors.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        Navigator.of(context).pushReplacementNamed('/home');
        timer.cancel();
      },
    );
    return const Scaffold(
      backgroundColor: TheColors.secondary,
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
