import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/presentation/screens/search/search_screen.dart';
import 'package:lace_it/presentation/widgets/headerTile.dart';

import '../../../core/color/colors.dart';
import 'widget/order_listTile.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HeaderTile(
            Title: Text(
              'My Orders',
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            TrailingButton: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScreenSearch()));
                },
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ),
              ),
            ]),
        k20height,
        Expanded(
          child: SizedBox(
            width: 300.w,
            child: const OrderListTile(),
          ),
        ),
      ],
    );
  }
}
