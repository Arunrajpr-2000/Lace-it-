import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/presentation/screens/Auth/signIn/login.dart';
import 'package:lace_it/core/snackbar/snackbarAuth.dart';
import 'package:lace_it/presentation/widgets/textfield_container.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);

  final emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBgcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250.w,
              height: 100.h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'asset/app_icon/lace-it-high-resolution-logo-white-on-transparent-background (1).png'),
                      fit: BoxFit.contain)),
            ),
            k10height,
            Text(
              'Reset the Password',
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
            k30height,
            TextfieldContainer(
              Controller: emailcontroller,
              hinttext: 'Email',
              leadingIcon: const Icon(
                Icons.email,
                color: Colors.grey,
                size: 20,
              ),
            ),
            k30height,
            GestureDetector(
              onTap: () {
                resetPass(context);
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            k20height,
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Sign In",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetPass(context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: whiteColor,
          backgroundColor: ScaffoldBgcolor,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      log('Code send to $emailcontroller');

      Utils.showSnackBar(
          text: 'Password reset email send to your ${emailcontroller.text}',
          color: whiteColor,
          context: context);
    } on FirebaseAuthException catch (e) {
      log('Reset exp $e');
      Utils.showSnackBar(context: context, text: e.message);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }
}
