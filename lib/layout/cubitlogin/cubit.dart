import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubitlogin/states.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/models/login_model.dart';
import 'package:salla/moduls/categories_screen.dart';
import 'package:salla/moduls/favorites_screen.dart';
import 'package:salla/shared/networks/endpoint.dart';
import 'package:salla/shared/networks/remote/dio_helper.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import '../../moduls/home_screen.dart';
import '../../moduls/profile_screen.dart';


class loginCubit extends Cubit<loginState>{

   Model ? model ;
   UserLogin ? userLogin ;

   late HomeModel homemodel ;
  loginCubit() :  super(initState());
  static loginCubit get(context) => BlocProvider.of(context);

  void userlogin ({

    required String email,
    required String password,

  }){

    emit(loadingState());
    diohelper.postdata(
        url: LOGIN,
        data: {
          'email':email,
          'password':password

        },


    ).then((value) {


    model =  Model.fromjson(value.data);

    print(model!.message);
    print(model!.status);

    emit(successState(model!));

    }).catchError((error){



      print("errrrrrrrrrrrrrrrrrror"+error.toString());
      emit(errorState(error.toString()));

    });
    
    
  }


  Widget icon = Icon(Icons.visibility_outlined);
  bool secured =true;
  void changeIcon(
  ){

    secured =!secured;
    secured? icon=Icon(Icons.visibility_outlined) :icon=Icon(Icons.visibility_off_outlined);

    emit(ChangePasswordState());

  }


  void UpdateUserData(
      String ? name,
      String ? email,
      String ? phone,

      ){


    emit(LoadingUpdateUserDataState());
    diohelper.putdata(
        token: cache.getdata(key: 'Token'),
        url: UPDATE,
        data:
        {
          'name':name,
          'email':email,
          'phone':phone,


        }

    ).then((value){




      model = Model.fromjson(value.data);
      print(model!.data.name);
      emit(SuccessUpdateUserDataState(model!));

    }).catchError((error){

      emit(ErrorUpdateUserDataState());
      print(error.toString());
    });



  }




  }





