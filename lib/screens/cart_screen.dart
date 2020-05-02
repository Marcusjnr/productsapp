

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:productsapp/bloc/cart_bloc.dart';
import 'package:productsapp/model/Cart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(
            fontSize: 25.0,
            fontFamily: "Sans",
            color: Colors.grey,
            fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: buildCartList(cartBloc),
        ),
      ),
    );
  }

  Widget buildCartList(CartBloc bloc){
    return StreamBuilder<List<CartModel>>(
      stream: bloc.carts,
      builder: (context, snapshot){
        final cartItems = snapshot.data;
        print(cartItems);
        if(cartBloc.cartList == null){
          return Center(
            child: Text("No Items In the Cart"),
          );
        }

        return _buildCartResults(cartBloc.cartList);
      },
    );
  }

  Widget _buildCartResults(List<CartModel> cartItems) {
    return ListView.builder(
      itemCount: cartItems.length,
        itemBuilder: (context, index){
            return Slidable(
              delegate: new SlidableDrawerDelegate(),
              actionExtentRatio: 0.25,
              actions: <Widget>[
                IconSlideAction(
                  key: Key(index.toString()),
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    setState(() {
                      cartBloc.removeFromCartList(index);
                    });

                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Items Cart Deleted"),duration: Duration(seconds: 2),backgroundColor: Colors.redAccent,));
                  },
                ),
              ],
              secondaryActions: <Widget>[
                 IconSlideAction(
                  key: Key(index.toString()),
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    setState(() {
                      cartBloc.removeFromCartList(index);
                    });

                    ///
                    /// SnackBar show if cart delet
                    ///
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("Items Cart Deleted"),duration: Duration(seconds: 2),backgroundColor: Colors.redAccent,));
                  },
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 13.0, right: 13.0),
                /// Background Constructor for card
                child: Container(
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 3.5,
                        spreadRadius: 0.4,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10.0),

                              /// Image item
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12.withOpacity(0.1),
                                            blurRadius: 0.5,
                                            spreadRadius: 0.1)
                                      ]),
                                  child: SizedBox(
                                    width: 120.0,
                                    height: 130.0,
                                    child: Card(
                                      child: CachedNetworkImage(
                                        imageUrl: '${cartItems[index].imageUrl}',
                                        fit: BoxFit.cover,
                                        color: Colors.black54,
                                        colorBlendMode: BlendMode.overlay,
                                        placeholder: (context, url) =>
                                            Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  ))),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0, left: 10.0, right: 5.0),
                              child: Column(

                                /// Text Information Item
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${cartItems[index].title}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Sans",
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10.0)),
                                  Text(
                                    '${cartItems[index].description}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10.0)),
                                  Text('${cartItems[index].price}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 8.0)),
                      Divider(
                        height: 2.0,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
    );
  }
}
