import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

const login = 'login';

const register = 'register';

const home = 'home';

const categories = 'categories';

const profile = 'profile';

const updateProfile = 'update-profile';

const search = 'products/search';

const logout = 'logout';

const favoritesConst = 'favorites';

String token = '';

final mainColor =  HexColor('FFAA47');

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        //statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: mainColor)),
);


