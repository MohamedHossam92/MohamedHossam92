import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/button.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class AlKitchenSitting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => KitchenSettingCubit()..getAllPrefs(),
        child: BlocConsumer<KitchenSettingCubit, KitchenSettingState>(
            listener: (context, state) {},
            builder: (context, state) {
              KitchenSettingCubit kitchenSettingCubit =
                  BlocProvider.of(context);
              List<String> cardTitle = [
                'الوش كله مفرد',
                'العمق كله ${kitchenSettingCubit.isDeepNearly ? 'متقارب' : 'متباعد'}',
                '${kitchenSettingCubit.isBackOut ? 'الظهر كله مفرد' : 'عوارض الظهر ${kitchenSettingCubit.isBackInOut ? 'متباعد' : 'متقارب'}'}',
                'قوائم الظهر ${kitchenSettingCubit.isDeepRemotely ? 'متباعد' : '${kitchenSettingCubit.isBackInOut ? 'متباعد' : 'متقارب'}'}'
              ];
              List<double> bottom = [0, .04, .25, .16];
              List<double> left = [.02, .4, .2, .4];

              List<RowContent> rowContent = [
                RowContent('النوع', [
                  ChooseList('وحدة كاملة', kitchenSettingCubit.isAllUnit,
                      (val) {
                    kitchenSettingCubit.isFaceChanged(val);
                  }),
                  ChooseList('وش رخام', kitchenSettingCubit.isFaceUnit, (val) {
                    kitchenSettingCubit.isFaceChanged(val);
                  }),
                ]),
                RowContent('نوع القطاع', [
                  ChooseList('علبة 2.5', kitchenSettingCubit.isSk25, (val) {
                    kitchenSettingCubit.isSkSizeChanged(2.5, val);
                  }),
                  ChooseList('  3*3 ', kitchenSettingCubit.isSk30, (val) {
                    kitchenSettingCubit.isSkSizeChanged(3, val);
                  }),
                  ChooseList('  4*4 ', kitchenSettingCubit.isSk40, (val) {
                    kitchenSettingCubit.isSkSizeChanged(4, val);
                  }),
                ]),
                RowContent('التجميع', [
                  ChooseList('    عدل    ', kitchenSettingCubit.isHeadDirect,
                      (val) {
                    kitchenSettingCubit.isHeadChanged(val);
                  }),
                  ChooseList(
                      '    رأس حربة   ', kitchenSettingCubit.isHeadCorner,
                      (val) {
                    kitchenSettingCubit.isHeadChanged(val);
                  }),
                ]),
                RowContent('قطاع العمق', [
                  ChooseList('    متقارب    ', kitchenSettingCubit.isDeepNearly,
                      (val) {
                    kitchenSettingCubit.isDeepSystemChanged(val);
                  }),
                  ChooseList(
                      '    متباعد   ', kitchenSettingCubit.isDeepRemotely,
                      (val) {
                    kitchenSettingCubit.isDeepSystemChanged(val);
                  }),
                ]),
                RowContent('تركيب الظهر', [
                  ChooseList('تسقيط', kitchenSettingCubit.isBackIn, (val) {
                    kitchenSettingCubit.isBackTypeChanged(0, val);
                  }),
                  ChooseList('لـطش', kitchenSettingCubit.isBackOut, (val) {
                    kitchenSettingCubit.isBackTypeChanged(2, val);
                  }),
                  ChooseList('تسقيط خارجي', kitchenSettingCubit.isBackInOut,
                      (val) {
                    kitchenSettingCubit.isBackTypeChanged(1, val);
                  }),
                ]),
                RowContent('تجميع الدرج', [
                  ChooseList('  عدل ', kitchenSettingCubit.isDrawer90, (val) {
                    kitchenSettingCubit.isDrawerChange(val);
                  }),
                  ChooseList('مشطوف 45 ', kitchenSettingCubit.isDrawer45,
                      (val) {
                    kitchenSettingCubit.isDrawerChange(val);
                  }),
                ]),
                RowContent('قطاع الرف', [
                  ChooseList('علبة 2.5', kitchenSettingCubit.isRaf25, (val) {
                    kitchenSettingCubit.isRackChange(val);
                  }),
                  ChooseList('قطاع رف', kitchenSettingCubit.isRaf, (val) {
                    kitchenSettingCubit.isRackChange(val);
                  }),
                ]),
              ];
              return SafeArea(
                child: Scaffold(
                  body: AppBackGround(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: size.height * .31,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Positioned(
                                left: size.width * .05,
                                child: Container(
                                    height: size.height * .26,
                                    child: Image.asset(
                                        'assets/images/kitchen_unit/unit_details.png')),
                              ),
                              Stack(
                                children: List.generate(
                                    kitchenSettingCubit.isBackIn ||
                                            kitchenSettingCubit.isBackInOut
                                        ? 4
                                        : 3, (i) {
                                  return Positioned(
                                      bottom: size.height * bottom[i],
                                      left: size.width * left[i],
                                      child: Card(
                                        child: DPadding(
                                          child: BTextB4(cardTitle[i]),
                                        ),
                                      ));
                                }),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 5,
                        ),
                        Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FixedColumnWidth(size.width * .34),
                            },
                            children: List.generate(
                                kitchenSettingCubit.listLength.toInt(),
                                (i) => i < kitchenSettingCubit.listLength - 1
                                    ? TableRow(children: [
                                        Card(
                                            color: Colors.white12,
                                            child: DPadding(
                                                child: Center(
                                                    child: BTextB5(
                                                        rowContent[i].title)))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            rowContent[i].list.length,
                                            (j) => ChoiceChip(
                                                padding: EdgeInsets.all(1),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                selectedColor: Colors.green,
                                                onSelected: rowContent[i]
                                                    .list[j]
                                                    .onSelect,
                                                label: rowContent[i].list[j].val
                                                    ? WTextB4(rowContent[i]
                                                        .list[j]
                                                        .title)
                                                    : BTextB4(rowContent[i]
                                                        .list[j]
                                                        .title),
                                                selected:
                                                    rowContent[i].list[j].val),
                                          ),
                                        ),
                                      ])
                                    : TableRow(children: [
                                        Card(
                                            color: Colors.white12,
                                            child: DPadding(
                                                child: Center(
                                                    child: BTextB5(
                                                        'تخصيم الدرف')))),
                                        Card(
                                            color: Colors.white70,
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  BTextB4('تخصيم الدرف     + '),
                                                  BTextB5(
                                                      '${kitchenSettingCubit.deductShutter.toStringAsFixed(0)}'),
                                                  BTextB4(' مم     من الداخل '),
                                                ],
                                              ),
                                              Container(
                                                  width: size.width * .5,
                                                  child: Slider(
                                                      activeColor: Colors.black,
                                                      inactiveColor:
                                                          Colors.black12,
                                                      min: 14,
                                                      max: 32,
                                                      value: kitchenSettingCubit
                                                          .deductShutter,
                                                      onChanged: (val) {
                                                        kitchenSettingCubit
                                                            .isShutterDeduct(val
                                                                .roundToDouble());
                                                      })),
                                            ]))
                                      ]))),
                        SaveAndCloseButton()
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class ChooseList {
  final String title;
  final bool val;
  final Function(bool?) onSelect;

  ChooseList(this.title, this.val, this.onSelect);
}

class RowContent {
  final String title;
  final List<ChooseList> list;

  RowContent(this.title, this.list);
}
