import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:lace_it/core/snackbar/snackbarAuth.dart';
import 'package:lace_it/function/cart_fun.dart';
import 'package:lace_it/model/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddtoCart>((event, emit) {
      addtoCart(
        CartModel: event.cartModel,
      );
      Utils.showSnackBar(context: event.context, text: 'Added to cart');

      emit(state);
    });

    on<RemoveFromCart>((event, emit) {
      removeFromCart(id: event.cartModel.id);
      Utils.showSnackBar(context: event.context, text: 'Removed From Cart');

      emit(state);
    });

    on<IncrementCount>((event, emit) {
      emit(CartState(
          cartModel: state.cartModel, orderquantity: state.orderquantity + 1));
    });
    on<DecrementCount>((event, emit) {
      emit(CartState(
          cartModel: state.cartModel,
          orderquantity: state.orderquantity <= 0
              ? state.orderquantity
              : state.orderquantity - 1));
    });
  }
}
