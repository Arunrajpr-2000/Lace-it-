import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/core/snackbar/snackbarAuth.dart';
import 'package:lace_it/model/product_model.dart';
import 'package:lace_it/presentation/screens/payment/payment_screen.dart';
import 'package:lace_it/presentation/widgets/quantity_widget.dart';

import '../../widgets/Payment_stack_widget.dart';
import 'widget/Product_Name_Price_Cart.dart';
import 'widget/Product_discription_widget.dart';
import 'widget/pageView_container.dart';

class ProductView extends StatelessWidget {
  ProductView(
      {Key? key,
      required this.productname,
      required this.productid,
      required this.productprice,
      required this.productdescription,
      required this.productquantiy,
      required this.productsize,
      required this.productimage})
      : super(key: key);

  final String productid;
  final String? productname;
  final String? productprice;
  final List productimage;

  final String productdescription;
  final List productsize;
  final String? productquantiy;
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Utils.showSnackBar(context: context, text: 'Added to wishlist');
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
          ),
          k20width,
        ],
      ),
      body: Stack(
        children: [
          productFulldetails(),
          Align(
            alignment: Alignment.bottomCenter,
            child: TotalPriceBottomWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                          price: productprice.toString(),
                          product: Product(
                              size: productsize,
                              id: productid,
                              name: productname.toString(),
                              description: productdescription,
                              price: double.parse(productprice.toString()),
                              quantity: int.parse(productquantiy.toString()),
                              images: productimage),
                        )));
              },
              Title: 'Total cost',
              totalPrice: productprice.toString(),
              selectPayments: 'Payment',
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView productFulldetails() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageViewWidget(
            productimage: productimage,
          ),
          k20height,
          ProductNamePriceCart(
            count: count.toString(),
            productdescription: productdescription.toString(),
            productid: productid,
            productname: productname.toString(),
            productprice: productprice.toString(),
            productimage: productimage,
            productquantity: productquantiy.toString(),
            productsize: productsize,
          ),
          k20height,
          ProductDiscription(productdescription: productdescription),
          k20height,
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'SIZE',
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          sizeAndQuantity(),
        ],
      ),
    );
  }

  Padding sizeAndQuantity() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: productsize.length,
                separatorBuilder: (context, index) => k10width,
                itemBuilder: (context, index) {
                  return CircleAvatar(
                      backgroundColor: const Color(0xff393A3F),
                      radius: 25.r,
                      child: Text(
                        productsize[index].toString(),
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
