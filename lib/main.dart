import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/cubit.dart';
import 'package:shopapp/bloc/state.dart';
import 'package:shopapp/modules/layout_screen.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/network/local/cachehelper.dart';
import 'package:shopapp/network/remote/diohelper.dart';
import 'package:shopapp/shared/constant.dart';
import 'bloc/bloc_obsever.dart';
import 'modules/Onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? onboard = CacheHelper.getDate(key: 'OnBoard');
  token = CacheHelper.getDate(key: 'token');

  //onboard = null;
  late Widget widget;
  if (onboard != null) {
    if (token != null) {
      widget = LayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(
    this.widget,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getUserData()
        ..getFavoritesData(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: widget,
          );
        },
      ),
    );
  }
}
