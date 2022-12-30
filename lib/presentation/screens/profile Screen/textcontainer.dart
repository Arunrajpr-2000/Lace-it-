import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

class Textcontainer extends StatelessWidget {
  Textcontainer(
      {Key? key,
      required this.text,
      this.icondata,
      this.icons,
      this.textcolor,
      this.onTap})
      : super(key: key);

  String text;
  IconData? icondata;
  Icon? icons;
  Color? textcolor;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: 55.sp,
      decoration: BoxDecoration(
          color: const Color(0xff1F222B),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: onTap,
        leading: icons ??
            Icon(
              icondata,
              color: whiteColor,
            ),
        title: Text(
          text,
          style: TextStyle(
            color: textcolor ?? whiteColor,
          ),
        ),
      ),
    );
  }
}
