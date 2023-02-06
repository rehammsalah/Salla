import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/layout/cubit_layout/states.dart';
import 'package:salla/layout/cubitlogin/cubit.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import 'LoginShop.dart';
import 'categories_screen.dart';



class HomeLayout extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,States>(

        builder:(context,state){

          var cubit = LayoutCubit.get(context);
          if(cubit.seeall==true)
          {
            cubit.tapped(1);
            cubit.seeall=false;

          }
          return Scaffold(

            appBar: AppBar(

              title: Text('Salla',style: TextStyle(color: Colors.black, fontFamily: 'Cfont',)),

              actions: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.search),

                ) ,
              ],





























              elevation: 1,
              ),


            body: cubit.seeall==true? CategoriesScreen():cubit.screens[cubit.index],

            bottomNavigationBar: BottomNavigationBar(



              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.index,
              onTap: (index){
                cubit.seeall=false;
                cubit.tapped(index);
              },
              items: [

                BottomNavigationBarItem(

                icon: Icon(Icons.home),
                label: 'Home',
              ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Products',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                )],
            ),

          );
        } ,
        listener:(context,state){} ,
      );
  }
}
