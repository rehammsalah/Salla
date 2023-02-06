import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/layout/cubitlogin/cubit.dart';
import 'package:salla/moduls/LoginShop.dart';
import 'package:salla/moduls/OnBoardingScreen.dart';
import 'package:salla/moduls/ShopLayout.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';
import 'package:salla/shared/networks/remote/dio_helper.dart';
import 'package:salla/shared/styles/block_observer.dart';
import 'package:salla/shared/styles/themes.dart';

void main() async {
  diohelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await cache.init();

  Widget widget;
  bool ? boarding  = cache.getdata(key: 'OnBoarding');
  String ? token  = cache.getdata(key: 'Token');

  //print(token);
  if(boarding == null)
    {
      boarding = false;
      widget=onboardingscreen();
    }
  else
    {

      if(token==null)
        {
          widget = loginscreen();
        }
      else
        {
          widget = HomeLayout();
        }



    }

      runApp(MyApp(widget));
}
class MyApp extends StatelessWidget
{

  Widget widget;
  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()..GetHomeData()..GetCategoryData()..GetFavData()..GetUserData()..GetCategoryProduct(44)),
        BlocProvider(create: (context)=>loginCubit())
      ],
      child: MaterialApp(



        theme: lighttheme ,
        darkTheme: darktheme ,
        themeMode: ThemeMode.light,

        title: 'reham',
        home: onboardingscreen(),
        debugShowCheckedModeBanner: false,
      ),
    );



  }

}
