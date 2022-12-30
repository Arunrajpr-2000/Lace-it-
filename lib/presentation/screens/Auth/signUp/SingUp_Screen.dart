import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/Application/Bloc/Authbloc/auth_bloc.dart';

import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';

import 'package:lace_it/presentation/widgets/textfield_container.dart';

class SignUpScreen extends StatelessWidget {
  final navkey = GlobalKey<NavigatorState>();
  SignUpScreen({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();
  bool _validate = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _namecontroller = TextEditingController();
  final _phonenumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBgcolor,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
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
                      'Create An Account',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    k20height,
                    k20height,
                    TextfieldContainer(
                      Controller: _emailController,
                      hinttext: 'Email',
                      leadingIcon: const Icon(
                        Icons.email,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    k20height,
                    TextfieldContainer(
                        Controller: _passwordController,
                        validator: (value) => value != null && value.length < 6
                            ? 'Minimum 6 letters'
                            : null,
                        hinttext: 'Password',
                        leadingIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 20,
                        ),
                        TrailingIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                              size: 20,
                            ))),
                    k20height,
                    TextfieldContainer(
                        validator: (value) {
                          value != null &&
                                  value.length <= 6 &&
                                  _passwordController.text !=
                                      _confirmpasswordController.text
                              ? "PassWord didn't Match"
                              : null;
                        },
                        Controller: _confirmpasswordController,
                        hinttext: 'Confirm Password',
                        leadingIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 20,
                        ),
                        TrailingIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                              size: 20,
                            ))),
                    k20height,
                    GestureDetector(
                      onTap: () async {
                        log('calling SignUp Bloc');

                        final isValid = formkey.currentState!.validate();
                        if (!isValid) {
                          log('invaied inputs');
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context).add(AuthSignUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            context: context));
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            'Sign Up',
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
                      onTap: () {},
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(Toggle());
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
