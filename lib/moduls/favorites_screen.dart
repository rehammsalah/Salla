
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/cubit_layout/cubit.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';

import '../layout/cubit_layout/states.dart';
import '../models/get_favorite.dart';
import 'LoginShop.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool  nofav =true;
    return BlocConsumer <LayoutCubit,States>(
          builder: (context,state) => ConditionalBuilder(


              builder:(context) {
                LayoutCubit.get(context).fav.forEach((key, value) {
                  if(value == true)
                 {
                   nofav=false;
                 }
                });

                if( nofav == true)
                  {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text('No favorites yet',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cfont',
                        fontSize: 30.0,
                            color: Colors.grey
                      ),)),
                          Center(child: Icon(Icons.heart_broken,color: Colors.grey,size:80,))
                        ],
                      ),
                    );
                  }
                else
                return favBuilder(LayoutCubit.get(context).getfavmodel!);
              },
            condition:LayoutCubit.get(context).getfavmodel!=null,
            fallback:(context)=> Center(child: CircularProgressIndicator()),

          ),
          listener: (context,state) {}
      );

  }
}

Widget favBuilder(GetFavModel model)
{

  return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) =>  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 120.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image(

                        image: NetworkImage(model.data.data[index].product.image),
                        width: 120.0,




                      ),
                      if(model.data.data[index].product.disc != 0)
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text('Discount',style: TextStyle(fontSize: 8.0,color: Colors.white),),
                        )
                    ],
                  ),

                SizedBox(width: 10.0,),
                Expanded(
                  child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              '${model.data.data[index].product.name}',
                              //model.name,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  height: 1.3

                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                           Spacer(),
                           Row(
                                    children: [
                                      Text(

                                        '${model.data.data[index].product.price}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0,
                                            color: Colors.deepOrange

                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: 10,),
                                      if(model.data.data[index].product.disc != 0)
                                        Text(

                                          '${model.data.data[index].product.oldPrice}',
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
                                            LayoutCubit.get(context).postFavData(model.data.data[index].product.id);
                                            print(model.data.data[index].product.id);
                                          },
                                          icon: Icon(
                                              LayoutCubit.get(context).fav[model.data.data[index].product.id] == true ?  Icons.favorite_sharp : Icons.favorite_border

                                          )),
                                    ],
                                  ),

                              ],

                        ),
                ),





              ],
            ),
          ),
        ),

      separatorBuilder: (context,index) => Divider(
        height: 1,
        thickness: 1.0,
      ),
      itemCount: model.data.data.length
  );


}