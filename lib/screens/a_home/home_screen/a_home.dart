import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/adv_slider.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/header.dart';
import 'package:the_smart_workshop/screens/utilities/guide/guide.dart';

import 'body.dart';

class MyHomePage extends StatelessWidget {
  static String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, i) {
                  if (i == 0)
                    return AppBackGround(
                        child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          HomeHeader(),
                          HomeBody(),
                          SizedBox(
                            height: 10,
                          ),
                          // GestureDetector(
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => CoffeeHome()));
                          //     },
                          //     child: Image.asset('assets/images/coffee.png')),
                          DCarouselSlider(),
                          Card(
                              color: cLogoColorW,
                              child: DPadding(
                                  val: .01,
                                  child: WTextB4('للمزيد اسحب الشاشة يميناً')))
                        ],
                      ),
                    ));
                  else
                    return Container(child: GuideBody());
                })),
      ),
    );
  }
}
