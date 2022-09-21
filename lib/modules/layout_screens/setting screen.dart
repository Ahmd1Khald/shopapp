import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/modules/layout_screens/favorites%20Screen.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/shared/constant.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopAppCubit.get(context).getFavoritesData();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              const Image(image: AssetImage('images/setting.png')),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: HexColor('FFAA47'),
                ),
                child: MaterialButton(
                  onPressed: () {
                    navigateTo(context, FavoritesScreen());
                  },
                  padding: const EdgeInsetsDirectional.all(10),
                  child: Text(
                    'Favorites'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                height: 45,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: HexColor('FFAA47'),
                ),
                child: MaterialButton(
                  onPressed: () {
                    ShopAppCubit.get(context)
                        .logOUt(key: token, context: context);
                  },
                  padding: EdgeInsetsDirectional.all(10),
                  child: Text(
                    'logout'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
