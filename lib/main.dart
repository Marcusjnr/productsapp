import 'package:flutter/material.dart';
import 'package:productsapp/Authentication.dart';
import 'package:productsapp/Mapping.dart';
import 'package:productsapp/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Products App",
      home: MappingPage(auth: Auth(),),
    );
  }
}

