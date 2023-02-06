class CategoryProductModel{

  bool ? status;
  late CategoryProductDataModel data;
  CategoryProductModel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    data=CategoryProductDataModel.fromjson(json['data']);

  }

}

class CategoryProductDataModel{
  int ? current_page ;
  late List<ProductDataModel> data =[];

  CategoryProductDataModel.fromjson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){


      data.add(ProductDataModel.fromjson(element));


    });
  }



}

class ProductDataModel{

  late int id ;
  late dynamic price;
  late dynamic oldPrice ;
  late String image ;
  late String name;
  late bool inFav;
  late bool inCart;
  late int disc ;
  late String description;




  ProductDataModel.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    name = json['name'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];
    image = json['image'];
    disc = json['discount'];
    description = json['description'];
  }

}