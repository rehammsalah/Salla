
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/states.dart';
import 'package:salla/layout/cubit_register/states.dart';
import 'package:salla/models/change_fav.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/moduls/categories_screen.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';
import 'package:salla/shared/networks/remote/dio_helper.dart';
import '../../models/category_model.dart';
import '../../models/get_favorite.dart';
import '../../models/login_model.dart';
import '../../moduls/favorites_screen.dart';
import '../../moduls/home_screen.dart';
import '../../moduls/profile_screen.dart';
import '../../shared/constants.dart';
import '../../shared/networks/endpoint.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit (): super(InitRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  Widget icon = Icon(Icons.visibility_outlined);
  bool secured =true;
  void changeIcon(
      ){

    secured =!secured;
    secured? icon=Icon(Icons.visibility_outlined) :icon=Icon(Icons.visibility_off_outlined);

    emit(ChangePasswordRegisterState());

  }

  Model ? userRegister ;
  void postRegisterData({

  required String name,
    required String email,
    required String pass,
    required String phone,


}){


    emit(LoadingPostUserDataState());
    diohelper.postdata(
        url: REGISTER,
        data:
        {
          'name':name,
          'phone':phone,
          'email':email,
          'password':pass,

        }

    ).then((value){


      userRegister = Model.fromjson(value.data);
      print(userRegister!.status);
      print(userRegister!.message);


      emit(SuccessPostUserDataState(userRegister!));

    }).catchError((error){

      emit(ErrorPostUserDataState());
      print(error.toString());
    });



  }

  }
