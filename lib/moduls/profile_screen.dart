
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/layout/cubitlogin/cubit.dart';
import 'package:salla/layout/cubitlogin/states.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import 'LoginShop.dart';

class SettingsScreen extends StatelessWidget {
  @override
  var formkey = GlobalKey<FormState>();
  var controlemail = TextEditingController();
  var controlphone = TextEditingController();
  var controlname = TextEditingController();

  Widget build(BuildContext context) {

    var model = loginCubit.get(context).model;
    return  BlocConsumer<loginCubit,loginState>(

      builder : (context, state) =>ConditionalBuilder(
        builder:(context)=> SingleChildScrollView(
                scrollDirection: Axis.vertical,
                

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                  child: Form(


                    key: formkey,
                    child: Column(


                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Center(
                          child: Text(

                            'HI,',
                            style: TextStyle(
                              fontFamily: 'Cfont',
                              fontSize: 25.0,
                              //fontWeight: FontWeight.w400
                            ),


                          ),
                        ),

                        Center(
                          child: Text(

                            '${model!.data.name}',
                            style: TextStyle(
                              fontFamily: 'Cfont',
                              fontSize: 20.0,
                              //fontWeight: FontWeight.w400
                            ),


                          ),
                        ),
                        Center(
                          child: Text(

                            '${model!.data.email}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Cfont',
                              fontSize: 15.0,
                              //fontWeight: FontWeight.w400
                            ),


                          ),
                        ),
                        SizedBox(height: 45,),
                        Text(

                          'Name',
                          style: TextStyle(
                            fontFamily: 'Cfont',
                            fontSize: 20.0,
                            //fontWeight: FontWeight.w400
                          ),


                        ),
                        TextFormField(


                          validator: (String ? value) {
                            if(value!.isEmpty)
                              return 'Please enter your name' ;

                            return null;

                          },
                          controller:controlname ,

                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(

                              floatingLabelBehavior: FloatingLabelBehavior.never,

                             // label: Text('${model.data.name}'),

                             labelText: '${model.data.name}',
                              suffixIcon:Icon(Icons.edit),
                              enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(6.0)
                              ),
                              focusedBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(6.0)
                              )
                          ),

                        ),
                        SizedBox(height: 15,),
                        Text(

                          'Email',
                          style: TextStyle(
                            fontFamily: 'Cfont',
                            fontSize: 20.0,
                            //fontWeight: FontWeight.w400
                          ),


                        ),
                        TextFormField(


                          validator: (String ? value) {
                            if(value!.isEmpty)
                              return 'Please enter your email' ;

                            return null;

                          },
                          controller:controlemail ,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,

                              labelText: '${model.data.email}',
                              suffixIcon: Icon(Icons.edit),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)
                              )
                          ),

                        ),
                        SizedBox(height: 15,),
                        Text(

                          'Phone',
                          style: TextStyle(
                            fontFamily: 'Cfont',
                            fontSize: 20.0,

                            //fontWeight: FontWeight.w400
                          ),


                        ),
                        TextFormField(


                          validator: (String ? value) {
                            if(value!.isEmpty)
                              return 'Please enter your phone number' ;

                            return null;

                          },
                          controller:controlphone ,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                             labelText: '${model.data.phone}',
                              suffixIcon: Icon(Icons.edit),
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
                              padding: EdgeInsets.only(right: 155,left: 155),
                              onPressed: ()
                              {


                                if(formkey.currentState!.validate())
                                loginCubit.get(context).UpdateUserData(
                                    controlname.text,
                                    controlemail.text,
                                    controlphone.text
                                );
                              },
                              child: Text('Update',style: TextStyle(
                                  color: Colors.white
                              ),)
                          ),


                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: MaterialButton(
                              color: Colors.deepOrange,
                              height: 50,
                              padding: EdgeInsets.only(right: 155,left: 155),
                              onPressed: ()
                              {



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
                              child: Text('Logout',style: TextStyle(
                                  color: Colors.white
                              ),)
                          ),


                        ),

                      ],

                    ),
                  ),
                ),
              ),



        fallback:(context)=> Center(child: CircularProgressIndicator()),
        condition: loginCubit.get(context).model != null,

      ),
      listener: (context, state){

        if(state is SuccessUpdateUserDataState)
        {

          if(state.login.status)
          {

            Fluttertoast.showToast(
                msg: state.login.message!,
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
                msg: state.login.message!,
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




      );

  }
}
