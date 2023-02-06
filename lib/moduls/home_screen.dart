
import 'dart:ffi';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/layout/cubit_layout/states.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/moduls/product_description_screen.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import '../models/category_model.dart';
import '../models/category_products_model.dart';
import 'LoginShop.dart';
import 'categories_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LayoutCubit,States>(
        builder:(context , state){

         return ConditionalBuilder
           (
             condition: LayoutCubit.get(context).homemodel != null && LayoutCubit.get(context).categorymodel != null && LayoutCubit.get(context).categoryProductModel != null
             ,
             builder: (context) => HomeBuilder( LayoutCubit.get(context).homemodel!, LayoutCubit.get(context).categorymodel!, context, LayoutCubit.get(context).categoryProductModel!),
             fallback: (context)=> Center(child: LinearProgressIndicator()));
        },
        listener: (context , state){


          if(state is SuccessFavState)
            {

              if(state.changefav!.status==false)
                {
                  print('falseToastMsg');
                }



            }


        }
        );
  }
}
Widget HomeBuilder ( HomeModel  model, CategoryModel  catmodel, context, CategoryProductModel  catproduct)
{
  int indexx;
return SingleChildScrollView(
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CarouselSlider(
            items: model.data.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(

              height: 250,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )

        ),
        SizedBox(height: 10.0,),

        Padding(
          padding: const EdgeInsets.all(20.0),

              child: Container(
                  color: Colors.white,
                  height: 40,
                  child: ListView.separated(


                    scrollDirection: Axis.horizontal,

                      itemBuilder: (context,index)
                       {


                           return CategoryItem(

                               LayoutCubit.get(context).categorymodel!,
                               index,
                               LayoutCubit.get(context).homemodel!,
                               context,
                               LayoutCubit.get(context).categoryProductModel!
                           );


                       },

                      separatorBuilder: (context,index) => SizedBox(width: 10.0,),
                      itemCount: (LayoutCubit.get(context).categorymodel!.data!.data.length)
                  ),
                ),


        ),

        Padding(

          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Text('Most popular',style: TextStyle(
                    fontFamily: 'Cfont',
                      fontSize: 30.0,
                      //fontWeight: FontWeight.w400
                  ),),
          Spacer(),
          TextButton(

              style: TextButton.styleFrom(
                elevation: 0,
                //disabledBackgroundColor: Colors.white,

              ),
              onPressed: (){
                LayoutCubit.get(context).ChangeSeeAll();

              },


              child: Text('See All',style: TextStyle(color: Colors.deepOrange,decoration: TextDecoration.underline),))


                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0,),

        ConditionalBuilder(
            builder: (context)=>Container(
              color: Colors.grey[300],
              child: GridView.count(


                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1/1.58,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(

                       catproduct.data.data.length ,
                      (index) {

                        indexx =model.data.products.indexWhere((element) => element.id == catproduct.data.data[index].id);
                         return BuildList(indexx, model.data.products[index],context,catproduct.data.data[index],catproduct.data.data[index].id);
                       }


                ),
                crossAxisCount: 2,

              ),
            ),
            condition: LayoutCubit.get(context).homemodel!=null && LayoutCubit.get(context).categoryProductModel != null,
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),


      ],
    ),
  );



}


Widget BuildList (
    int indexx,
    BroductModel model,
    context,
      ProductDataModel? categoryProductModel,
    int id,

    ){


    return InkWell(
      onTap: (){
        LayoutCubit.get(context).GetProductID(id);
        LayoutCubit.get(context).GetImageLength(LayoutCubit.get(context).homemodel!.data.products[indexx].images.length);

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductDescriptionScreen(),

        ),);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Image(


                    image:NetworkImage('${categoryProductModel!.image}',)  ,
                  width: double.infinity,
                  height: 200.0,


                ),
                if(categoryProductModel!.disc!= 0)
                 Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('Discount',style: TextStyle(fontSize: 8.0,color: Colors.white),),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(

              '${categoryProductModel!.name}'  ,
                  maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                      height: 1.3

                    ),
                  overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Text(

                        '${categoryProductModel!.price.round()}' ,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,

                          color: Colors.deepOrange

                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 10,),
                      if( categoryProductModel!.disc != 0)
                       Text(

                         '${categoryProductModel!.oldPrice.round()}' ,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11.0,
                            color: Colors.grey,
                          decoration: TextDecoration.lineThrough


                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      IconButton(
                        color: Colors.deepOrange,
                        iconSize: 15.0,
                          onPressed: (){
                            LayoutCubit.get(context).postFavData(categoryProductModel!.id) ;
                          print( categoryProductModel!.id );
                          },
                          icon: Icon(
                            LayoutCubit.get(context).fav[ categoryProductModel!.id ] == true ?  Icons.favorite_sharp : Icons.favorite_border

                          ))
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
}
Widget CategoryItem(CategoryModel model, int index, HomeModel  homemodel, context, CategoryProductModel  catproduct ){

  return Material(
    color: Colors.white,
    child: MaterialButton(
         elevation:0 ,
      color:  model.data!.data[index].selected == true ? Colors.deepOrange :Color.fromRGBO(200,200,200,0.2),
      height: 35,
      minWidth: 130,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

      onPressed: (){

        LayoutCubit.get(context).ChangeCategoryColor(index);
        LayoutCubit.get(context).GetCategoryProduct(model.data!.data[index].id!);

      },
      child: Center(child: Text('${model.data!.data[index].name}',style: TextStyle(
        fontFamily: 'Cfont',
      ),)),
      

      ),
  );

}
