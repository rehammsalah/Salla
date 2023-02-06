import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class diohelper
{
  static  Dio ? dio;
  static init (){

    dio = Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,


      ),


    );
  }
  static Future<Response> getdata ({
    required String url,
    String ? token,
    Map<String,dynamic>? query,


  })async{


    dio!.options.headers = {

      'Authorization': token??'',
      'Content-Type' : 'application/json',
      'lang' : 'en'

    };
    return await dio!.get(url,queryParameters: query,);


  }


  static Future<Response> postdata ({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic> ?query,
    String ? token,

  })async{

    dio!.options.headers = {

      'Authorization': token!=null?token:'',
      'Content-Type' : 'application/json',
      'lang' : 'en'

    };
    return dio!.post(
        url,
      data: data,


    );


  }

  static Future<Response> putdata ({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic> ?query,
    String ? token,

  })async{

    dio!.options.headers = {

      'Authorization': token!=null?token:'',
      'Content-Type' : 'application/json',
      'lang' : 'en'

    };
    return dio!.put(
      url,
      data: data,


    );


  }



}