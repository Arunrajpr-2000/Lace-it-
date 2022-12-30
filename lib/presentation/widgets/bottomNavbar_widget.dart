import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lace_it/core/color/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: ScaffoldBgcolor.withOpacity(0.1),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
            child: GNav(
              // rippleColor: Colors.red,
              hoverColor: Colors.grey,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 20.sp,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.grey,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: 'Cart',
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Order',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: newIndex,
              onTabChange: (index) {
                indexChangeNotifier.value = index;
              },
            ),
          ),
        );
      },
    );
  }
}
