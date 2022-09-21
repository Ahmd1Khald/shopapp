import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/modules/layout_screens/item%20screen.dart';
import 'package:shopapp/modules/layout_screens/search_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../models/layout models/categories model.dart';
import '../../models/layout models/home model.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';

class HomeScreen extends StatelessWidget {
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //ShopAppCubit.get(context).getHomeData();
    //ShopAppCubit.get(context).getCategoriesData();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppSuccessPostFavState) {
          if (!state.model.status) {
            myToast(state: state.model.message, toastState: toastState.Error);
          } else {
            myToast(state: state.model.message, toastState: toastState.Success);
          }
        }
      },
      builder: (context, state) {
        ShopAppCubit cubit = ShopAppCubit.get(context);
        return state is ShopAppLoadingHomeDataState
            ? circleLoading()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cubit.homeModelData == null
                        ? circleLoading()
                        : Column(
                            children: [
                              CarouselSlider.builder(
                                options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      cubit.changeActiveIndex(index: index);
                                    },
                                    height: 250,
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    reverse: false,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                    enlargeCenterPage: true),
                                itemCount:
                                    cubit.homeModelData!.data.banners.length,
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return BuildCaroural(
                                      cubit.homeModelData!, index);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: cubit.activeIndex,
                                  count:
                                      cubit.homeModelData!.data.banners.length,
                                  effect: WormEffect(
                                    activeDotColor: HexColor('FFAA47'),
                                    dotWidth: 10,
                                    dotHeight: 10,
                                    spacing: 3.5,
                                    paintStyle: PaintingStyle.stroke,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
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
                          'Categories',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    cubit.categoriesModelData == null
                        ? circleLoading()
                        : SizedBox(
                            height: 100,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => builtCategories(
                                  cubit.categoriesModelData!.data.data[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 2,
                              ),
                              itemCount: 5,
                            ),
                          ),
                    const SizedBox(
                      height: 40,
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
                          'Products',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    cubit.homeModelData == null
                        ? circleLoading()
                        : GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: List.generate(
                                cubit.homeModelData!.data.products.length,
                                (index) => buildGridProduct(
                                    cubit.homeModelData!.data.products[index],
                                    context,
                                    cubit)),
                          ),
                  ],
                ),
              );
      },
    );
  }

  Widget BuildCaroural(HomeModelData model, int index) => Container(
      margin: const EdgeInsets.all(10),
      child: Image(
        image: NetworkImage(model.data.banners[index].image),
        fit: BoxFit.cover,
      ));

  Widget builtCategories(CategoriesDatum? category) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image(
                  image: NetworkImage(
                category!.image,
              ))),
          Container(
            width: 100,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.8),
            ),
            child: Text(
              category.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  Widget buildGridProduct(Product? model, context, ShopAppCubit cubit) =>
      Container(
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 80,
                      child: Image(
                        image: NetworkImage(model!.image),
                        width: double.infinity,
                      ),
                    ),
                    if (model.discount != 0)
                      Container(
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ],
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, ItemScreen(model));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${model.price}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                if (model.discount != 0)
                                  Text(
                                    '${model.oldPrice}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  cubit.postFavorites(productId: model.id);
                },
                icon: Icon(
                  Icons.favorite,
                  color: cubit.favorites[model.id] == true
                      ? Colors.red
                      : Colors.grey,
                  size: 26,
                )),
          ],
        ),
      );
}
