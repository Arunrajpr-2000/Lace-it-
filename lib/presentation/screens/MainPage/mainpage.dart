import 'package:flutter/material.dart';

import 'package:lace_it/presentation/screens/Home/home_screen.dart';
import 'package:lace_it/presentation/screens/cart/cart_screen.dart';

import 'package:lace_it/presentation/screens/order%20History/order_history.dart';
import 'package:lace_it/presentation/screens/profile%20Screen/profile_screen.dart';
import 'package:lace_it/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:lace_it/presentation/widgets/bottomNavbar_widget.dart';
import 'package:lace_it/presentation/widgets/drawer_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final _pages = [
    ScreenHome(),
    const ScreenWishlist(),
    const ScreenCart(),
    OrderPage(),
    ScreenProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, child) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
