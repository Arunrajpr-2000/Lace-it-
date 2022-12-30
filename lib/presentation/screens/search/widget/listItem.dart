import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/model/product_model.dart';
import 'package:lace_it/presentation/screens/product_details/product_View.dart';

class ListedItem extends StatelessWidget {
  ListedItem({
    required this.title,
    required this.product,
    required this.image,
    Key? key,
  }) : super(key: key);
  String title;
  String image;

  Product product;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => ProductView(
                        productdescription: product.description,
                        productname: product.name.toString(),
                        productid: product.id,
                        productprice: product.price.toString(),
                        productquantiy: product.quantity.toString(),
                        productsize: product.size.toList(),
                        productimage: product.images,
                      )),
            );
          },
          child: SizedBox(
            height: 270.h,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image.isEmpty
                                    ? 'https://img.freepik.com/premium-photo/spacious-modern-minimalis-living-room-empty-room-plant-wood-flooor-3d-rendering_33739-490.jpg?w=2000'
                                    : image)),
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            maxLines: 5,
                            ' ${product.description}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white70),
                            overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ₹  ${product.price}  ',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Divider(color: whiteColor),
        ),
        //height_10,
      ],
    );
  }
}
