
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/layout/cubit_register/cubit.dart';
import 'package:salla/layout/cubitlogin/cubit.dart';
import 'package:salla/moduls/OnBoardingScreen.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import '../layout/cubit_register/states.dart';
import '../layout/cubitlogin/states.dart';
import '../shared/constants.dart';
import 'LoginShop.dart';

class registerscreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var controlemail = TextEditingController();
  var controlpass = TextEditingController();
  var controlphone = TextEditingController();
  var controlname = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(

        builder:(context, state) =>Scaffold(
          appBar: AppBar(),
          body:Center(

            child: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                child: Form(
                  key: formkey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(

                          'REGISTER',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25,fontWeight: FontWeight.bold)


                      ),
                      SizedBox(height: 10,),
                      Text(

                          'Please register to access our online shopping app',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                            color: Colors.grey,
                          )


                      ),
                      SizedBox(height: 25,),
                      TextFormField(


                        validator: (String ? value) {
                          if(value!.isEmpty)
                            return 'Please enter your name' ;

                          return null;

                        },
                        controller:controlname ,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            )
                        ),

                      ),
                      SizedBox(height: 15,),
                      TextFormField(


                        validator: (String ? value) {
                          if(value!.isEmpty)
                            return 'Please enter your email' ;

                          return null;

                        },
                        controller:controlemail ,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            )
                        ),

                      ),
                      SizedBox(height: 15,),
                      TextFormField(


                        validator: (String ? value) {
                          if(value!.isEmpty)
                            return 'Please enter your phone number' ;

                          return null;

                        },
                        controller:controlphone ,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            )
                        ),

                      ),
                      SizedBox(height: 15,),
                      TextFormField(



                        validator: (String? value) {
                          if(value!.isEmpty)
                            return 'Please enter your password ';

                          return null;

                        },

                        enabled: true,
                        obscureText: RegisterCubit.get(context).secured,
                        obscuringCharacter: '*',
                        controller:controlpass ,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(


                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(

                              icon: RegisterCubit.get(context).icon,
                              onPressed: (){
                                RegisterCubit.get(context).changeIcon();
                              },

                            ),





                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)
                            )
                        ),

                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: MaterialButton(
                            color: Colors.deepOrange,
                            height: 50,
                            padding: EdgeInsets.only(right: 150,left: 150),
                            onPressed: ()
                            {

                              if(formkey.currentState!.validate())
                              {
                                RegisterCubit.get(context).postRegisterData(
                                  name: controlname.text,
                                  email:  controlemail.text,
                                  pass:  controlpass.text,
                                  phone: controlphone.text,
                                );


                              }


                            },
                            child: Text('REGISTER',style: TextStyle(
                                color: Colors.white
                            ),)
                        ),


                      ),

                    ],

                  ),
                ),
              ),
            ),
          ),
        ),
        listener: (context, state){
          if(state is SuccessPostUserDataState)
          {

            if(state.registermodel.status)
            {

              cache.SaveData(key: 'Token', value: state.registermodel.data.token).then((value) {
                token=state.registermodel.data.token;
                Navigator.pushAndRemoveUntil(

                    context,
                    MaterialPageRoute(
                      builder: (context) => onboardingscreen(),

                    ),
                        (Route <dynamic> route) => false
                );
              });

              Fluttertoast.showToast(
                  msg: state.registermodel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ChooseColor(state: ToastColor.Success),
                  textColor: Colors.black,
                  fontSize: 16.0
              );
            }
            else{
              Fluttertoast.showToast(
                  msg: state.registermodel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ChooseColor(state: ToastColor.Error),
                  textColor: Colors.black,
                  fontSize: 16.0
              );
            }



          }

        },

      ),
    );
  }
}
