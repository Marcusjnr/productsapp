
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:productsapp/Authentication.dart';
import 'package:productsapp/bloc/home_bloc.dart';
import 'package:productsapp/model/Products.dart';
import 'package:productsapp/screens/cart_screen.dart';
import 'package:productsapp/screens/photoupload.dart';
import 'package:productsapp/screens/single_item.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  HomePage({
   this.auth,
   this.onSignedOut
});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final uuid = Uuid();
  static final String imgTag = uuid.v4();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.addToList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(
            fontSize: 25.0,
            fontFamily: "Sans",
            color: Colors.grey,
            fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (content){
                    return CartScreen();
                  })
              );
            },
            icon: Icon(Icons.shopping_cart, color: Colors.grey,),
          )
        ],
      ),
      body: Container(
            child: buildProducts(homeBloc)
          ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.home, color: Color(0xFF6E48AA),),
                iconSize: 23.0,
                color: Colors.white,
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (content){
                        return CartScreen();
                      })
                  );
                },
                icon: Icon(Icons.shopping_cart,color: Colors.grey,),
                iconSize: 23.0,
                color: Colors.white,
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (content){
                      return UploadPhotoPage();
                    })
                  );
                },
                icon: Icon(Icons.add_a_photo, color: Colors.grey,),
                iconSize: 23.0,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProducts(HomeBloc bloc){
    return StreamBuilder<List<Products>>(
      stream: bloc.products,
      builder: (context, snapshot){
        final products = snapshot.data;

        if(products == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(products.isEmpty){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _buildProductsResults(products);
      },
    );
  }

  Widget _buildProductsResults(List<Products> products){
    return GridView.builder(
      shrinkWrap: true,
        primary: false,
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 17.0,
            childAspectRatio: 0.545,
        ),
        itemBuilder: (_, index){
          return productsUI(
              products[index].image,
              products[index].description,
              products[index].date,
              products[index].time,
              products[index].price,
              products[index].title
          );
        }
    );
  }

  void _logOutUser() async {
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e.toString());
    }
  }

  Widget productsUI(String image , String description, String date,String time, String price,String title){
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (content){
              return SingleItemScreen(
                imageUrl: image,
                description: description,
                date: date,
                time: time,
                title: title,
                price: price,
              );
            })
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return new Material(
                                color: Colors.black54,
                                child: Container(
                                  padding: EdgeInsets.all(30.0),
                                  child: InkWell(
                                    child: SizedBox(
                                      width: 300.0,
                                      height: 300.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25.0),
                                        child: Card(
                                          elevation: 2.0,
                                          child: CachedNetworkImage(
                                            imageUrl: image,
                                            fit: BoxFit.cover,
                                            color: Colors.black54,
                                            colorBlendMode: BlendMode.overlay,
                                            placeholder: (context, url) =>
                                                Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.3,
                        width: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            color: Colors.black54,
                            colorBlendMode: BlendMode.overlay,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 7.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                     title,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black54,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      '$price NGN',
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black54,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
