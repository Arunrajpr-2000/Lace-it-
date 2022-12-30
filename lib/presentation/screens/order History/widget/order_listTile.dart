import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/function/order_fun.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .collection('order')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orderList = snapshot.data!;

            return ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => k20height,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Container(
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.network(
                            documentSnapshot['images'][0],
                            fit: BoxFit.contain,
                            width: 70,
                            height: 70,
                          )),
                      title: Text(
                        documentSnapshot['name'],
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: documentSnapshot['isCanceled'] == false
                          ? Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: documentSnapshot['isDeliverd'] == false
                                  ? const Text('Order Placed')
                                  : const Text('Shipped'),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text('Order Cancelled'),
                            ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ));
              },
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
  }
}
