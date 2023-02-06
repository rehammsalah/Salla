import 'package:flutter/cupertino.dart';
import 'package:salla/models/change_fav.dart';

import '../../models/login_model.dart';

abstract class States{}
class InitState extends States{}
class ChangeNavBar extends States{}


class SuccessHomeState extends States{



}
class LoadingHomeState extends States{}
class ErrorHomeState extends States{}


class SuccessCategoryState extends States{



}
class LoadingCategoryState extends States{}
class ErrorCategoryState extends States{

}



class SuccessFavState extends States{

ChangeFav ? changefav;
SuccessFavState(this.changefav);


}
class LoadingFavState extends States{}
class ErrorFavState extends States{

}


class SuccessGetFavState extends States{



}
class LoadingGetFavState extends States{ }
class ErrorGetFavState extends States{

}


class SuccessGetUserDataState extends States{



}
class LoadingGetUserDataState extends States{ }
class ErrorGetUserDataState extends States{

}


class SuccessGetCategoryProductState extends States{



}
class LoadingGetCategoryProductState extends States{ }
class ErrorGetCategoryProductState extends States{

}

class ChangeColorState extends States{}
class ChangeAllButtonColorState extends States{}
class ChangeListItemState extends States{}
class OthersButtonTapState extends States{}
class ZeroButtonTapState extends States{}

class ChangeListLengthZeroButtonState extends States{}
class ChangeListLengthOthersButtonState extends States{}
class ChangeSeeAllState extends States{}
class GetProductIDState extends States{}
class GetImageLengthState extends States{}








