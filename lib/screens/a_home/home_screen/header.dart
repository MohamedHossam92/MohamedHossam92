import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/bottom_navigation_bar.dart';
import 'package:the_smart_workshop/screens/a_home/screens/settings/a_settings.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeHeader extends StatelessWidget {
  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            DPadding(
              child: Image.asset(
                'assets/images/logo.png',
                height: size.height * .1,
              ),
            ),
            BTextB8('الورشة الذكية'),
            Spacer(),
            MyDrawer(Setting())
          ],
        ),
        // cubit.getUserTypePrefs == 0
        //     ? Container(
        //         height: size.height * .05,
        //         width: size.width * .9,
        //         child: Center(
        //           child: CarouselSlider(
        //               options: CarouselOptions(
        //                 height: size.height * .2,
        //                 initialPage: 0,
        //                 autoPlay: true,
        //                 autoPlayInterval: Duration(seconds: 4),
        //                 autoPlayAnimationDuration:
        //                     Duration(milliseconds: 800),
        //                 autoPlayCurve: Curves.fastOutSlowIn,
        //                 enlargeCenterPage: true,
        //                 onPageChanged: (i, change) {},
        //                 scrollDirection: Axis.vertical,
        //               ),
        //               items: [
        //                 Row(
        //                   children: [
        //                     Icon(
        //                       Icons.check_circle,
        //                     ),
        //                     BTextB4(
        //                         '  أسعار الألومنيوم اليوم $dateFormat'),
        //                   ],
        //                 ),
        //                 BTextB4('فضي : من 68 جنية لـ 73 جنية'),
        //                 BTextB4('الشريف علي حسن : 81.8 جنية'),
        //                 BTextB4('ألوميل : 107 جنية'),
        //                 BTextB4('ڤالڤ : 90 جنية'),
        //                 BTextB4(
        //                     'بورصة لندن لمعدن الألومنيوم : 2602.5 دولار للطن'),
        //               ]),
        //         ),
        //       )
        //     : DPadding(
        //         child: BTextB4(
        //             'أهلاً وسهلاً بك في تطبيق #الورشة_الذكية')),
      ],
    ));
  }
}

class MyDrawer extends StatelessWidget {
  final Widget navigatePage;

  const MyDrawer(this.navigatePage);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;

          return Container(
            width: size.width * .27,
            decoration: BoxDecoration(
                gradient: cWhiteGradient,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 1),
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  constraints: BoxConstraints(maxWidth: 30),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showBottomSheet(
                        context: (context),
                        builder: (context) => SingleChildScrollView(
                              child: Container(
                                width: size.width * .7,
                                decoration:
                                    BoxDecoration(gradient: cLogoGradient),
                                child: Column(
                                  children: [
                                    DPadding(
                                      child: CircleAvatar(
                                          radius: size.height * .075,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            'assets/images/logo.png',
                                            height: size.height * .2,
                                          )),
                                    ),
                                    Column(
                                        children: myBottomAppBar
                                            .map((e) => Column(
                                                  children: [
                                                    SPadding(
                                                      v: .002,
                                                      h: .02,
                                                      child: Card(
                                                        child: ListTile(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pushNamed(
                                                                context,
                                                                e.onPressed);
                                                          },
                                                          leading: Icon(
                                                            e.icon,
                                                            color: e.color,
                                                          ),
                                                          title:
                                                              BTextB4(e.title),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            .toList()),
                                    Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await launch(
                                            'https://m.facebook.com/SwTalapp');
                                      },
                                      child: Container(
                                        width: size.width * .62,
                                        height: size.height * .28,
                                        child: Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  color: Colors.indigo,
                                                  child: DPadding(
                                                      child: WTextB4(
                                                          'إضغط هنا وشارك في المسابقة'))),
                                              BTextB4('شارك معنا في المسابقة'),
                                              BTextB4(
                                                  'أرسل لنا لقطة شاشة من هنا'),
                                              BTextB4('بهذا الرقم'),
                                              Container(
                                                  color: Colors.black,
                                                  child: DPadding(
                                                      child: WTextB8(
                                                          componentCubit.id
                                                              .toString()))),
                                              Container(
                                                  color: Colors.black,
                                                  child: DPadding(
                                                      child: YTextB5(
                                                          'واربح الجائزة'))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => navigatePage));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  constraints: BoxConstraints(maxWidth: 30),
                ),
              ],
            ),
          );
        });
  }
}
