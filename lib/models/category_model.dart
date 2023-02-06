class CategoryModel{

  bool ? status;
  CategoryDataModel ? data;
  CategoryModel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    data=CategoryDataModel.fromjson(json['data']);

  }

}

class CategoryDataModel{
  int ? current_page ;
  late List<DataModel> data =[];

  CategoryDataModel.fromjson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){

      data.add(DataModel.fromjson(element));


    });
  }



}

class DataModel{
  int ? id;
  String ? name;
  String ? image;
  bool selected =false;

  DataModel.fromjson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];


  }


}