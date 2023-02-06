import 'package:flutter/cupertino.dart';
import 'package:salla/models/change_fav.dart';

import '../../models/login_model.dart';

abstract class RegisterStates{}
class InitRegisterState extends RegisterStates{}

class SuccessPostUserDataState extends RegisterStates{

  Model registermodel;
  SuccessPostUserDataState(this.registermodel);



}
class LoadingPostUserDataState extends RegisterStates{}
class ErrorPostUserDataState extends RegisterStates{}

class ChangePasswordRegisterState extends RegisterStates{}

