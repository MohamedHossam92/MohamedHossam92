import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/widget/button.dart';
import 'package:the_smart_workshop/component/widget/table.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/class.dart';

List<ResultData> resultDataList = [];

class ResultHome extends StatelessWidget {
  final bool isCorner;
  final Widget cornerDetails;
  ResultHome({this.isCorner = false, this.cornerDetails = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                resultDataList.length,
                (i) => GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultHomeContent(i)));
                  },
                  child: DPadding(
                    child: Container(
                      width: size.width * .95,
                      height: size.height * .1,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                              spreadRadius: 0)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [color1[i], color2[i]]),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 7,
                            child: DPadding(
                              child: Icon(
                                icon[i],
                              ),
                            ),
                          ),
                          DPadding(
                              val: .05,
                              child: WTextB8(resultDataList[i].title)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isCorner)
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => cornerDetails));
            },
            child: DPadding(
              child: Container(
                width: size.width * .95,
                height: size.height * .1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                        spreadRadius: 0)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.black54, Colors.black]),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 7,
                      child: DPadding(
                        child: Icon(
                          Icons.file_copy_sharp,
                        ),
                      ),
                    ),
                    DPadding(val: .05, child: WTextB8('تقرير الركنة')),
                  ],
                ),
              ),
            ),
          ),
        GestureDetector(
            onTap: () async {
              await launch(whatsApp(phone: '01020608160', message: 'لصق شريط'));
            },
            child: Image.asset('assets/images/new/hpl.png'))
      ],
    );
  }
}

class ResultHomeContent extends StatelessWidget {
  final int i;

  const ResultHomeContent(this.i);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit =
              BlocProvider.of<ComponentCubit>(context);
          return WillPopScope(
              onWillPop: () async {
                componentCubit.pageIndexChange(0);
                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.black54,
                  body: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                          itemCount: resultDataList[i].list.length,
                          scrollDirection: Axis.vertical,
                          onPageChanged: (s) {
                            componentCubit.pageIndexChange(s);
                          },
                          itemBuilder: (context, j) {
                            if (resultDataList[i].i2)
                              return Table1RowHeader(
                                  title: resultDataList[i].list[j].title,
                                  child: Table1RowBody(
                                      resultDataList[i].list[j].list));
                            else if (resultDataList[i].i4)
                              return j <= 1
                                  ? Table3RowHeader(
                                      title: resultDataList[i].list[j].title,
                                      i: j,
                                      child: Table3RowBody(
                                          resultDataList[i].list[j].list))
                                  : Table1RowHeader(
                                      title: resultDataList[i].list[j].title,
                                      child: Table1RowBody(
                                          resultDataList[i].list[j].list));
                            else
                              return Table2RowHeader(
                                  title: resultDataList[i].list[j].title,
                                  child: Table2RowBody(
                                      resultDataList[i].list[j].list));
                          }),
                      Positioned(
                          top: size.height * .09,
                          left: size.width * .02,
                          child: Card(
                            color: cLogoColorW,
                            child: SPadding(
                              h: .03,
                              v: 0,
                              child: WTextB4(
                                  '${componentCubit.pageIndex + 1} / ${resultDataList[i].list.length}'),
                            ),
                          )),
                      Positioned(
                          top: size.height * .01,
                          left: size.width * .02,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: size.width * .15,
                          )),
                      Positioned(
                          bottom: size.height * .01,
                          right: size.width * .02,
                          child: ExitButton())
                    ],
                  ),
                ),
              ));
        });
  }
}

class ResultBodyData {
  final String title;
  final Widget child;

  ResultBodyData({required this.title, required this.child});
}

final List color1 = [
  Colors.pink.shade500,
  Colors.green.shade500,
  Colors.brown.shade500,
  Colors.blue.shade500,
  Colors.purple.shade500,
  Colors.indigo.shade500,
];
final List color2 = [
  Colors.pink.shade900,
  Colors.green.shade900,
  Colors.brown.shade900,
  Colors.blue.shade900,
  Colors.purple.shade900,
  Colors.indigo.shade900,
];

final List<IconData> icon = [
  Icons.close_fullscreen_outlined,
  Icons.carpenter_rounded,
  Icons.category_rounded,
  Icons.confirmation_number_sharp,
  Icons.tab,
  Icons.ad_units,
];
