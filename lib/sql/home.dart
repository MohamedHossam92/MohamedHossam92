import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/windows/slide_home.dart';
import 'package:the_smart_workshop/screens/deducts/windows/tilt_home.dart';
import 'package:the_smart_workshop/screens/deducts/windows/turn_home.dart';
import 'package:the_smart_workshop/sql/slide_windows/add_new.dart';
import 'package:the_smart_workshop/sql/slide_windows/const.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/state.dart';
import 'package:the_smart_workshop/sql/turn_windows/add_new.dart';
import 'package:the_smart_workshop/sql/turn_windows/const.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/state.dart';

import 'slide_windows/content.dart';
import 'turn_windows/content.dart';

class SlideDeductSetting extends StatelessWidget {
  static String id = 'SlideDeductSetting';

  final bool isSetting, isSlide, isTilt;

  SlideDeductSetting(
      [this.isSetting = true, this.isSlide = true, this.isTilt = false]);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List oneList = isSlide ? oneSlideSystemList : oneTurnSystemList;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SQLSlideCubit()..getDataFromDb()),
        BlocProvider(create: (context) => SQLTurnCubit()..getDataFromDb()),
      ],
      child: BlocConsumer<SQLSlideCubit, SQLSlideState>(
          listener: (context, state) {},
          builder: (context, state) {
            SQLSlideCubit sqlSlideCubit = BlocProvider.of(context);
            return BlocConsumer<SQLTurnCubit, SQLTurnState>(
              listener: (context, state) {},
              builder: (context, state) {
                SQLTurnCubit sqlTurnCubit = BlocProvider.of(context);
                Size size = MediaQuery.of(context).size;

                return SafeArea(
                  child: Scaffold(
                    key: _scaffoldKey,
                    body: AppBackGround(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: List.generate(
                              7,
                              (i) => GestureDetector(
                                onDoubleTap: () {
                                  sqlSlideCubit.insertAllDeduct();
                                  sqlTurnCubit.insertAllDeduct();
                                },
                                onTap: () {
                                  isSlide
                                      ? sqlSlideCubit
                                          .addOneSystemList(systemName[i])
                                      : sqlTurnCubit
                                          .addOneSystemList(systemName[i]);

                                  isSetting
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => isSlide
                                                  ? SlideSettingContent(i)
                                                  : TurnSettingContent(i)))
                                      : _scaffoldKey.currentState!
                                          .showBottomSheet(
                                              (context) =>
                                                  SingleChildScrollView(
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                              children: oneList
                                                                      .isNotEmpty
                                                                  ? oneList
                                                                      .map((e) {
                                                                      return DPadding(
                                                                          val:
                                                                              .04,
                                                                          child: SizedBox(
                                                                              width: size.width,
                                                                              child: MaterialButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                    isSlide ? Navigator.push(context, MaterialPageRoute(builder: (context) => AluminumSlideHome(e[cSWindowsProfile]))) : showDialog(context: context, builder: (context) => DialogDetails(e, isTilt));
                                                                                  },

                                                                                  //  ,
                                                                                  color: Colors.white,
                                                                                  child: RTextB5(e[cSWindowsProfile]))));
                                                                    }).toList()
                                                                  : [
                                                                      Card(
                                                                        child:
                                                                            DPadding(
                                                                          child:
                                                                              BTextB6('لايوجد قطاعات'),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      WTextB4(
                                                                          'يمكنك اضافتها إلي قطاعاتك الخاصة'),
                                                                    ]),
                                                          MaterialButton(
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons
                                                                      .threesixty_rounded),
                                                                  WTextB4(
                                                                      'رجوع')
                                                                ],
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              backgroundColor: Colors.black54);
                                },
                                child: DPadding(
                                  child: Column(
                                    children: [
                                      Card(
                                          margin: EdgeInsets.all(0),
                                          color: Colors.black54,
                                          child: DPadding(
                                            child: Image.asset(
                                              'assets/images/windows/systems/s00$i.png',
                                              width: i > 1 && i < 5
                                                  ? size.width * .25
                                                  : null,
                                            ),
                                          )),
                                      Card(
                                          margin: EdgeInsets.all(0),
                                          color: Colors.black12,
                                          child: DPadding(
                                              child: BTextB5(systemName[i]))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 4,
                            color: Colors.black,
                          ),
                          isSetting
                              ? Row(
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
                                                child: WTextB5(
                                                    'اضافة قطاعاتي الخاصة'))
                                          ],
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DialogIsPVC(isSlide));
                                        }),
                                    Image.asset('assets/images/logo.png',
                                        width: size.width * .1),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      width: size.width * .2,
                                    ),
                                    Card(
                                      color: cLogoColorW,
                                      child: DPadding(
                                        child: WTextB5(
                                            'يمكنك اضافة تخصيماتك الخاصة \n من صفحة الإعدادات'),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    )),
                  ),
                );
              },
            );
          }),
    );
  }
}

List<String> systemName = [
  qPS,
  qSh,
  qValve,
  qFolcano,
  qAlumil,
  qPVC,
  qMySystem,
];

class DialogIsPVC extends StatelessWidget {
  final bool isSlide;

  const DialogIsPVC(this.isSlide);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SQLTurnCubit, SQLTurnState>(
        listener: (context, state) {},
        builder: (context, state) {
          SQLTurnCubit sqlTurnCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;

          return Dialog(
              backgroundColor: Colors.black54,
              child: SizedBox(
                height: size.height * .2,
                child: Card(
                  elevation: 7,
                  child: Column(children: [
                    Container(
                      color: Colors.black12,
                      child: DPadding(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BTextB5('تحديد نوع نوع الخامة'),
                        ],
                      )),
                    ),
                    Row(
                      children: List.generate(
                          2,
                          (i) => Container(
                                width: size.width * .35,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Radio(
                                          value: i,
                                          groupValue:
                                              sqlTurnCubit.isPVCValGroup,
                                          onChanged: (val) {
                                            sqlTurnCubit.isPVCState(val);
                                          }),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          sqlTurnCubit.isPVCState(i);
                                        },
                                        child: Container(
                                            color:
                                                sqlTurnCubit.isPVCValGroup == i
                                                    ? Colors.yellow.shade200
                                                    : Colors.white,
                                            child: BTextB5(
                                                '${i == 0 ? 'ألومنيوم' : 'U-PVC'}')))
                                  ],
                                ),
                              )),
                    ),
                    MaterialButton(
                        color: Colors.black54,
                        child: WTextB5('دخول إلي  إضافة التخصيمات'),
                        onPressed: () {
                          if (sqlTurnCubit.isPVCValGroup == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                dSnackBarShowResult(
                                    icon: Icons.error_outline_rounded,
                                    title: 'يجب تحديد نوع الحلق.'));
                          } else {
                            Navigator.pop(context);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => isSlide
                                        ? AddNewSlideDeduct(
                                            sqlTurnCubit.isPVC, false)
                                        : AddNewTurnDeduct(
                                            sqlTurnCubit.isPVC, false)));
                          }
                        })
                  ]),
                ),
              ));
        });
  }
}

class DialogDetails extends StatelessWidget {
  final e;
  final bool isTilt;
  DialogDetails(this.e, this.isTilt);

  final bool isPvc = oneTurnSystemList[0][cTSystemType] == qPVC ? true : false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);
          return Dialog(
              backgroundColor: Colors.black54,
              child: SizedBox(
                height: size.height * .36,
                child: Card(
                  elevation: 7,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.black12,
                          child: DPadding(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BTextB5('تحديد نوع الحلق'),
                            ],
                          )),
                        ),
                        Row(
                          children: List.generate(
                              2,
                              (i) => Container(
                                    width: size.width * .35,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Radio(
                                              value: i,
                                              groupValue:
                                                  componentCubit.barGroupVal,
                                              onChanged: (val) {
                                                componentCubit.groupValChange(
                                                    0, val);
                                              }),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              componentCubit.groupValChange(
                                                  0, i);
                                            },
                                            child: Container(
                                                color: componentCubit
                                                            .barGroupVal ==
                                                        i
                                                    ? Colors.yellow.shade200
                                                    : Colors.white,
                                                child: BTextB5(
                                                    '${isPvc ? i == 0 ? 'بار 4 سم' : 'بار 6 سم' : i == 0 ? 'حلق ببار' : 'حلق فكس'}')))
                                      ],
                                    ),
                                  )),
                        ),
                        Container(
                          color: Colors.black12,
                          child: DPadding(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BTextB5('تحديد نوع الدرفة'),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(
                              2,
                              (i) => Container(
                                    width: size.width * .35,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Radio(
                                              value: i,
                                              groupValue:
                                                  componentCubit.zGroupVal,
                                              onChanged: (val) {
                                                componentCubit.groupValChange(
                                                    1, val);
                                              }),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              componentCubit.groupValChange(
                                                  1, i);
                                            },
                                            child: Container(
                                                color:
                                                    componentCubit.zGroupVal ==
                                                            i
                                                        ? Colors.yellow.shade200
                                                        : Colors.white,
                                                child: BTextB5(
                                                    '${isPvc ? i == 0 ? 'درفة كبيرة' : 'درفة صغيرة' : i == 0 ? 'Z كبير' : 'z صغير'}')))
                                      ],
                                    ),
                                  )),
                        ),
                        MaterialButton(
                            color: Colors.black54,
                            child: WTextB5('دخول إلي صفحة التخصيمات'),
                            onPressed: () {
                              if (componentCubit.barGroupVal == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    dSnackBarShowResult(
                                        icon: Icons.error_outline_rounded,
                                        title: 'يجب تحديد نوع الحلق.'));
                              } else if (componentCubit.zGroupVal == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    dSnackBarShowResult(
                                        icon: Icons.error_outline_rounded,
                                        title: 'يجب تحديد نوع الدرفة.'));
                              } else {
                                Navigator.pop(context);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => isTilt
                                            ? AluminumTiltHome(
                                                e[cTWindowsProfile])
                                            : AluminumTurnHome(
                                                e[cTWindowsProfile])));
                              }
                            })
                      ]),
                ),
              ));
        });
  }
}
