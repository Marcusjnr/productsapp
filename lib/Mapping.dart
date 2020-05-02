

import 'package:flutter/material.dart';
import 'package:productsapp/Authentication.dart';
import 'package:productsapp/screens/HomePage.dart';
import 'package:productsapp/screens/login_screen.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;

  MappingPage({
    this.auth
});

  @override
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((fireBaseUserId){
      setState(() {
        authStatus = fireBaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    }).catchError((onError){
      authStatus = AuthStatus.notSignedIn;
    });;
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signOut(){

  }
  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return LoginScreen(
          auth: widget.auth,
          onSignedIn: _signedIn
        );

      case AuthStatus.signedIn:
        return HomePage(
            auth: widget.auth,
            onSignedOut: _signOut
        );
    }
    return null;
  }
}
