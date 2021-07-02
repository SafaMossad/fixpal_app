import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_screen.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({this.image, this.title, this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/boarding/boarding1.png",
      title: "اطلب",
      body:
          "عشان تطلب صنايعي فيكسبال كل اللي عليك تختار الخدمة اللي أنت محتاجها هتلاقي واحد من أحسن الصنايعية موجود عندك..",
    ),
    BoardingModel(
      image: "assets/boarding/boarding2.png",
      title: "نفّذ",
      body:
          "مرحلة التنفيذ مع فيكسبال مفيش أسهل منها!! عشان تاخد أحسن خدمة بأحسن سعر ومن أول مرة",
    ),
    BoardingModel(
      image: "assets/boarding/boarding3.png",
      title: "اطمن",
      body:
          "مع فيكسبال مش ممكن تقلق..  تقدر تتواصل مع خدمة العملاء وفريق ما بعد البيع اللي ديمًا موجودين لإستقبال أي شكاوى والرد على كل استفساراتك في كل وقت",
    ),
  ];

  Widget buildBoardingItem(context, BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            model.title,
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          model.body,
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  bool _isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                navigateTo(context, LoginScreen());
              },
              child: Text(
                "Skip",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        _isLast = true;
                      });
                    } else {
                      _isLast = false;
                    }
                  },
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildBoardingItem(context, boarding[index]);
                  },
                  itemCount: 3,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                      dotColor: defaultColor,
                      activeDotColor: Theme.of(context).primaryColor,

                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      spacing: 5.0,
                      //radius:  4.0,

                      //paintStyle: PaintingStyle.stroke,
                      //strokeWidth: 1.5,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_isLast) {
                        navigateTo(context, LoginScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 760),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
