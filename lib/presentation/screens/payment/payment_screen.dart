import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:lace_it/core/color/colors.dart';
import 'package:lace_it/core/constants/constants.dart';
import 'package:lace_it/function/address_fun.dart';
// import 'package:shoea_app/function/cart_fun.dart';
import 'package:lace_it/function/order_fun.dart';
import 'package:lace_it/model/address_model.dart';
import 'package:lace_it/model/order_product_model.dart';
import 'package:lace_it/model/product_model.dart';
import 'package:lace_it/presentation/widgets/textfield_container.dart';

import '../../widgets/Payment_stack_widget.dart';
import 'widget/paymet_method_tile_widget.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key, required this.price, required this.product})
      : super(key: key);
  Product product;
  final String price;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay razorpay = Razorpay();
  TextEditingController localareaController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();

  int _value = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log(response.toString());
    addorder(
        orderModel: OrderedProduct(
      cartprice: widget.product.price * 1,
      description: widget.product.description,
      images: widget.product.images,
      isCanceled: false,
      name: widget.product.name,
      isDelivered: false,
      orderquantity: 1,
      price: widget.product.price,
      size: widget.product.size,
      id: widget.product.name,
    ));
    Navigator.of(context).pop();

    // verifyS
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.toString())));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log(response.toString());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.toString())));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log(response.toString());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.toString())));
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var options = {
      'key': 'rzp_test_mkzSidhb6RgmDG',
      'amount': 500,
      'name': 'Arun Corp.',
      'description': 'Demo',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    return Scaffold(
      backgroundColor: ScaffoldBgcolor,
      appBar: AppBar(
        backgroundColor: ScaffoldBgcolor,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            )),
        title: const Text(
          'Payment Method',
          style: TextStyle(
              color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                k10height,
                StreamBuilder<List<AddressModel>>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(email)
                        .collection('Address')
                        .snapshots()
                        .map((snapshot) => snapshot.docs
                            .map((e) => AddressModel.fromJson(e.data()))
                            .toList()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AddressModel> Address = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff35383F)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                k20height,
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                k10height,
                                ListTile(
                                  leading: const Icon(
                                    Icons.location_pin,
                                    color: whiteColor,
                                  ),
                                  title: Address.isEmpty ||
                                          Address[0].localArea == ''
                                      ? const Text(
                                          'Add Address',

                                          // AddressModel(localArea: 'Brototype', id: 'Address', state: 'kerala', pincode: '678508', city: 'kochi'),
                                          // 'Brototype ,InfoPark, Kochi 678508',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : SizedBox(
                                          height: 60,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${Address[0].localArea} , ${Address[0].city}',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 16,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '${Address[0].district} , ${Address[0].state}',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 16,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  Address[0].pincode,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 16,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  trailing: '' == ''
                                      ? IconButton(
                                          onPressed: () {
                                            addAddressMethod(context);
                                          },
                                          icon: const Icon(
                                            Icons.add_location_alt_sharp,
                                            color: whiteColor,
                                          ))
                                      : IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.edit,
                                            color: whiteColor,
                                          )),
                                ),
                              ],
                            ),
                          ),
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
                k20height,
                Text(
                  'Select the payment method you want to use.',
                  style: TextStyle(
                      color: whiteColor.withOpacity(0.9),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                k20height,
                PaymentMethodsTile(
                  onTap: () {},
                  ImageUrl:
                      'https://yt3.ggpht.com/ytc/AMLnZu8hEuwIDjx39XqXih5os_s6PVzgsptnGb8Q1tkKvw=s900-c-k-c0x00ffffff-no-rj',
                  Title: 'RazorPay',
                  Radiobutton: Radio<int>(
                      activeColor: whiteColor,
                      // fillColor:,
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      }),
                ),
                k20height,
                PaymentMethodsTile(
                  onTap: () {},
                  ImageUrl:
                      'https://img.freepik.com/premium-vector/cash-delivery_569841-162.jpg?w=2000',
                  Title: 'Cash on Delivery',
                  Radiobutton: Radio<int>(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return whiteColor;
                      }),
                      activeColor: whiteColor,
                      // fillColor:,
                      value: 2,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                        //selected value
                      }),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TotalPriceBottomWidget(
              onTap: () {
                if (_value == 1) {
                  razorpay.open(options);
                } else {
                  addorder(
                      orderModel: OrderedProduct(
                    cartprice: widget.product.price * 1,
                    description: widget.product.description,
                    images: widget.product.images,
                    isCanceled: false,
                    name: widget.product.name,
                    isDelivered: false,
                    orderquantity: 1,
                    price: widget.product.price,
                    size: widget.product.size,
                    id: widget.product.name,
                  ));
                  cashonDelivery(context);
                }
              },
              Title: 'Total cost',
              totalPrice: widget.product.price.toString(),
              selectPayments: 'Confirm Payment',
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> cashonDelivery(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Text(
              'Order Successfull',
              textAlign: TextAlign.center,
              style: TextStyle(color: ScaffoldBgcolor),
            ),
            content: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgL54f8y2KvkViOnugSECHrjF6P0VazvrhZg&usqp=CAU',
                      width: 150.w,
                      height: 150.h,
                    ),
                    k20height,
                    const Text(
                      'For more details,\n check Delivery Status',
                      //maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ScaffoldBgcolor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[900])),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK")),
              ),
            ],
          );
        });
  }

  Future<dynamic> addAddressMethod(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            scrollable: true,
            title: const Text(
              'Add Address',
              textAlign: TextAlign.center,
              style: TextStyle(color: ScaffoldBgcolor),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextfieldContainer(
                      Controller: localareaController,
                      hinttext: 'Local Area',
                      leadingIcon: const Icon(
                        Icons.not_listed_location_rounded,
                        color: whiteColor,
                      ),
                    ),
                    k30height,
                    TextfieldContainer(
                      Controller: cityController,
                      hinttext: 'City',
                      leadingIcon: const Icon(
                        Icons.not_listed_location_rounded,
                        color: whiteColor,
                      ),
                    ),
                    k30height,
                    TextfieldContainer(
                      Controller: districtController,
                      hinttext: 'District',
                      leadingIcon: const Icon(
                        Icons.not_listed_location_rounded,
                        color: whiteColor,
                      ),
                    ),
                    k30height,
                    TextfieldContainer(
                      Controller: stateController,
                      hinttext: 'State',
                      leadingIcon: const Icon(
                        Icons.not_listed_location_rounded,
                        color: whiteColor,
                      ),
                    ),
                    k30height,
                    TextfieldContainer(
                      keyboardType: TextInputType.number,
                      Controller: pincodeController,
                      hinttext: 'Pincode',
                      leadingIcon: const Icon(
                        Icons.not_listed_location_rounded,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ScaffoldBgcolor)),
                    onPressed: () {
                      addAddressFun(
                          addressModel: AddressModel(
                              district: districtController.text,
                              localArea: localareaController.text,
                              id: 'Address',
                              state: stateController.text,
                              pincode: pincodeController.text,
                              city: cityController.text));
                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit")),
              ),
            ],
          );
        });
  }
}
