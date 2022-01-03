import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/header.dart';

class DeductHome extends StatefulWidget {
  final String appBarTitle;
  final Widget addNewBody, showResultBody, detailsEdit, drawerNavigatePage;
  final Function? onTapAddNew, showResultAction;

  DeductHome({
    required this.appBarTitle,
    required this.drawerNavigatePage,
    required this.addNewBody,
    required this.showResultBody,
    required this.detailsEdit,
    required this.onTapAddNew,
    required this.showResultAction,
  });

  @override
  State<DeductHome> createState() => _DeductHomeState();
}

class _DeductHomeState extends State<DeductHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: AppBackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/logo.png', width: size.width * .1),
                Expanded(
                  child: Card(
                      color: Colors.black54,
                      child: DPadding(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: WTextB6(widget.appBarTitle)))),
                ),
                SizedBox(
                  width: 20,
                ),
                MyDrawer(widget.drawerNavigatePage)
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child: Container(
                    height: size.height * .82,
                    child: AppBackGround(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(child: widget.addNewBody),
                          widget.detailsEdit,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/logo.png',
                                  width: size.width * .1),
                              MaterialButton(
                                  color: cLogoColorW,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.open_in_new,
                                        color: Colors.white,
                                      ),
                                      DPadding(
                                          child: WTextB5('اضافة مقاس جديد'))
                                    ],
                                  ),
                                  onPressed: () {
                                    widget.onTapAddNew!();
                                  }),
                              Image.asset('assets/images/logo.png',
                                  width: size.width * .1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                widget.showResultBody,
              ]),
            ),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.transparent,
          child: Card(
            color: Colors.white70,
            child: TabBar(
                onTap: (i) {
                  if (i == 1) {
                    widget.showResultAction!();
                    PrayPlay.playPray();
                  }
                },
                indicatorColor: cLogoColorW,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
                indicatorWeight: 5,
                controller: _tabController,
                tabs: List.generate(2, (i) {
                  List<String> title = [
                    'إضافة مقاسات',
                    ' أظهر النتائج',
                  ];

                  List<IconData> icon = [
                    Icons.app_registration,
                    Icons.local_library_sharp
                  ];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        icon[i],
                        color: cLogoColor,
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
    ));
  }
}
