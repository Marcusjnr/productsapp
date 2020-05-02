import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:productsapp/bloc/Validators.dart';
import 'package:productsapp/bloc/bloc.dart';
import 'package:productsapp/screens/HomePage.dart';

class UploadBloc with Validators implements Bloc{
  File sampleImage;
  String url;

  final _descriptionController = StreamController<String>.broadcast();
  final _priceController = StreamController<String>.broadcast();
  final _imageController = StreamController<File>.broadcast();
  final _titleController = StreamController<String>.broadcast();
  String myValue;
  String priceValue;
  String titleValue;
  String uploadText;

  Stream<File> get image => _imageController.stream;
  Stream<String> get myTitle => _titleController.stream;
  Stream<String> get myDescription => _descriptionController.stream;
  Stream<String> get myPrice => _priceController.stream;


  Function(String) get myDescriptionChanged => _descriptionController.sink.add;
  Function(String) get myPriceChanged => _descriptionController.sink.add;
  Function(String) get myTitleChanged => _titleController.sink.add;

  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: tempImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );
    sampleImage = croppedFile;
    _imageController.sink.add(sampleImage);
  }

  void updateDescription(String value){
    myValue = value;
    _descriptionController.sink.add(value);
  }

  void updateTitle(String value){
    titleValue = value;
    _titleController.sink.add(value);
  }

  void updatePrice(String value){
    priceValue = value;
    _priceController.sink.add(value);
  }


  void uploadStatusImage(BuildContext context) async {
      final StorageReference productImageRef = FirebaseStorage.instance.ref().child("Products Images");

      var timeKey = DateTime.now();

      final StorageUploadTask uploadTask = productImageRef.child('${timeKey.toString()}.jpg').putFile(sampleImage);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = imageUrl.toString();

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return HomePage();
          })
      );
      saveToDatabase(url);
  }

  void saveToDatabase(String url) {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference dbReference = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "title": titleValue,
      "description": myValue,
      "date": date,
      "time":time,
      "price": priceValue
    };

    dbReference.child("Products").push().set(data);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _descriptionController?.close();
    _priceController?.close();
    _imageController?.close();
    _titleController?.close();
  }
}

UploadBloc uploadBloc = UploadBloc();