part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddtoCart extends CartEvent {
  AddtoCart({required this.context, required this.cartModel});
  CartModel cartModel;
  final context;
}

class RemoveFromCart extends CartEvent {
  RemoveFromCart({required this.context, required this.cartModel});
  CartModel cartModel;
  final context;
}

class IncrementCount extends CartEvent {
  IncrementCount(
    this.orderquantity,
  );
  int orderquantity;
}

class DecrementCount extends CartEvent {
  DecrementCount(
    this.orderquantity,
  );
  int orderquantity;
}
