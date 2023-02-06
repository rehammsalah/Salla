import 'package:salla/models/login_model.dart';
import 'package:salla/models/login_model.dart';

abstract class loginState {}

class initState extends loginState{}

class successState extends loginState{
  Model loginmodel ;
  successState(this.loginmodel) ;


}

class loadingState extends loginState{}

class errorState extends loginState{

  String error;
  errorState(this.error);
}


class ChangePasswordState extends loginState{}


////////////////////////////////////////////////////

class SuccessUpdateUserDataState extends loginState{

  Model login;
  SuccessUpdateUserDataState(this.login);

}
class LoadingUpdateUserDataState extends loginState{ }
class ErrorUpdateUserDataState extends loginState{

}