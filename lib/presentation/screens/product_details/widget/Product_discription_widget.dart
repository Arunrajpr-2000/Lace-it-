import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

class ProductDiscription extends StatelessWidget {
  ProductDiscription({
    Key? key,
    required this.productdescription,
  }) : super(key: key);

  String? productdescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        '${productdescription.toString()}',
        maxLines: 3,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: whiteColor.withOpacity(0.9),
            fontSize: 15.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
