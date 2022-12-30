import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/Application/Bloc/CartBloc/cart_bloc.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/function/cart_fun.dart';
import 'package:lace_it/model/cart_model.dart';
import 'package:lace_it/core/snackbar/snackbarAuth.dart';
import 'package:lace_it/presentation/widgets/quantity_widget.dart';

class CartListView extends StatelessWidget {
  CartListView({
    Key? key,
  }) : super(key: key);

  int count = 1;

  double total = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return StreamBuilder<List<CartModel>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(email)
                .collection('cart')
                .snapshots()
                .map((snapshot) => snapshot.docs
                    .map((e) => CartModel.fromJson(e.data()))
                    .toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => k30height,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<CartModel> documentsnapshot = snapshot.data!;

                    final cartlist = snapshot.data;
                    total = 0;
                    for (var e in cartlist!) {
                      total = total + e.cartprice;

                      log(total.toString());
                    }
                    return Row(
                      children: [
                        k10width,
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    documentsnapshot[index].images[0]),
                                fit: BoxFit.contain,
                              ),
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        k10width,
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 120.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  documentsnapshot[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹ ${documentsnapshot[index].cartprice}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  removeFromCart(
                                      id: documentsnapshot[index].name);
                                  Utils.showSnackBar(
                                      context: context,
                                      text: 'Removed From Cart');
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: whiteColor,
                                )),
                            QuantityWidget(
                              OnPressAdd: () {
                                if (documentsnapshot[index].orderquantity > 0) {
                                  DocumentReference documentReference =
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(email)
                                          .collection('cart')
                                          .doc(documentsnapshot[index].id);

                                  Map<String, dynamic> category = {
                                    'orderquantity':
                                        documentsnapshot[index].orderquantity +
                                            1,
                                    "name": documentsnapshot[index].name,
                                    'docname': documentsnapshot[index].id,
                                    'price': documentsnapshot[index].price,
                                    'quantity':
                                        documentsnapshot[index].quantity,
                                    'description':
                                        documentsnapshot[index].description,
                                    'size': documentsnapshot[index].size,
                                    'image': documentsnapshot[index].images,
                                    'cartprice': (documentsnapshot[index]
                                            .price) *
                                        (documentsnapshot[index].orderquantity +
                                            1),
                                  };

                                  log('message cate ');

                                  documentReference
                                      .update(category)
                                      .whenComplete(() {
                                    log(' quantity updated');
                                  });
                                }
                              },
                              Quantity: documentsnapshot[index]
                                  .orderquantity
                                  .toString(),
                              OnPressSub: () {
                                if (documentsnapshot[index].orderquantity > 1) {
                                  DocumentReference documentReference =
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(email)
                                          .collection('cart')
                                          .doc(documentsnapshot[index].id);

                                  Map<String, dynamic> category = {
                                    'orderquantity':
                                        documentsnapshot[index].orderquantity -
                                            1,
                                    "name": documentsnapshot[index].name,
                                    'docname': documentsnapshot[index].id,
                                    'price': documentsnapshot[index].price,
                                    'quantity':
                                        documentsnapshot[index].quantity,
                                    'description':
                                        documentsnapshot[index].description,
                                    'size': documentsnapshot[index].size,
                                    'image': documentsnapshot[index].images,
                                    'cartprice': (documentsnapshot[index]
                                            .price) *
                                        (documentsnapshot[index].orderquantity -
                                            1)
                                  };

                                  log('message cate ');

                                  documentReference
                                      .update(category)
                                      .whenComplete(
                                          () => log(' quantity updated'));
                                }
                              },
                            )
                          ],
                        )
                      ],
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Align(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            });
      },
    );
  }
}
