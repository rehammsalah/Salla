
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/layout/cubitlogin/cubit.dart';
import 'package:salla/layout/cubitlogin/states.dart';
import 'package:salla/moduls/ShopLayout.dart';
import 'package:salla/moduls/registershop.dart';
import 'package:salla/shared/constants.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

class loginscreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var controlemail = TextEditingController();
  var controlpass = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocConsumer <loginCubit,loginState> (
        builder: (context,state){

          return Scaffold(

            // appBar: AppBar(),
            body: Center(

              child: SingleChildScrollView(

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                  child: Form(
                    key: formkey,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Image(image: AssetImage('assets/images/two.png')),
                        ),
                        Text(

                            'LOGIN',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25,fontWeight: FontWeight.bold)


                        ),
                        SizedBox(height: 10,),
                        Text(

                            'Please login to access our online shopping app',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              color: Colors.grey,
                            )


                        ),
                        SizedBox(height: 25,),
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



                          validator: (String? value) {
                            if(value!.isEmpty)
                              return 'Please enter your password ';

                            return null;

                          },
                           onFieldSubmitted: (value){
                             if(formkey.currentState!.validate())
                             {
                               loginCubit.get(context).userlogin(
                                 email: controlemail.text,
                                 password: controlpass.text,

                               );

                             }
                           },

                          enabled: true,
                          obscureText: loginCubit.get(context).secured,


                          obscuringCharacter: '*',
                          controller:controlpass ,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(


                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(

                                icon: loginCubit.get(context).icon,
                                onPressed: (){
                                  loginCubit.get(context).changeIcon();
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
                                  padding: EdgeInsets.only(right: 160,left: 160),
                                  onPressed: ()
                                  {


                                    if(formkey.currentState!.validate())
                                      {
                                        loginCubit.get(context).userlogin(
                                        email:  controlemail.text,
                                         password: controlpass.text
                                        );


                                      }


                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.white
                                  ),)
                              ),


                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: (){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:(context) => registerscreen()

                                      ));
                                },
                                child: Text('REGISTER'))


                          ],
                        )


                      ],

                    ),
                  ),
                ),
              ),
            ),


          );
        },
        listener: (context,state){
         if(state is successState)
            {

              if(state.loginmodel.status!)
                {

                  cache.SaveData(key: 'Token', value: state.loginmodel.data.token).then((value) {
                    token=state.loginmodel.data.token;
                    Navigator.pushAndRemoveUntil(

                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeLayout(),

                        ),
                            (Route <dynamic> route) => false
                    );
                  });

                  Fluttertoast.showToast(
                      msg: state.loginmodel.message!,
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
                    msg: state.loginmodel.message!,
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
enum ToastColor {Success,Error,Warning}
Color ChooseColor ({
 required ToastColor state
})
{
  Color color;
  switch(state)
  {

    case ToastColor.Success:
      color= Colors.grey[300]!;
    break;

    case ToastColor.Warning:
    color = Colors.grey[300]!;
    break;

    case ToastColor.Error:
    color = Colors.grey[300]!;
    break;
  }
  return color;


}

