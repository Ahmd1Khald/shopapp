import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/network/local/cachehelper.dart';
import 'package:shopapp/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/onboarding models.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  void submit(context) {
    CacheHelper.saveData(key: 'OnBoard', value: true);
    navigateAndRemove(
      context: context,
      widget: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                submit(context);
              },
              child: Text(
                'Skip',
                style: TextStyle(color: HexColor('FF8F0A'), fontSize: 20),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == 2) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => bulidOnboarding(model[index]),
                itemCount: model.length,
                scrollDirection: Axis.horizontal,
                controller: pageController,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: model.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 5,
                    expansionFactor: 2,
                    dotColor: Colors.grey,
                    activeDotColor: HexColor('FF8F0A'),
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  backgroundColor: HexColor('FF8F0A'),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bulidOnboarding(BoardingModel? model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model!.image),
            height: 500,
            width: 500,
          ),
          Text(
            model.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.body,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
          ),
        ],
      );
}
