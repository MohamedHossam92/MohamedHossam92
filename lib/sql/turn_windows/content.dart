import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/sql/turn_windows/add_new.dart';
import 'package:the_smart_workshop/sql/turn_windows/const.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/state.dart';
import 'package:the_smart_workshop/sql/turn_windows/turn_deduct_list.dart';

import '../deduct_empty.dart';

class TurnSettingContent extends StatelessWidget {
  final int index;

  const TurnSettingContent(this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SQLTurnCubit, SQLTurnState>(
        listener: (context, state) {},
        builder: (context, state) {
          SQLTurnCubit sqlTurnCubit = BlocProvider.of(context);
          return SafeArea(
            child: Scaffold(
              body: AppBackGround(
                  child: oneTurnSystemList.isNotEmpty
                      ? PageView.builder(
                          itemCount: oneTurnSystemList.length,
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
                                              child: WTextB6(
                                                  oneTurnSystemList[j]
                                                      [cTWindowsProfile])

                                              // WTextB6(oneSlideSystemList[j]
                                              // [cSWindowsProfile])

                                              ),
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
                                  Card(
                                      color: Colors.black12,
                                      child: DPadding(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BTextB5('التخصيم'),
                                          BTextB4(
                                              'يتم تزويد قيمة التخصيم من الداخل')
                                        ],
                                      ))),
                                  Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: FixedColumnWidth(size.width * .65),
                                      2: FixedColumnWidth(size.width * .2),
                                    },
                                    children: List.generate(
                                        3,
                                        (i) => TableRow(children: [
                                              Card(
                                                  color: Colors.white12,
                                                  child: DPadding(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      BTextB5(
                                                          '${deductContentList(j)[i].title}'),
                                                    ],
                                                  ))),
                                              Card(
                                                color: Colors.white70,
                                                child: Center(
                                                  child: SPadding(
                                                      v: .02,
                                                      h: .04,
                                                      child: BTextB5(
                                                          '${deductContentList(j)[i].deduct.toStringAsFixed(0)} مم')),
                                                ),
                                              ),
                                            ])),
                                  ),
                                  Card(
                                      color: Colors.black12,
                                      child: DPadding(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BTextB5(
                                              'تخصيم ${oneTurnSystemList[j][cTSystemType] == qPVC ? 'البوكلير' : 'مرد الدرفة'}'),
                                          BTextB4('يتم الخصم من ارتفاع الدرفة')
                                        ],
                                      ))),
                                  Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: FixedColumnWidth(size.width * .65),
                                      2: FixedColumnWidth(size.width * .2),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Card(
                                            color: Colors.white12,
                                            child: DPadding(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BTextB5('ارتفاع المرد'),
                                              ],
                                            ))),
                                        Card(
                                          color: Colors.white70,
                                          child: Center(
                                            child: SPadding(
                                                v: .02,
                                                h: .04,
                                                child: BTextB5(
                                                    '${data(j, cTDeductTCenter).toStringAsFixed(0)} مم')),
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                  Card(
                                      color: Colors.black12,
                                      child: DPadding(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BTextB5('أبعاد القطاع'),
                                        ],
                                      ))),
                                  Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: {
                                        0: FixedColumnWidth(size.width * .45),
                                        2: FixedColumnWidth(size.width * .2),
                                      },
                                      children: List.generate(
                                          deductProfileList(j).length,
                                          (i) => TableRow(children: [
                                                Card(
                                                    color: Colors.white12,
                                                    child: Center(
                                                        child: DPadding(
                                                            child: BTextB5(
                                                                deductProfileList(
                                                                        j)[i]
                                                                    .title)))),
                                                Card(
                                                    color: Colors.white70,
                                                    child: DPadding(
                                                        child: Center(
                                                      child: BTextB5(
                                                          '${deductProfileList(j)[i].deduct.toStringAsFixed(0)} مم '),
                                                    ))),
                                              ]))),
                                  GestureDetector(
                                    onTap: () {
                                      sqlTurnCubit.editDeducts(
                                          idOld: oneTurnSystemList[j][cTId],
                                          countryOld: oneTurnSystemList[j]
                                              [cTCountry],
                                          windowsSystemOld: oneTurnSystemList[j]
                                              [cTSystemType],
                                          windowsProfileOld:
                                              oneTurnSystemList[j]
                                                  [cTWindowsProfile],
                                          oneSashDeDuctOld:
                                              editContent(j, cTOneSashDeDuct),
                                          towSashDeDuctOld:
                                              editContent(j, cTTowSashDeDuct),
                                          heightSashDeductOld: editContent(
                                              j, cTHeightSashDeduct),
                                          deductFrameWithBarOld: editContent(
                                              j, cTDeductFrameWithBar),
                                          deductFrameWithFex2Old: editContent(
                                              j, cTDeductFrameWithFex),
                                          beadOld: editContent(j, cTBead),
                                          deductSmallZOld:
                                              editContent(j, cTDeductSmallZ),
                                          deductLargeZOld:
                                              editContent(j, cTDeductLargeZ),
                                          deductTCenterOld:
                                              editContent(j, cTDeductTCenter),
                                          weightFrameOld:
                                              editContent(j, cTWeightFrame),
                                          weightFrameWithFexOld: editContent(
                                              j, cTWeightFrameWithFex),
                                          weightSashOld:
                                              editContent(j, cTWeightSash),
                                          weightPandaOld:
                                              editContent(j, cTWeightPanda),
                                          weightTOld: editContent(j, cTWeightT),
                                          weightBeadOld:
                                              editContent(j, cTWeightBead),
                                          weightBarOld:
                                              editContent(j, cTWeightBar));

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewTurnDeduct(
                                                      oneTurnSystemList[j]
                                                              [cTSystemType] ==
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
                                      if (oneTurnSystemList[j][cTId] >
                                          allTurnDeductList.length)
                                        GestureDetector(
                                          onTap: () {
                                            sqlTurnCubit.deleteDataFromDb(
                                                oneTurnSystemList[j][cTId]);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(dSnackBarShowResult(
                                                    title:
                                                        'تم حذف قطاع ${oneTurnSystemList[j][cTWindowsProfile]} بنجاح  .'));
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
                      : MyDeductIsEmpty(false)),
            ),
          );
        });
  }
}

double data(j, column) => (oneTurnSystemList[j][column] * 10).abs();

class DeductContentList {
  final String title, img;
  final double deduct;

  DeductContentList(
      {required this.title, required this.deduct, required this.img});
}

editContent(j, column) =>
    double.parse((oneTurnSystemList[j][column]).toStringAsFixed(1));

List<DeductContentList> deductProfileList(j) => [
      DeductContentList(
          title:
              'حلق ${oneTurnSystemList[j][cTSystemType] == qPVC ? 'بار 4 سم' : 'ببار'}',
          deduct: data(j, cTDeductFrameWithBar),
          img: ''),
      DeductContentList(
          title:
              'حلق بار ${oneTurnSystemList[j][cTSystemType] == qPVC ? '6 سم' : 'خارجي'}',
          deduct: data(j, cTDeductFrameWithFex),
          img: ''),
      DeductContentList(
          title:
              '${oneTurnSystemList[j][cTSystemType] == qPVC ? 'درفة كبيرة' : 'Z كبير'} ',
          deduct: data(j, cTDeductLargeZ),
          img: ''),
      DeductContentList(
          title:
              '${oneTurnSystemList[j][cTSystemType] == qPVC ? 'درفة صغيرة' : 'z صغير'} ',
          deduct: data(j, cTDeductSmallZ),
          img: ''),
      DeductContentList(title: 'الباكتة', deduct: data(j, cTBead), img: ''),
    ];

List<DeductContentList> deductContentList(j) => [
      DeductContentList(
          title: 'العرض 1 درفة', deduct: data(j, cTOneSashDeDuct), img: ''),
      DeductContentList(
          title: 'العرض 2 درفة', deduct: data(j, cTTowSashDeDuct), img: ''),
      DeductContentList(
          title: 'ارتفاع الدرفة', deduct: data(j, cTHeightSashDeduct), img: ''),
    ];
