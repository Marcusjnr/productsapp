import 'dart:async';

mixin Validators{
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains("@")){
        sink.add(email);
      }else{
        sink.addError("Email is not valid");
      }
    }
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink){
        if(password.length > 4){
          sink.add(password);
        }else{
          sink.addError("Password Length should be greater than 4 chars");
        }
      }
  );

  var descriptionValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (description, sink){
      if(description.isEmpty){
        sink.addError("Must contain a description");
      }else{
        sink.add(description);
      }
    }
  );

  var priceValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (price, sink){
        if(price.isEmpty){
          sink.addError("Must contain a description");
        }else{
          sink.add(price);
        }
      }
  );
}