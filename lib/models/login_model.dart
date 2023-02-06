import 'dart:core';

import 'dart:core';

class Model {

  late bool status;
  late  String message;
   late UserLogin data;

  Model.fromjson(Map<String,dynamic> json){

    status=json['status'] as bool;

    if (json['message']!= null)
    message=json['message'] as String;



    json['data']!=null ? data = UserLogin.fromjson(json['data']) : null ;
  }
}
class UserLogin{

 late int id ;
 late String name ;
 late String email;
 late String phone;
 late String image;
 late int points;
 late int credit;
 late String token;

 UserLogin.fromjson(Map<String,dynamic> json){

   if (json['id']!= null)
   id = json['id'] as int;

    name = json['name'] as String;
    email = json['email'] as String;
    phone= json['phone'] as String;
    image = json['image'] as String;

   if (json['points']!= null)
     points = json['points'] as int;

   if (json['credit']!= null)
     credit = json['credit'] as int;
   if (json['token']!= null)
    token = json['token'] as String;
 }




}