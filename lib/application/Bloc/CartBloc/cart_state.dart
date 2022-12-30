part of 'cart_bloc.dart';

@immutable
class CartState {
  CartState({
    required this.cartModel,
    required this.orderquantity,
  });
  List<CartModel> cartModel;
  int orderquantity;
}

class CartInitial extends CartState {
  CartInitial() : super(cartModel: [], orderquantity: 1);
}
