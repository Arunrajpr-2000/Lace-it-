import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';

class PaymentMethodsTile extends StatelessWidget {
  PaymentMethodsTile(
      {Key? key,
      this.Title,
      this.ImageUrl,
      this.Radiobutton,
      required this.onTap})
      : super(key: key);
  final String? Title;
  final String? ImageUrl;
  final Widget? Radiobutton;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        width: 300.w,
        child: ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: NetworkImage(ImageUrl.toString())),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff35383F)),
            ),
            tileColor: const Color(0xff35383F),
            title: Text(
              '$Title',
              style: const TextStyle(
                  color: whiteColor, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            trailing: Radiobutton),
      ),
    );
  }
}
