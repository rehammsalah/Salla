class ChangeFav {

  late String msg;
  late bool status;

  ChangeFav.fromjson(Map<String,dynamic> json)
  {

    msg=json['message'];
    status=json['status'];

  }




}