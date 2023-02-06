import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import '../moduls/LoginShop.dart';

Widget logout (BuildContext context)
{
  return  TextButton(
    onPressed: () {


      cache.removeData(key: 'Token').then((value) {
        if(value){
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                builder: (context) => loginscreen(),

              ),
                  (Route <dynamic> route) => false

          );

        }


      });


    },
    child: Text('Sign up'),

  );
}