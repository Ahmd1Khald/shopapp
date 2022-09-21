
import 'package:shopapp/models/layout%20models/postFav%20model.dart';

import '../models/layout models/user_data model.dart';
import '../models/login model.dart';
import '../models/register model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppChangeObscureIconState extends ShopAppStates {}

class ShopAppChangeBottomIndexState extends ShopAppStates {}

class ShopAppLoadingLoginDataState extends ShopAppStates {}

class ShopAppSuccessLoginDataState extends ShopAppStates {
  final LoginModelData model;

  ShopAppSuccessLoginDataState(this.model);
}

class ShopAppErrorLoginDataState extends ShopAppStates {}

class ShopAppLoadingRegisterDataState extends ShopAppStates {}

class ShopAppSuccessRegisterDataState extends ShopAppStates {
  final RegisterModelData model;

  ShopAppSuccessRegisterDataState(this.model);
}

class ShopAppErrorRegisterDataState extends ShopAppStates {}

class ShopAppLoadingHomeDataState extends ShopAppStates {}

class ShopAppSuccessHomeDataState extends ShopAppStates {}

class ShopAppErrorHomeDataState extends ShopAppStates {}

class ShopAppLoadingCategoriesDataState extends ShopAppStates {}

class ShopAppSuccessCategoriesDataState extends ShopAppStates {}

class ShopAppErrorCategoriesDataState extends ShopAppStates {}

class ShopAppLoadingUserDataState extends ShopAppStates {}

class ShopAppSuccessUserDataState extends ShopAppStates {}

class ShopAppErrorUserDataState extends ShopAppStates {}

class ShopAppChangeActiveIndexState extends ShopAppStates {}

class ShopAppLoadingPutUpdateDataState extends ShopAppStates {}

class ShopAppSuccessPutUpdateDataState extends ShopAppStates {
  final UserModelData model;

  ShopAppSuccessPutUpdateDataState(this.model);
}

class ShopAppErrorPutUpdateDataState extends ShopAppStates {}

class ShopAppLoadingSearchDataState extends ShopAppStates {}

class ShopAppSuccessSearchDataState extends ShopAppStates {}

class ShopAppErrorSearchDataState extends ShopAppStates {}

class ShopAppSuccessFavDataState extends ShopAppStates {}

class ShopAppLoadingFavDataState extends ShopAppStates {}

class ShopAppErrorFavDataState extends ShopAppStates {}

class ShopAppEnableUpdateDataState extends ShopAppStates {}

class ShopAppLoadingLogoutState extends ShopAppStates {}

class ShopAppSuccessLogoutState extends ShopAppStates {}

class ShopAppErrorLogoutState extends ShopAppStates {}

class ShopAppChangeFavState extends ShopAppStates {}

class ShopAppSuccessPostFavState extends ShopAppStates {
  final PostFavData model;

  ShopAppSuccessPostFavState(this.model);
}

class ShopAppErrorPostFavState extends ShopAppStates {}