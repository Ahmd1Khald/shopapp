import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/modules/layout_screens/home_Screen.dart';
import 'package:shopapp/shared/components.dart';

import '../bloc/cubit.dart';
import '../bloc/state.dart';
import 'layout_screens/search_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopAppCubit cubit = ShopAppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: HexColor('FFAA47'),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
            title: const Text(
              'Shop App',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  decoration: TextDecoration.underline),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home',
                backgroundColor: HexColor('FFAA47'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                label: 'Categories',
                backgroundColor: HexColor('FFAA47'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: 'User',
                backgroundColor: HexColor('FFAA47'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'Setting',
                backgroundColor: HexColor('FFAA47'),
              ),
            ],
            backgroundColor: Colors.white,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomIndex(index: index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
