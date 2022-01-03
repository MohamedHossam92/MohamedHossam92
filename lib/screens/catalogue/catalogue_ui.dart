import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/catalogue/show_color.dart';

import 'colors_list.dart';

class Catalogues extends StatefulWidget {
  @override
  _CataloguesState createState() => _CataloguesState();
}

class _CataloguesState extends State<Catalogues>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var colorsValue = colorsData.values.toList();
    var colorsCode = colorsData.keys.toList();
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;
          return SafeArea(
            child: Scaffold(
              backgroundColor:
                  homeCubit.colorBackground ? Colors.white : Colors.black,
              appBar: AppBar(
                title: Text('كتالوجات الألوان'),
                actions: [
                  Switch(
                      inactiveTrackColor: Colors.grey.shade300,
                      value: homeCubit.colorBackground,
                      onChanged: (val) {
                        homeCubit.changeColorBackground(val);
                      })
                ],
              ),
              body: TabBarView(
                  controller: _tabController,
                  children: List.generate(3, (iTab) {
                    List<List<String>> colorTabs = [
                      colorsCode,
                      colorWood,
                      colorGood
                    ];

                    return DPadding(
                      val: .01,
                      child: Container(
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children:
                                List.generate(colorTabs[iTab].length, (i) {
                              child() {
                                return Stack(children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Card(
                                          color: Colors.white70,
                                          child: SPadding(
                                            h: .012,
                                            v: 0,
                                            child: BTextB3(
                                                'كود اللون : ${colorTabs[iTab][i]}'),
                                          )),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: size.height * .04,
                                  )
                                ]);
                              }

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowColor(
                                                iTab, colorTabs[iTab][i])));
                                  },
                                  child: DPadding(
                                    val: .01,
                                    child: Container(
                                      child: Container(
                                        height: size.height * .27,
                                        width: size.width * .3,
                                        child: iTab == 0
                                            ? Container(
                                                color: colorsValue[i],
                                                child: child())
                                            : Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          'assets/images/catalogues/colors_catalogues/${colorTabs[iTab][i]}.jpg',
                                                        ),
                                                        fit: BoxFit.fill)),
                                                child: child(),
                                              ),
                                      ),
                                    ),
                                  ));
                            }),
                          ),
                        ),
                      ),
                    );
                  })),
              bottomNavigationBar: Material(
                color: Colors.transparent,
                child: Card(
                  child: TabBar(
                      indicatorColor: cLogoColorW,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
                      indicatorWeight: 5,
                      controller: _tabController,
                      tabs: List.generate(3, (i) {
                        List<String> title = ['دهانات', 'خشومـ', 'أنتيك'];
                        List<Color> color = [
                          Colors.blue,
                          Colors.brown,
                          Colors.purple
                        ];
                        return Row(
                          children: [
                            Icon(
                              Icons.format_color_fill,
                              color: color[i],
                            ),
                            SPadding(
                              v: .03,
                              h: 0,
                              child: BTextB5(title[i]),
                            )
                          ],
                        );
                      })),
                ),
              ),
            ),
          );
        });
  }
}
