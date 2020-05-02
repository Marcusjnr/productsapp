
import 'dart:async';

import 'package:productsapp/model/Cart.dart';
import 'bloc.dart';

class CartBloc implements Bloc{
  List<CartModel> cartList = [];
  final _cartListController = StreamController<List<CartModel>>.broadcast();
  final _valueController = StreamController<int>.broadcast();
  final _payController = StreamController<int>.broadcast();

  Stream<List<CartModel>> get carts => _cartListController.stream;
  Stream<int> get payStream => _payController.stream;
  Stream<int> get valueStream => _valueController.stream;


  Function(List<CartModel>) get cartChanged => _cartListController.sink.add;

  void updateCartList(CartModel cart) {
    cartList.add(cart);
    _cartListController.sink.add(cartList);
}

void removeFromCartList(int position){
    cartList.removeAt(position);
    _cartListController.stream;
}


  @override
  void dispose() {
    // TODO: implement dispose
    _cartListController?.close();
    _valueController?.close();
    _payController?.close();
  }

}

CartBloc cartBloc = CartBloc();