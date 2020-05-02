
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:productsapp/bloc/bloc.dart';
import 'package:productsapp/model/Products.dart';

class HomeBloc implements Bloc{
  List<Products> productsList = [];
  final _productListController = StreamController<List<Products>>.broadcast();

  Stream<List<Products>> get products => _productListController.stream;

  Future addToList() async{
    DatabaseReference productRef = FirebaseDatabase.instance.reference().child("Products");
    productRef.once().then((DataSnapshot snap){
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      productsList.clear();

      for(var individualKey in KEYS){
        Products products = new Products(
            DATA[individualKey] ['image'],
            DATA[individualKey] ['description'],
            DATA[individualKey] ['date'],
            DATA[individualKey] ['time'],
            DATA[individualKey] ['price'],
            DATA[individualKey] ['title']
        );

        productsList.add(products);
        _productListController.sink.add(productsList);
      }
    });

    return productsList;

  }



  @override
  void dispose() {
    // TODO: implement dispose
      _productListController?.close();
  }

}

HomeBloc homeBloc = HomeBloc();