class GetFavModel{

  late bool status;
  late GetFavModelData data;



  GetFavModel.fromjson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=GetFavModelData.fromjson(json['data']);
  }


}
class GetFavModelData{

  late int current_page;
   List<Data> data =[];

  GetFavModelData.fromjson(Map<String,dynamic>json)
  {
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fromjson(element));
    });

  }




}

class Data{

  late int id;
  late ProductData product ;
  Data.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    product = ProductData.fromjson(json['product']);

  }





}
class ProductData{

  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String image;
  late String name;
  late int disc;
  late String description;


  ProductData.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    name = json['name'];
    image = json['image'];
    disc = json['discount'];
    description=json['description'];
  }







}