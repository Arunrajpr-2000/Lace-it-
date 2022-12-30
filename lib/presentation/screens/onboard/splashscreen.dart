import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/presentation/screens/Auth/auth_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Timer(
          const Duration(seconds: 5),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginStream())),
        );
      },
    );

    return Scaffold(
      backgroundColor: ScaffoldBgcolor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/nathan-dumlao-QLPWQvHvmII-unsplash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lace It",
                style: TextStyle(
                    fontFamily: italian,
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              k10height,
              const CircularProgressIndicator(
                color: whiteColor,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
