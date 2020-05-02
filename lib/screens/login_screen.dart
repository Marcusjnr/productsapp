
import 'package:flutter/material.dart';
import 'package:productsapp/Authentication.dart';
import 'package:productsapp/bloc/bloc.dart';
import 'package:productsapp/dialogbox.dart';

class LoginScreen extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  LoginScreen({
    this.auth,
    this.onSignedIn
});


  @override
  _LoginScreenState createState() => _LoginScreenState();

}

enum FormType{
  login,
  register
}
class _LoginScreenState extends State<LoginScreen> {
  DialogBox dialogBox = new DialogBox();
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  bool visible;

  bool validateAndSave(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateAndSubmit() async {
    if(validateAndSave()){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Loading.....'),
            duration: Duration(days: 1),
          ));
      try{
        if(_formType == FormType.login){
          String userId = await widget.auth.signIn(_email, _password);
          print('login user id = $userId');
        }else{
            String userId = await widget.auth.signUp(_email, _password);
            print('register user id = $userId');
        }
        widget.onSignedIn();
      }catch(e){
        dialogBox.information(context, 'Error', e.toString());
      }
    }
  }

  void moveToSignUpScreen(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    setState(() {
      _formType = FormType.login;
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/loginscreenbackground.png"),
              fit: BoxFit.cover,
            )),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.0),
                Color.fromRGBO(0, 0, 0, 0.3)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Form(
                key: formKey,
                child: Container(
                  width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 40.0)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage("assets/img/Logo.png"),
                                height: 70.0,
                              ),
                              Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.0)),

                              /// Animation text treva shop accept from signup layout (Click to open code)
                              Text(
                                "Products App",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.6,
                                    color: Colors.white,
                                    fontFamily: "Sans",
                                    fontSize: 20.0),
                              ),
                            ],
                          ),

                          Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 40.0)),

                          createInputTxt(TextInputType.emailAddress),

                          Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 40.0)),

                          createInputTxt(TextInputType.text),

                          createButtons(),

                        ],
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createInputTxt(TextInputType inputType){
    if(inputType == TextInputType.emailAddress){
      return  StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 60.0,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                padding:
                EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                child: Theme(
                  data: ThemeData(
                    hintColor: Colors.transparent,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.black38,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Sans',
                            letterSpacing: 0.3,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                    keyboardType: inputType,
                    validator: (value){
                      return value.isEmpty
                          ? 'Email is required'
                          : null;
                    },
                    onSaved: (value){
                      return _email = value;
                    },
                  ),
                ),
              ),
            );
          }
      );
    }else{
      return StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 60.0,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                padding:
                EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                child: Theme(
                  data: ThemeData(
                    hintColor: Colors.transparent,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.black38,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Sans',
                            letterSpacing: 0.3,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                    keyboardType: inputType,
                    validator: (value){
                      return value.isEmpty
                          ? 'Password is required'
                          : null;
                    },
                    onSaved: (value){
                      return _password = value;
                    },
                  ),
                ),
              ),
            );
          }
      );
    }
  }


  Widget createButtons(){
    if(_formType == FormType.login){
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: InkWell(
              onTap: (){

                validateAndSubmit();
              },
              child: Container(
                height: 55.0,
                width: 600.0,
                child: Text(
                  "Login",
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

          FlatButton(
              onPressed: (){
                moveToSignUpScreen();
              },
              child: Text(
                "Not Have An Acount?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Sans"),
              )
          )
        ],
      );

    }else{
      return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30.0),
          child: InkWell(
            onTap: (){
              validateAndSubmit();
            },
            child: Container(
              height: 55.0,
              width: 600.0,
              child: Text(
                "Register",
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

        FlatButton(
            padding: EdgeInsets.only(top: 20.0),
            onPressed: (){
              moveToLogin();
            },
            child: Text(
              "Not Have Acount? Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Sans"),
            )
        )
      ],
    );

    }
  }
}
