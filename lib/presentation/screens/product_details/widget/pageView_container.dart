import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

class PageViewWidget extends StatelessWidget {
  PageViewWidget({
    Key? key,
    required this.productimage,
  }) : super(key: key);

  List<dynamic>? productimage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.sp,
      decoration: const BoxDecoration(
        color: whiteColor,
      ),
      child: PageView.builder(
        itemCount: productimage!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return productimage![index] == null
              ? const Text("Unable to Load")
              : Image.network(productimage![index]);
        },
      ),
    );
  }
}
