// import 'dart:convert';

class OrderedProduct {
  final String name;
  final String description;
  final double price;
  final List size;
  final String id;

  final List images;
  int orderquantity = 1;

  double cartprice;
  final bool isDelivered;
  final bool isCanceled;

  OrderedProduct({
    required this.cartprice,
    required this.size,
    required this.id,
    required this.name,
    required this.orderquantity,
    required this.description,
    required this.price,
    required this.images,
    required this.isCanceled,
    required this.isDelivered,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'size': size,
        'cartprice': cartprice,
        'orderquantity': orderquantity,
        'images': images,
        'isDeliverd': isDelivered,
        'isCanceled': isCanceled,
      };

  static OrderedProduct fromJson(Map<String, dynamic> json) => OrderedProduct(
        cartprice: json['cartprice'],
        orderquantity: json['orderquanty'],
        size: json['size'],
        name: json['name'],
        id: json['id'],
        description: json['description'],
        price: json['price'],
        images: json['images'],
        isDelivered: json['isDeliverd'],
        isCanceled: json['isCanceled'],
      );
}
