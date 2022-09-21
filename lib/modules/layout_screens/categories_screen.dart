import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/modules/layout_screens/search_screen.dart';
import 'package:shopapp/shared/components.dart';

import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../models/layout models/categories model.dart';
import '../../shared/constant.dart';
import 'item screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ShopAppCubit.get(context).searchModel = null;
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/category.png'),
              fit: BoxFit.contain,
              opacity: 0.2,
            )),
            child: Column(
              children: [
                if (state is ShopAppLoadingCategoriesDataState) circleLoading(),
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => categoriesItem(
                          ShopAppCubit.get(context)
                              .categoriesModelData!
                              .data
                              .data[index],
                          context),
                      separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                      itemCount: ShopAppCubit.get(context)
                          .categoriesModelData!
                          .data
                          .data
                          .length),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget categoriesItem(CategoriesDatum? model, context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 150,
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(model!.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Text(
                        model.name.toUpperCase(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
