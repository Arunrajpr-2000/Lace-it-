import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

import 'package:lace_it/function/cart_fun.dart';
import 'package:lace_it/model/cart_model.dart';
import 'package:lace_it/presentation/screens/cart/cart_listview.dart';
import 'package:lace_it/presentation/screens/search/search_screen.dart';
import 'package:lace_it/presentation/widgets/headerTile.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              HeaderTile(
                  Title: Text(
                    'Cart',
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  TrailingButton: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenSearch()));
                      },
                      icon: const Icon(
                        Icons.search,
                        color: whiteColor,
                      ),
                    ),
                  ]),
              CartListView(),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: StreamBuilder<List<CartModel>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(email)
                    .collection('cart')
                    .snapshots()
                    .map((e) => e.docs
                        .map((docs) => CartModel.fromJson(docs.data()))
                        .toList()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cartlist = snapshot.data!;
                    double total = 0;
                    for (var e in cartlist) {
                      total = total + e.cartprice;

                      log(total.toString());
                    }
                    final list = snapshot.data;
                    return Container(
                      height: 100.h,
                      width: 360.w,
                      decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total Cost',
                            style: TextStyle(
                                color: ScaffoldBgcolor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹ $total',
                            style: TextStyle(
                                color: ScaffoldBgcolor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Align(
                      alignment: FractionalOffset.center,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                }))
      ],
    );
  }
}
