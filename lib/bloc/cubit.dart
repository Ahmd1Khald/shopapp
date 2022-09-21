import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/state.dart';
import 'package:shopapp/models/layout%20models/favorites%20model.dart';
import 'package:shopapp/models/register%20model.dart';
import 'package:shopapp/modules/layout_screen.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/network/local/cachehelper.dart';
import 'package:shopapp/network/remote/diohelper.dart';
import '../models/layout models/categories model.dart';
import '../models/layout models/home model.dart';
import '../models/layout models/postFav model.dart';
import '../models/layout models/search model.dart';
import '../models/layout models/user_data model.dart';
import '../models/login model.dart';
import '../modules/layout_screens/categories_screen.dart';
import '../modules/layout_screens/home_Screen.dart';
import '../modules/layout_screens/setting screen.dart';
import '../modules/layout_screens/user screen.dart';
import '../shared/components.dart';
import '../shared/constant.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  bool isShowPassIcon = true;
  IconData passIcon = Icons.visibility_off;

  void changePassIcon({
    required bool isShow,
  }) {
    if (isShow) {
      passIcon = Icons.visibility_off;
    } else {
      passIcon = Icons.visibility;
    }
    isShowPassIcon = !isShow;
    emit(ShopAppChangeObscureIconState());
  }

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    const CategoriesScreen(),
    UserScreen(),
    const SettingScreen(),
  ];

  void changeBottomIndex({required int index}) {
    currentIndex = index;
    emit(ShopAppChangeBottomIndexState());
  }

  LoginModelData? loginData;

  void postLoginData({
    required String email,
    required String password,
  }) {
    emit(ShopAppLoadingLoginDataState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginData = LoginModelData.fromJson(value.data);
      // print(loginData.status);
      print(loginData!.message);
      // print(loginData.data!.token);
      emit(ShopAppSuccessLoginDataState(
        loginData!,
      ));
    }).catchError((error) {
      print('${error.toString()} Error while post the data in login');
      emit(ShopAppErrorLoginDataState());
    });
  }

  RegisterModelData? registerData;

  void postRegisterData(
      {required String email,
      required String name,
      required String phone,
      required String password,
      required context}) {
    emit(ShopAppLoadingLoginDataState());
    DioHelper.postData(url: register, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      registerData = RegisterModelData.fromJson(value.data);
      if (registerData!.status == true) {
        navigateAndRemove(context: context, widget: LayoutScreen());
      }
      print('$token postRegisterData');
      // print(loginData.data!.token);
      emit(ShopAppSuccessRegisterDataState(
        registerData!,
      ));
    }).catchError((error) {
      print('${error.toString()} Error while post the data in register ');
      emit(ShopAppErrorRegisterDataState());
    });
  }

  HomeModelData? homeModelData;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopAppLoadingHomeDataState());
    print('$token getHomeData');
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModelData = HomeModelData.fromJson(value.data);
      for (var element in homeModelData!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }

      print('$token getHomeData');

      emit(ShopAppSuccessHomeDataState());
    }).catchError((error) {
      print('$error when get home data');

      emit(ShopAppErrorHomeDataState());
    });
  }

  CategoriesModelData? categoriesModelData;

  void getCategoriesData() {
    emit(ShopAppLoadingCategoriesDataState());

    DioHelper.getData(url: categories, token: token).then((value) {
      categoriesModelData = CategoriesModelData.fromJson(value.data);
      print('$token getCategoriesData');
      print(token);

      emit(ShopAppSuccessCategoriesDataState());
    }).catchError((error) {
      print('$error when get Categories data');

      emit(ShopAppErrorCategoriesDataState());
    });
  }

  int activeIndex = 0;

  void changeActiveIndex({required int index}) {
    activeIndex = index;
    emit(ShopAppChangeActiveIndexState());
  }

  UserModelData? userModelData;

  void getUserData() {
    emit(ShopAppLoadingUserDataState());

    DioHelper.getData(url: profile, token: token).then((value) {
      print('$token getUserData');
      userModelData = UserModelData.fromJson(value.data);
      print(value.data);
      emit(ShopAppSuccessUserDataState());
    }); /*.catchError((error) {
      print('$error when get user data');
      emit(ShopAppErrorUserDataState());
    });*/
  }

  void getUpdateData({
    String? name,
    String? phone,
    String? email,
  }) {
    emit(ShopAppLoadingPutUpdateDataState());

    DioHelper.putData(url: updateProfile, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModelData = UserModelData.fromJson(value.data);
      print(value.data);
      print('$token getUpdateData');
      emit(ShopAppSuccessPutUpdateDataState(userModelData!));
    }).catchError((error) {
      emit(ShopAppErrorPutUpdateDataState());
    });
  }

  SearchModelData? searchModel;

  void getSearchData(String? text) {
    emit(ShopAppLoadingSearchDataState());
    DioHelper.postData(url: search, data: {'text': text}).then((value) {
      searchModel = SearchModelData.fromJson(value.data);
      print('$token getSearchData');

      emit(ShopAppSuccessSearchDataState());
    }).catchError((error) {
      emit(ShopAppErrorSearchDataState());
    });
  }

  bool enableUpdate = false;

  void changeEnableUpdate() {
    enableUpdate = !enableUpdate;
    emit(ShopAppEnableUpdateDataState());
  }

  void logOUt({required String key, context}) {
    emit(ShopAppLoadingLogoutState());

    CacheHelper.removeData(key: key).then((value) {
      emit(ShopAppSuccessLogoutState());

      navigateAndRemove(context: context, widget: LoginScreen());
    }).catchError((error) {
      print('$error when logout');

      emit(ShopAppErrorLogoutState());
    });
  }

  FavoritesModelData? favoritesModelData;

  void getFavoritesData() {

    emit(ShopAppLoadingFavDataState());

    DioHelper.getData(url: favoritesConst, token: token).then((value) {
      favoritesModelData = FavoritesModelData.fromJson(value.data);
      print(favoritesModelData!.message);

      emit(ShopAppSuccessFavDataState());
    }).catchError((error) {
      print('$error when get Favorites');

      emit(ShopAppErrorFavDataState());
    });
  }

  PostFavData? postFavData;

  void postFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopAppChangeFavState());

    DioHelper.postData(
            url: favoritesConst,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      postFavData = PostFavData.fromJson(value.data);

      if (!postFavData!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopAppSuccessPostFavState(postFavData!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print('$error when post Favorites');
      emit(ShopAppErrorPostFavState());
    });
  }
}
