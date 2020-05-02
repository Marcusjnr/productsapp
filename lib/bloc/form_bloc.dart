import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productsapp/bloc/Validators.dart';
import 'package:productsapp/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

enum FormType{
  login,
  register
}

class FormBloc extends Object with Validators implements Bloc{
final _emailController = StreamController<String>.broadcast();
final _passwordController = StreamController<String>.broadcast();
final _formTypeController = StreamController<FormType>.broadcast();

Function(String) get emailChanged => _emailController.sink.add;
Function(String) get passwordChanged => _passwordController.sink.add;

 void formTypeChanged(FormType value){
  _formTypeController.sink.add(value);
}

Stream<String> get email => _emailController.stream.transform(emailValidator);
Stream<String> get password => _passwordController.stream.transform(passwordValidator);
Stream<FormType> get formType => _formTypeController.stream;

Stream<bool> get submitCheck => Rx.combineLatest2(email, password, (e,p) => true);

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController?.close();
    _passwordController?.close();
    _formTypeController?.close();
  }
}

FormBloc switchFormBloc = FormBloc();