
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:productsapp/bloc/cart_bloc.dart';
import 'package:productsapp/model/Cart.dart';
import 'package:productsapp/model/Products.dart';

class SingleItemScreen extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String date;
  final String time;
  final String price;
  final String title;

  SingleItemScreen({
    this.imageUrl,
    this.description,
    this.date,
    this.time,
    this.price,
    this.title
});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 470.0,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.overlay,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
              margin: EdgeInsets.only(top: 450),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height - 450),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Column(children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(title,
                            style:
                            TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                      ),

                      Container(
                        child: Text(time,
                            style:
                            TextStyle(fontSize: 16.0, color: Colors.grey)),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                ),


                Container(
                  margin: EdgeInsets.only(top: 28.0),
                  width: MediaQuery.of(context).size.width,
                  child:  Text(description, style: TextStyle(fontSize: 16.0, color: Colors.grey),)
                ),

                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('$price NGN',
                          style:
                          TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),

                    InkWell(
                      onTap: (){
                        CartModel carts = CartModel(imageUrl,description,title,price);
                        cartBloc.cartChanged;
                        cartBloc.updateCartList(carts);
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          content: new Text('Added To cart'),
                        ));
                      },
                      child: Container(
                        height: 45.0,
                        width: 150.0,
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.2,
                              fontFamily: "Sans",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800),
                        ),
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                                colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
                      ),
                    ),
                  ],
                ),
              ])),

          Container(
            margin: EdgeInsets.only(top: 57),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 30.0)),
                Visibility(
                  visible: false,
                  child: Text("Title", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
