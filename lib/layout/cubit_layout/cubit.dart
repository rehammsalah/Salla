
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/states.dart';
import 'package:salla/models/change_fav.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/moduls/categories_screen.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';
import 'package:salla/shared/networks/remote/dio_helper.dart';
import '../../models/category_model.dart';
import '../../models/category_products_model.dart';
import '../../models/get_favorite.dart';
import '../../models/login_model.dart';
import '../../moduls/favorites_screen.dart';
import '../../moduls/home_screen.dart';
import '../../moduls/profile_screen.dart';
import '../../shared/constants.dart';
import '../../shared/networks/endpoint.dart';

class LayoutCubit extends Cubit<States>{

  LayoutCubit (): super(InitState());

  static LayoutCubit get(context) => BlocProvider.of(context);



  int index=0;
  List<Widget> screens =[

    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  void tapped (int indx){

    index=indx;
  emit(ChangeNavBar());
    }




    Map<int,bool> fav = {};
  HomeModel ? homemodel;
    void GetHomeData(){

      emit(LoadingHomeState());
      diohelper.getdata(
        url: HOME,
        token: cache.getdata(key: 'Token'),
      ).then((value) {
         homemodel = HomeModel.fromjson(value.data);
       
        homemodel!.data.products.forEach((element) {

          fav.addAll({

            element.id: element.inFav,

          });

        });
         print(' Products Length ${homemodel!.data.products.length}');
         emit(SuccessHomeState());
        print(fav);
      }).catchError((error){

        print(error.toString());
        emit(ErrorHomeState());

      });


      }

  CategoryModel ? categorymodel;
  void GetCategoryData(){

    emit(LoadingCategoryState());
    diohelper.getdata(
        url: CATEGORY,
    ).then((value) {
      categorymodel = CategoryModel.fromjson(value.data);
     // print(categorymodel!.data!.data[1].name!);
      emit(SuccessCategoryState());

    }).catchError((error){

      print(error.toString());
      emit(ErrorCategoryState());

    });


  }


  ChangeFav ? changefav ;
  void postFavData(int ? productID){

    fav[productID!]=!fav[productID]!;
    emit(LoadingFavState());
    diohelper.postdata(
      token: cache.getdata(key: 'Token'),
        url: FAV,
        data:
        {
          'product_id':productID,

        }

    ).then((value){


      changefav = ChangeFav.fromjson(value.data);

      if(changefav!.status==false){
        fav[productID]=!fav[productID]!;
      }
      else
        {
          GetFavData();
        }

      print(changefav!.status);
      print('msggggggggggg '+changefav!.msg);

      emit(SuccessFavState(changefav));

    }).catchError((error){
      fav[productID]=!fav[productID]!;
      emit(ErrorFavState());
      print(error.toString());
    });



  }




  GetFavModel ? getfavmodel;
  void GetFavData(){

    emit(LoadingGetFavState());
    diohelper.getdata(
      url: FAV,
      token: cache.getdata(key: 'Token'),
    ).then((value) {
      getfavmodel = GetFavModel.fromjson(value.data);
      emit(SuccessGetFavState());

    }).catchError((error){

      print(error.toString());
      emit(ErrorGetFavState());

    });


  }


  Model ? userLogin;
  void GetUserData(){

    emit(LoadingGetUserDataState());
    diohelper.getdata(
      url: PROFILE,
      token: cache.getdata(key: 'Token'),
    ).then((value) {

      userLogin = Model.fromjson(value.data);
      print('nameeeeeeeeeeeeeeeeeeeeeeeeeeeeee'+userLogin!.data.name);
      emit(SuccessGetUserDataState());

    }).catchError((error){

      print(error.toString());
      emit(ErrorGetUserDataState());

    });


  }
  DataModel ? datamodel  ;
  void ChangeCategoryColor(int index){

    categorymodel!.data!.data[index].selected = true;
    categorymodel!.data!.data.forEach((element) {
      if(element !=categorymodel!.data!.data[index])
        {
          element.selected=false;
          tap=false;
        }
    });

    emit(ChangeColorState());
  }

  bool  tap = true  ;
  void ChangeAllButtonColor(){
    tap=true;
    categorymodel!.data!.data.forEach((element) {

        element.selected=false;
      });

    emit(ChangeAllButtonColorState());
  }



  CategoryProductModel ? categoryProductModel ;
  void  GetCategoryProduct (int CategoriID){

    emit(LoadingGetCategoryProductState());
    diohelper.getdata(
        url: PRODUCTS,
        token: cache.getdata(key: 'Token'),
        query: {
          'category_id':CategoriID
        }
    ).then((value) {

      categoryProductModel = CategoryProductModel.fromjson(value.data);
      print('First category Product Name'+categoryProductModel!.data.data[0].name);
      print('First category Product Length ${categoryProductModel!.data.data.length}');


      /*else{
        categoryProductModel!.data!.data.forEach((element) {
          if(CategoriID !=categoryProductModel!.data!.data[index].id)

            {
              element.id=00 ;
              element.image='R';
              element.disc=00;
              element.oldPrice=0;
              element.price=0;
              element.name='R';
            }



        });
      }*/
      print('First category Product Name'+categoryProductModel!.data.data[0].name);
      emit(SuccessGetCategoryProductState());

    }).catchError((error){

      print(error.toString());
      emit(ErrorGetCategoryProductState());

    });


  }

  int  len = 10;
  void ChangeListLengthZeroButton (){
    len = homemodel!.data.products.length;
    emit(ChangeListLengthZeroButtonState());

  }
  void ChangeListLengthOthersButton (){
    len = categoryProductModel!.data.data.length;
    emit(ChangeListLengthOthersButtonState());

  }

  bool seeall = false;
  void ChangeSeeAll (){
    seeall = true;
    emit(ChangeSeeAllState());

  }


  int ? productid ;
  void GetProductID (int id){
    productid = id;
    emit(GetProductIDState());

  }




  int ? imagelength ;
  void GetImageLength (int length){
    imagelength = length;
    emit(GetImageLengthState());

  }



}
