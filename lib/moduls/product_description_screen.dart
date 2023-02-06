
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../layout/cubit_layout/states.dart';

class ProductDescriptionScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LayoutCubit,States>(
      builder: (context, state) {
        var productimage = PageController();
        var cubit = LayoutCubit.get(context).homemodel!.data;
        int index =cubit.products.indexWhere((element) => element.id == LayoutCubit.get(context).productid! );
        print('${index}');
        print('${LayoutCubit.get(context).productid!}');

        List<ImageProvider> images = [];
        for(int i = 0 ; i < LayoutCubit.get(context).imagelength! ; i++)
        {
          images.add(NetworkImage('${cubit.products[index].images[i]}'));
        }

        return ConditionalBuilder(
          builder: (context)=> Scaffold(

                body: SingleChildScrollView(

                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                     // height:  MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(300, 300, 300, 0.1),
                                ),
                              width: MediaQuery.of(context).size.width,
                              height: 400,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(Color.fromRGBO(300, 300, 300, 0.1), BlendMode.srcOver),
                                      child: PageView.builder(
                                        onPageChanged: (int index) {},
                                        controller: productimage,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context,index) => item(images[index]),
                                        itemCount: LayoutCubit.get(context).imagelength!,


                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: SmoothPageIndicator(
                                        controller: productimage,
                                        count: LayoutCubit.get(context).imagelength!,
                                        effect: ExpandingDotsEffect(

                                            dotColor: Colors.grey,
                                            activeDotColor: Colors.deepOrange,
                                            dotHeight: 10,
                                            dotWidth: 10,
                                            spacing: 5.0,
                                            expansionFactor:4
                                        ),
                                      ),
                                    ),

                                  ],
                                ),


                              ),

                           Container(

                             width: MediaQuery.of(context).size.width,

                             color: Color.fromRGBO(300, 300, 300, 0.1),
                               child: Card(
                                 elevation: 0,
                                 color: Color.fromRGBO(200, 200, 200, 0.1),
                                 child: Container(

                                   width: MediaQuery.of(context).size.width,

                                   decoration: BoxDecoration(

                                     color: Colors.white,
                                     borderRadius: BorderRadius.only(
                                         topRight: Radius.circular(40)
                                     )
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(5.0),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [

                                             Text(

                                                  '${cubit.products[index].name}'  ,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                      height: 1.3

                                                  )),


                          SizedBox(height: 10,),
                         Text('${cubit.products[index].price}'+'\$',style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              height: 1.3

                                          )),
                          SizedBox(height: 10,),
                                         Text(

                                              '${cubit.products[index].description}'  ,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 10,
                                                height: 1.5


                                              )),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),


                        ],
                      ),
                    ),
                  ),
                ),


            ),
          
          fallback:(context)=> Center(child: CircularProgressIndicator()) ,
          condition: LayoutCubit.get(context).homemodel != null ,

        );
      },
      listener:  (context, state){},


    );
  }

  Widget item (ImageProvider img){


              return  Center(child: Image(image: img,height: 300,width: double.infinity,));

  }
}
