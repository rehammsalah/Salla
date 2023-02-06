import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cache{

  static  SharedPreferences ? sharedprefrence ;
  static  init() async
  {

    sharedprefrence = await SharedPreferences.getInstance();

  }
  static Future<bool> SaveData ({
    required String key,
    required dynamic value,
  }) async
  {

    if(value is bool)
    return  await sharedprefrence!.setBool(key, value);
    if(value is String)
      return  await sharedprefrence!.setString(key, value);
    if(value is int)
      return  await sharedprefrence!.setInt(key, value);

    return await sharedprefrence!.setDouble(key, value);

  }

  static dynamic getdata({
    required String key,
  })
  {

    return sharedprefrence?.get(key);

  }


  static Future<bool> removeData({
        required key,
      })
  async
  {

    return await sharedprefrence!.remove(key);

  }

}