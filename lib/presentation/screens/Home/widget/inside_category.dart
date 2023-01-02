import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/snackbar/snackbarAuth.dart';
import 'package:lace_it/function/wishlist_fun.dart';
import 'package:lace_it/model/product_model.dart';
import 'package:lace_it/presentation/screens/wishlist/widgets/wishlist_icon.dart';

import '../../product_details/product_View.dart';

// ignore: must_be_immutable
class InSideCategory extends StatelessWidget {
  InSideCategory({required this.brandName, super.key});

  String brandName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(brandName.toString()),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Product>>(
            stream: FirebaseFirestore.instance
                .collection('categories')
                .doc(brandName)
                .collection(brandName)
                .snapshots()
                .map((snapshot) => snapshot.docs
                    .map((e) => Product.fromJson(e.data()))
                    .toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.80,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    List<Product> documentSnapshot = snapshot.data!;

                    String id = documentSnapshot[index].id;

                    log(id);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductView(
                                  productname:
                                      documentSnapshot[index].name.toString(),
                                  productdescription: documentSnapshot[index]
                                      .description
                                      .toString(),
                                  productprice:
                                      documentSnapshot[index].price.toString(),
                                  productquantiy: documentSnapshot[index]
                                      .quantity
                                      .toString(),
                                  productsize:
                                      documentSnapshot[index].size.toList(),
                                  productid: documentSnapshot[index].id,
                                  productimage: documentSnapshot[index].images,
                                )));
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                wishlistIcon(
                                  onTap: () {
                                    addToFav(
                                      product: Product(
                                        size: documentSnapshot[index].size,
                                        id: documentSnapshot[index].id,
                                        name: documentSnapshot[index]
                                            .name
                                            .toString(),
                                        description:
                                            documentSnapshot[index].description,
                                        price: documentSnapshot[index].price,
                                        quantity:
                                            documentSnapshot[index].quantity,
                                        images: documentSnapshot[index].images,
                                      ),
                                    );
                                    Utils.showSnackBar(
                                        context: context,
                                        text: 'Added to wishlist');
                                  },
                                  iconData: Icons.favorite_border,
                                )
                              ],
                            ),
                            SizedBox(
                              child: Image.network(
                                documentSnapshot[index].images[0],
                                width: 120.w,
                                height: 120.h,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                documentSnapshot[index].name,
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "₹ ${documentSnapshot[index].price}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                );
              } else {
                return const Align(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            }),
      ),
    );
  }
}
