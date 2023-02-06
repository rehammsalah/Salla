
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import '../layout/cubit_layout/cubit.dart';
import '../layout/cubit_layout/states.dart';
import '../models/category_model.dart';
import '../models/category_products_model.dart';
import '../models/home_model.dart';
import 'LoginShop.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,States>(
        builder:(context , state){
          return ConditionalBuilder
            (
              condition:  LayoutCubit.get(context).categorymodel != null
              ,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  color: Colors.grey[300],
                  child: GridView.count(

                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1/1.58,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(

                        LayoutCubit.get(context).homemodel!.data.products.length ,
                            (index) => BuildList( LayoutCubit.get(context).homemodel!.data.products[index],context)


                    ),
                    crossAxisCount: 2,

                  ),
                ),
              ),
              fallback: (context)=> Center(child: CircularProgressIndicator()));
        },
        listener: (context , state){}
    );
  }
}
Widget BuildCategory (CategoryModel catmodel){
  return ListView.separated(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index) {


          return Card(

          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(

            borderRadius: const BorderRadius.all(Radius.circular(12)),

          ),
          child : Container(
            width: double.infinity,
            height: 150,
            child: Row(


              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(200,200,200,0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: NetworkImage(catmodel.data!.data[index].image!),

                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20.0,),

                Text(

                  catmodel.data!.data[index].name!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,

                    fontFamily: 'Cfont',),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios)

              ],

            ),
          ),






        );} ,
        separatorBuilder: (context,index) => SizedBox(width: 10.0),
        itemCount: catmodel.data!.data.length
    );

}
Widget BuildList (
    BroductModel model,
    context,

    ){


  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Image(


              image:NetworkImage('${model!.image}',)  ,
              width: double.infinity,
              height: 200.0,


            ),
            if(model!.disc!= 0)
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

                '${model!.name}'  ,
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

                    '${model!.price.round()}' ,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        color: Colors.deepOrange

                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 10,),
                  if( model!.disc != 0)
                    Text(

                      '${model!.oldPrice.round()}' ,
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
                        LayoutCubit.get(context).postFavData(model!.id) ;
                        print( model!.id );
                      },
                      icon: Icon(
                          LayoutCubit.get(context).fav[ model!.id ] == true ?  Icons.favorite_sharp : Icons.favorite_border

                      ))
                ],
              ),
            ],
          ),
        ),


      ],
    ),
  );
}