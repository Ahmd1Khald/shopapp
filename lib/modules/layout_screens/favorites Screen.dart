import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/layout%20models/favorites%20model.dart';
import 'package:shopapp/modules/layout_screens/item%20screen.dart';
import 'package:shopapp/modules/layout_screens/setting%20screen.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/shared/constant.dart';

import '../../bloc/cubit.dart';
import '../../bloc/state.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopAppCubit.get(context).getFavoritesData();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
              icon: const Icon(Icons.chevron_left),
              color: mainColor,
              iconSize: 40,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: state is ShopAppLoadingFavDataState || state is ShopAppErrorFavDataState
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/favorites.png'),
                            fit: BoxFit.contain,
                            opacity: 0.3)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/favorites.png'),
                            fit: BoxFit.contain,
                            opacity: 0.3)),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => favItem(
                                  ShopAppCubit.get(context)
                                      .favoritesModelData!
                                      .data
                                      .data[index],
                                  context,
                                  ShopAppCubit.get(context),
                                  state),
                              separatorBuilder: (context, index) => Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                              itemCount: ShopAppCubit.get(context)
                                          .favoritesModelData!
                                          .data
                                          .data
                                          .length !=
                                      null
                                  ? ShopAppCubit.get(context)
                                      .favoritesModelData!
                                      .data
                                      .data
                                      .length
                                  : 0),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget favItem(Datum model, context, ShopAppCubit cubit, state) => Padding(
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
                  image: NetworkImage(model.product.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '\$${model.product.price}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                cubit.postFavorites(
                                    productId: model.product.id);
                                ShopAppCubit.get(context)
                                    .getFavoritesData();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    cubit.favorites[model.product.id] ==
                                            true
                                        ? Colors.red
                                        : Colors.grey,
                                size: 26,
                              )),
                        ],
                      ),
                    ],
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
