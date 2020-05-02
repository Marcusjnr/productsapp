

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:productsapp/screens/HomePage.dart';
import 'package:productsapp/bloc/upload_bloc.dart';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  final formKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<File>(
      stream: uploadBloc.image,
      builder: (context, snapshot) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Photo Upload", style: TextStyle(
                fontSize: 25.0,
                fontFamily: "Sans",
                color: Colors.grey,
                fontWeight: FontWeight.w700),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),

          body: Center(
            child: snapshot.data == null ? Text("Select an image") : enableUpload(snapshot.data),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: uploadBloc.getImage,
            child: Icon(Icons.add_a_photo),
          ),
        );
      }
    );
  }

  Widget enableUpload(File sampleImage){
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key:  formKey,
        child: ListView(
          children: <Widget>[
            Image.file(sampleImage, height: 310.0, width: 660.0,),
            SizedBox(height: 15.0,),

            TextFormField(
              decoration: new InputDecoration(
                labelText: "Title",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                 borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                return val.isEmpty
                    ? 'Title is required'
                    : null;
              },
              onChanged: (value){
                return uploadBloc.updateTitle(value);
              },
              style: new TextStyle(
                fontFamily: "Sans",
              ),
            ),
            SizedBox(height: 15.0,),

            TextFormField(
              decoration: new InputDecoration(
                labelText: "Description",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                return val.isEmpty
                    ? 'Description is required'
                    : null;
              },
              onChanged: (value){
               return uploadBloc.updateDescription(value);
              },
              style: new TextStyle(
                fontFamily: "Sans",
              ),
            ),

            SizedBox(height: 15.0,),

            TextFormField(
              decoration: new InputDecoration(
                labelText: "Price",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                return val.isEmpty
                    ? 'Price is required'
                    : null;
              },
              onChanged: (value){
                return uploadBloc.updatePrice(value);
              },
              keyboardType: TextInputType.number,
              style: new TextStyle(
                fontFamily: "Sans",
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: (){
                  if(validateAndSave()){
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Uploading Product.......'),
                          duration: Duration(days: 1),
                        ));
                    uploadBloc.uploadStatusImage(context);
                  }


                },
                child: Container(
                  height: 55.0,
                  width: 600.0,
                  child: Text(
                    "Add a new Product",
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
            ),
          ],
        ),
      ),
    );
  }

  void goToHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return HomePage();
        })
    );
  }
}
