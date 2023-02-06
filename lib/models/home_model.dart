import 'dart:convert';

import 'package:flutter/cupertino.dart';

class HomeModel{

  late bool  status;
  late HomeModelData data ;


   HomeModel.fromjson(Map<String,dynamic> json)
   {
     status =  json['status'];
     data = HomeModelData.fromjson(json['data']);
   }

}

class HomeModelData{

 late List <BannerModel> banners =[] ;
  late  List <BroductModel>  products =[] ;

  HomeModelData.fromjson(Map<String , dynamic> json)
  {




    json['banners'].forEach((element){
      banners.add(BannerModel.fromjson(element));
    });

    json['products'].forEach((element){
      products.add(BroductModel.fromjson(element));
    });



  }


}

class BannerModel {

  late int id;
  late String image;

  BannerModel.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }


}
class BroductModel {



  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String image;
  late String name;
  late bool inFav;
  late bool inCart;
  late int disc;
  late String description;
  List<String> images = [];




  BroductModel.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    name = json['name'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];
    image = json['image'];
    disc = json['discount'];
    description = json['description'];

    json['images'].forEach((element) {
     images.add(element);
    });
  }

}

