import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/cubitlogin.dart';
import 'package:shopapp/bloc/states/states.dart';
import 'package:shopapp/screen/login.dart';
import 'package:shopapp/shared/network/component.dart';
import 'package:shopapp/shared/network/remote.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boardingmodel {
  final String image;
  final String title;
  final String body;

  Boardingmodel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class Onboarding extends StatefulWidget {
  Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<Boardingmodel> boarding = [
    Boardingmodel(
        image:
            "https://mdec.my/wp-content/uploads/asset-2-onboarding-banner-1.png",
        title: "boarding model 1",
        body: "hoe you think about you "),
    Boardingmodel(
        image:
            'https://thumbs.dreamstime.com/b/tablet-screen-online-shop-app-clothing-items-shopping-cart-vector-illustration-electronic-commerce-internet-purchase-183608898.jpg',
        title: "boarding model 2",
        body: "you gonna love there much better for you "),
    Boardingmodel(
        image:
            "https://mdec.my/wp-content/uploads/asset-2-onboarding-banner-1.png",
        title: "boarding model 3",
        body: "get in and take alook its good for you"),
  ];
  var boardcontroller = PageController();
  bool isthird = false;
  void submit() {
    Catchelper.savedata(key: 'onboarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context: context, widget: Loginscreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Applogincubit, Apploginstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: submit,
                    child: const Text(
                      'skip',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: boardcontroller,
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          setState(() {
                            isthird = true;
                          });
                        } else {
                          setState(() {
                            isthird = false;
                          });
                        }
                      },
                      itemBuilder: (context, index) =>
                          pageviewitems(boarding[index]),
                      itemCount: boarding.length,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(
                        controller: boardcontroller,
                        count: boarding.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                          expansionFactor: 4.0,
                          spacing: 5.0,
                        ),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                          onPressed: () {
                            if (isthird) {
                              submit();
                            } else {
                              boardcontroller.nextPage(
                                  duration: const Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            }
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded)),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
