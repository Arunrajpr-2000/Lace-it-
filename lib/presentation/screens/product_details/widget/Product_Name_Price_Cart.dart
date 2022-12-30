import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/Application/Bloc/CartBloc/cart_bloc.dart';
import 'package:lace_it/model/cart_model.dart';

import '../../../../core/color/colors.dart';

class ProductNamePriceCart extends StatelessWidget {
  const ProductNamePriceCart({
    Key? key,
    required this.productname,
    required this.productprice,
    required this.productdescription,
    required this.productid,
    required this.count,
    required this.productimage,
    required this.productquantity,
    required this.productsize,
  }) : super(key: key);

  final String productname;
  final String count;
  final String productprice;
  final String productdescription;
  final String productquantity;
  final String productid;
  final List productimage;
  final List productsize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
                width: 250.w,
                child: Text(
                  // 'Nike Air Jordan\n ₹5,939',
                  '$productname',
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: whiteColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                // 'Nike Air Jordan\n ₹5,939',
                '₹ ${productprice}',
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(AddtoCart(
                    cartModel: CartModel(
                        orderquantity: int.parse(count),
                        size: productsize,
                        cartprice: double.parse(productprice),
                        id: productid,
                        name: productname,
                        description: productdescription,
                        price: double.parse(productprice),
                        quantity: num.parse(productquantity),
                        images: productimage),
                    context: context));
              },
              icon: const Icon(
                Icons.add_shopping_cart_rounded,
                size: 25,
                color: whiteColor,
              )),
        ),
      ],
    );
  }
}
