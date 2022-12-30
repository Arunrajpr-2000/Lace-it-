import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lace_it/Application/Provider/google_signIn.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/core/snackbar/snackbarAuth.dart';
import 'package:lace_it/presentation/screens/MainPage/mainpage.dart';
import 'package:lace_it/presentation/screens/settings/setting_screen.dart';

import 'package:lace_it/presentation/widgets/list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: whiteColor,
        child: SizedBox(
            child: Column(children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: ScaffoldBgcolor,
              ),
              child: Center(
                child: Row(
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
                    // Image.asset(
                    //   'asset/app_icon/lace-it-high-resolution-logo-black-on-white-background.png',
                    //   width: 250.w,
                    //   height: 250.h,
                    //   fit: BoxFit.cover,
                    // ),
                    k20width,
                  ],
                ),
              )),
          ListTileWidget(
            IconColor: Color(0xff2b2b29),
            Title: 'Home',
            LeadIcon: Icons.home,
            Ontap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MainScreen(),
            )),
          ),
          ListTileWidget(
            IconColor: Color(0xff2b2b29),
            Title: 'Settings',
            LeadIcon: Icons.settings,
            Ontap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SettingScreen(),
            )),
          ),
          ListTileWidget(
            IconColor: Color(0xff2b2b29),
            Title: 'Log out',
            LeadIcon: Icons.settings,
            Ontap: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              await FirebaseAuth.instance.signOut();

              Utils.showSnackBar(context: context, text: 'Logoutted');
            },
          ),
        ])));
  }
}
