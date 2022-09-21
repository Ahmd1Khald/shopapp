import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/layout_screen.dart';
import 'package:shopapp/modules/layout_screens/item%20screen.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/shared/constant.dart';

import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../models/layout models/search model.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
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
                      MaterialPageRoute(builder: (context) => LayoutScreen()));
                },
                icon: const Icon(Icons.chevron_left),
                color: mainColor,
                iconSize: 40),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/search.png'),
                      fit: BoxFit.contain,
                      opacity: 0.3)),
              child: Column(
                children: [
                  if (state is ShopAppLoadingSearchDataState)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: LinearProgressIndicator(
                          color: mainColor, backgroundColor: Colors.white),
                    ),
                  TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      ShopAppCubit.get(context).getSearchData(value.toString());
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: mainColor,
                        )),
                        prefixIcon: Icon(
                          Icons.search,
                          color: mainColor,
                        ),
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: mainColor,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is ShopAppSuccessSearchDataState)
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => searchItem(
                              ShopAppCubit.get(context)
                                  .searchModel!
                                  .data
                                  .data[index],
                              context),
                          separatorBuilder: (context, index) => Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                          itemCount: ShopAppCubit.get(context)
                              .searchModel!
                              .data
                              .data
                              .length),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchItem(SearchDatum? model, context) => InkWell(
    onTap: (){
      navigateTo(context, ItemScreen(model));
    },
    child: Padding(
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
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name,
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
                                  '\$${model.price}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                const Spacer(),
                                ShopAppCubit.get(context).favorites[model.id] ==
                                        true
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                      )
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
        ),
  );
}
