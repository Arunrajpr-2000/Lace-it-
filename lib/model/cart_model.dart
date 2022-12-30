class CartModel {
  final String name;
  final String description;
  final double price;
  final List size;
  final String id;
  int orderquantity = 1;

  double cartprice;

  final num quantity;
  final List images;
  CartModel(
      {required this.size,
      required this.id,
      // required this.totalcart,
      required this.orderquantity,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.images,
      required this.cartprice});
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'image': images,
        'size': size,
        'docname': id,
        'orderquantity': orderquantity,
        'cartprice': cartprice,
        // 'totalcart': totalcart
      };

  static CartModel fromJson(Map<String, dynamic> json) => CartModel(
      // totalcart: json['totalcart'],
      orderquantity: json['orderquantity'],
      cartprice: json['cartprice'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      images: json['image'],
      size: json['size'],
      id: json['docname']);
}
