import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/sql/slide_windows/add_new.dart';
import 'package:the_smart_workshop/sql/slide_windows/const.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/slide_windows/slide_deduct_list.dart';

import '../deduct_empty.dart';
import 'cubit/state.dart';

class SlideSettingContent extends StatelessWidget {
  static String id = 'SlideSettingContent';
  final int index;

  const SlideSettingContent(this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<SQLSlideCubit, SQLSlideState>(
        listener: (context, state) {},
        builder: (context, state) {
          SQLSlideCubit sqlSlideCubit = BlocProvider.of(context);
          return SafeArea(
              child: Scaffold(
            body: AppBackGround(
                child: oneSlideSystemList.isNotEmpty
                    ? PageView.builder(
                        itemCount: oneSlideSystemList.length,
                        itemBuilder: (context, j) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DPadding(
                                      val: .01,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.black54),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/windows/systems/s00${index}.png'))),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        color: Colors.black54,
                                        child: DPadding(
                                            child: WTextB6(oneSlideSystemList[j]
                                                [cSWindowsProfile])),
                                      ),
                                    ),
                                    DPadding(
                                      val: .01,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        width: size.width * .15,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 3,
                                ),
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FixedColumnWidth(size.width * .27),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Text(''),
                                      Card(
                                          color: Colors.white12,
                                          child: DPadding(
                                              child: Center(
                                                  child: BTextB5('الدرف')))),
                                      Card(
                                          color: Colors.white12,
                                          child: DPadding(
                                              child: Center(
                                                  child: BTextB5('السلك')))),
                                    ]),
                                  ],
                                ),
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: FixedColumnWidth(size.width * .27),
                                    },
                                    children: List.generate(
                                      5,
                                      (i) => TableRow(children: [
                                        Card(
                                            color: Colors.white12,
                                            child: Center(
                                                child: DPadding(
                                                    val: i == 1 || i == 2
                                                        ? 0
                                                        : .02,
                                                    child: BTextB5(
                                                        deductContentList(j)[i]
                                                            .title)))),
                                        Card(
                                            color: Colors.white70,
                                            child: DPadding(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BTextB5(deductContentList(j)[i]
                                                    .equal),
                                                BTextB5(
                                                    '${i == 4 ? '-  ' : ''}${deductContentList(j)[i].deductSash.toStringAsFixed(0)} مم'),
                                                if (i != 4) BTextB5('/'),
                                                BTextB5(deductContentList(j)[i]
                                                    .sashLength),
                                              ],
                                            ))),
                                        Card(
                                            color: Colors.white70,
                                            child: DPadding(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BTextB5(deductContentList(j)[i]
                                                    .equal),
                                                BTextB5(
                                                    '${i == 4 ? '-  ' : ''}${deductContentList(j)[i].deductFly.toStringAsFixed(0)} مم'),
                                                if (i != 4) BTextB5('/'),
                                                BTextB5(deductContentList(j)[i]
                                                    .sashLength),
                                              ],
                                            ))),
                                      ]),
                                    )),
                                Container(
                                    width: double.infinity,
                                    child: Card(
                                        color: Colors.black12,
                                        child: DPadding(
                                            child: Center(
                                                child: BTextB5('المكملات'))))),
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FixedColumnWidth(size.width * .4),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Card(
                                          color: Colors.white12,
                                          child: Center(
                                              child: DPadding(
                                                  child: BTextB5('السكينة')))),
                                      Card(
                                          color: Colors.white70,
                                          child: DPadding(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BTextB5(
                                                  '-  ${data(j, cSHeightHookDeduct).toStringAsFixed(0)} مم '),
                                            ],
                                          ))),
                                    ]),
                                    TableRow(children: [
                                      Card(
                                          color: Colors.white12,
                                          child: Center(
                                              child: DPadding(
                                                  child: BTextB5('التقابل')))),
                                      Card(
                                          color: Colors.white70,
                                          child: DPadding(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BTextB5(
                                                  '-  ${data(j, cSHeightAdjoiningDeduct).toStringAsFixed(0)} مم '),
                                            ],
                                          ))),
                                    ]),
                                  ],
                                ),
                                Card(
                                    color: Colors.black12,
                                    child: DPadding(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BTextB5('الزجـاج'),
                                        BTextB4(
                                            'تخصيم الزجاج يكون من مقاس الدرفة')
                                      ],
                                    ))),
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FixedColumnWidth(size.width * .4),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Card(
                                          color: Colors.white12,
                                          child: Center(
                                              child: DPadding(
                                                  child: BTextB5('العرض')))),
                                      Card(
                                          color: Colors.white70,
                                          child: DPadding(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BTextB5(
                                                  '-  ${data(j, cSWidthGlassDeduct).toStringAsFixed(0)} مم '),
                                            ],
                                          ))),
                                    ]),
                                    TableRow(children: [
                                      Card(
                                          color: Colors.white12,
                                          child: Center(
                                              child: DPadding(
                                                  child: BTextB5('الارتفاع')))),
                                      Card(
                                          color: Colors.white70,
                                          child: DPadding(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BTextB5(
                                                  '-  ${data(j, cSHeightGlassDeduct).toStringAsFixed(0)} مم '),
                                            ],
                                          ))),
                                    ]),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    sqlSlideCubit.editDeducts(
                                        idOld: (oneSlideSystemList[j][cSId]),
                                        countryOld: (oneSlideSystemList[j]
                                            [cSCountry]),
                                        windowsSystemOld: (oneSlideSystemList[j]
                                            [cSWindowsSystem]),
                                        windowsProfileOld:
                                            (oneSlideSystemList[j]
                                                [cSWindowsProfile]),
                                        widthSashDeduct2Old:
                                            editContent(j, cSWidthSashDeduct2),
                                        widthSashDeduct4Old:
                                            editContent(j, cSWidthSashDeduct4),
                                        widthSashDeduct32Old:
                                            editContent(j, cSWidthSashDeduct32),
                                        widthSashDeduct33Old:
                                            editContent(j, cSWidthSashDeduct33),
                                        widthFlyScreenDeduct2Old: editContent(
                                            j, cSWidthFlyScreenDeduct2),
                                        widthFlyScreenDeduct4Old: editContent(
                                            j, cSWidthFlyScreenDeduct4),
                                        widthFlyScreenDeduct32Old: editContent(
                                            j, cSWidthFlyScreenDeduct32),
                                        widthFlyScreenDeduct33Old: editContent(
                                            j, cSWidthFlyScreenDeduct33),
                                        heightSashDeductOld:
                                            editContent(j, cSHeightSashDeduct),
                                        heightFluScreenDeductOld: editContent(
                                            j, cSHeightFluScreenDeduct),
                                        heightHookDeductOld:
                                            editContent(j, cSHeightHookDeduct),
                                        heightAdjoiningDeductOld: editContent(
                                            j, cSHeightAdjoiningDeduct),
                                        widthGlassDeductOld:
                                            editContent(j, cSWidthGlassDeduct),
                                        heightGlassDeductOld:
                                            editContent(j, cSHeightGlassDeduct),
                                        weightFrameOld:
                                            weightContent(j, cSWeightFrame),
                                        weightFrameWithoutBarOld: weightContent(j, cSWeightFrameWithoutBar),
                                        weightSashOld: weightContent(j, cSWeightSash),
                                        weightFlyScreenOld: weightContent(j, cSWeightFlyScreen),
                                        weightHookOld: weightContent(j, cSWeightHook),
                                        weightAdjoiningOld: weightContent(j, cSWeightAdjoining),
                                        weightFixOld: weightContent(j, cSWeightFix),
                                        weightTOld: weightContent(j, cSWeightT),
                                        weightBeadOld: weightContent(j, cSWeightBead),
                                        weightBarOld: weightContent(j, cSWeightBar),
                                        frameFixSizeOld: editContent(j, cSFrameFixSize),
                                        beadSizeOld: editContent(j, cSBeadSize),
                                        trackDeductSizeOld: editContent(j, cSTrackDeduct));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddNewSlideDeduct(
                                                    oneSlideSystemList[j]
                                                            [cSWindowsSystem] ==
                                                        qPVC,
                                                    true)));
                                  },
                                  child: Card(
                                    color: cLogoColorW,
                                    child: DPadding(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          WTextB5('لتعديل التخصيمات اضغط هنا')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (oneSlideSystemList[j][cSId] >
                                        allSlideDeductList.length)
                                      GestureDetector(
                                        onTap: () {
                                          sqlSlideCubit.deleteDataFromDb(
                                              oneSlideSystemList[j][cSId]);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(dSnackBarShowResult(
                                                  title:
                                                      'تم حذف قطاع ${oneSlideSystemList[j][cSWindowsProfile]} بنجاح  .'));
                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          child: SPadding(
                                              v: .015,
                                              h: .1,
                                              child: WTextB4('حذف القطاع')),
                                          color: cLogoColorW,
                                        ),
                                      ),
                                    BTextB4('للمزيد اسحب يميناً')
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
                    : MyDeductIsEmpty(true)),
          ));
        });
  }
}

editContent(j, column) =>
    double.parse((oneSlideSystemList[j][column]).toStringAsFixed(1));
weightContent(j, column) =>
    double.parse((oneSlideSystemList[j][column]).toStringAsFixed(1));

class DeductContentList {
  final String title, equal, sashLength;
  final double deductSash, deductFly;

  DeductContentList(
      {required this.title,
      required this.equal,
      required this.sashLength,
      required this.deductSash,
      required this.deductFly});
}

data(j, column) => (oneSlideSystemList[j][column] * 10).abs();

List<DeductContentList> deductContentList(j) => [
      DeductContentList(
        title: '2 درفة',
        equal: '${oneSlideSystemList[j][cSWidthSashDeduct2] >= 0 ? '+' : '-'}',
        sashLength: '2',
        deductSash: data(j, cSWidthSashDeduct2),
        deductFly: data(j, cSWidthFlyScreenDeduct2),
      ),
      DeductContentList(
        title: '3 درفة / \n 3سكة',
        equal: '${oneSlideSystemList[j][cSWidthSashDeduct33] >= 0 ? '+' : '-'}',
        sashLength: '3',
        deductSash: data(j, cSWidthSashDeduct33),
        deductFly: data(j, cSWidthFlyScreenDeduct33),
      ),
      DeductContentList(
        title: '3 درفة / \n 2سكة',
        equal: '${oneSlideSystemList[j][cSWidthSashDeduct32] >= 0 ? '+' : '-'}',
        sashLength: '3',
        deductSash: data(j, cSWidthSashDeduct32),
        deductFly: data(j, cSWidthFlyScreenDeduct32),
      ),
      DeductContentList(
        title: '4 درفة',
        equal: '${oneSlideSystemList[j][cSWidthSashDeduct4] >= 0 ? '+' : '-'}',
        sashLength: '4',
        deductSash: data(j, cSWidthSashDeduct4),
        deductFly: data(j, cSWidthFlyScreenDeduct4),
      ),
      DeductContentList(
        title: 'الارتفاع',
        equal: '',
        sashLength: '',
        deductSash: data(j, cSHeightSashDeduct),
        deductFly: data(j, cSHeightFluScreenDeduct),
      ),
    ];
