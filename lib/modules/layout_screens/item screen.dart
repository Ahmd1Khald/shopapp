import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/layout%20models/search%20model.dart';
import 'package:shopapp/modules/layout_screens/search_screen.dart';

import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../shared/constant.dart';

class ItemScreen extends StatelessWidget {
  dynamic model;

  ItemScreen(this.model);

  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: const Icon(Icons.chevron_left),
                color: mainColor,
                iconSize: 40),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: SizedBox(
                width: 200,
                height: 300,
                child: Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                ),
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 130,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: mainColor.withOpacity(0.5),
                            ),
                            child: const Center(
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopAppCubit.get(context)
                                    .postFavorites(productId: model.id);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: ShopAppCubit.get(context)
                                            .favorites[model.id] ==
                                        true
                                    ? Colors.red
                                    : Colors.grey,
                                size: 26,
                              )),
                        ],
                      ),
                      Text(
                        model.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.4),
                      ),
                      Container(
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainColor.withOpacity(0.5),
                        ),
                        child: const Center(
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        model.description,
                        maxLines: 5,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            height: 1.4),
                      ),
                      Container(
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainColor.withOpacity(0.5),
                        ),
                        child: const Center(
                          child: Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '\$${model.price.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
