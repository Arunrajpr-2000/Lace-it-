import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lace_it/Application/Bloc/Authbloc/auth_bloc.dart';
import 'package:lace_it/Application/Provider/google_signIn.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';

import 'package:lace_it/presentation/screens/Auth/ForgotPassword/forgot_password.dart';

import 'package:lace_it/presentation/screens/payment/widget/paymet_method_tile_widget.dart';
import 'package:lace_it/presentation/widgets/textfield_container.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final navKey = GlobalKey<NavigatorState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ScaffoldBgcolor,
        body: Form(
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
                    'Login to Your Account',
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  k20height,
                  k20height,
                  TextfieldContainer(
                    Controller: emailController,
                    hinttext: 'Email',
                    leadingIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  k20height,
                  TextfieldContainer(
                      Controller: passwordController,
                      hinttext: 'Password',
                      validator: (passwrd) =>
                          passwrd != null && passwrd.length < 6
                              ? ' Enter Min 6 Letters'
                              : null,
                      leadingIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 20,
                      ),
                      TrailingIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                            size: 20,
                          ))),
                  k20height,
                  GestureDetector(
                    onTap: () {
                      final isValid = formkey.currentState!.validate();
                      if (!isValid) return;
                      BlocProvider.of<AuthBloc>(context).add(AuthLogin(
                          context: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()));
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Sign In',
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
                    onTap: () =>
                        BlocProvider.of<AuthBloc>(context).add(Toggle()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " SignUp",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  k10height,
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotScreen(),
                    )),
                    child: Text(
                      "Forgotten password?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  k20height,
                  PaymentMethodsTile(
                    onTap: () async {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);

                      provider.googleLogin();
                    },
                    ImageUrl:
                        'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1',
                    Title: 'Sign in With Google',
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
