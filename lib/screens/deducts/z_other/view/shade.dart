import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/exit_message.dart';
import 'package:the_smart_workshop/screens/a_home/screens/settings/a_settings.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/deduct_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/list_is_empty.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/text_form.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/model/shade_data.dart';

class Shade extends StatelessWidget {
  const Shade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);
          return BlocConsumer<OtherDeductCubit, OtherDeductState>(
              listener: (context, state) {},
              builder: (context, state) {
                OtherDeductCubit otherCubit = BlocProvider.of(context);
                return DOnWillPop(
                    toExit: () {
                      otherCubit.clearList(true);

                      Navigator.of(context).pop(true);
                    },
                    child: Scaffold(
                        body: DeductHome(
                            appBarTitle: 'التندا الايطالي',
                            drawerNavigatePage: Setting(),
                            addNewBody: Column(
                              children: [
                                Container(
                                  height: size.width * .42,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children:
                                                otherCubit.shadeList.isNotEmpty
                                                    ? List.generate(
                                                        otherCubit
                                                            .shadeList.length,
                                                        (i) => Stack(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          children: [
                                                            DPadding(
                                                              val: .008,
                                                              child: Container(
                                                                height:
                                                                    size.height *
                                                                        .4,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              blurRadius: 5,
                                                                              offset: Offset(0, 1),
                                                                              spreadRadius: 0)
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                child: DPadding(
                                                                  val: .008,
                                                                  child: Column(
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          DPadding(
                                                                            child:
                                                                                Image.asset('assets/images/other/shade.jpg', width: size.width * .32),
                                                                          ),
                                                                          BTextB4(
                                                                              '${otherCubit.shadeList[i].width} * ${otherCubit.shadeList[i].height} '),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  otherCubit.removeItem(
                                                                      otherCubit
                                                                          .shadeList,
                                                                      i);
                                                                },
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    : [ListIsEmpty()],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 3,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/other/shade.jpg',
                                    fit: BoxFit.cover,
                                    width: size.width,
                                  ),
                                ),
                              ],
                            ),
                            detailsEdit: Column(
                              children: [
                                Divider(
                                  thickness: 3,
                                  color: Colors.black,
                                ),
                                AddSize(),
                              ],
                            ),
                            showResultAction: () {},
                            showResultBody: PageView.builder(
                                itemCount: otherCubit.shadeList.length,
                                itemBuilder: (context, i) {
                                  List cutTitle = [
                                    'مقاس',
                                    otherCubit.shadeList[i].firstWidth(),
                                    otherCubit.shadeList[i].otherWidth(),
                                    otherCubit.shadeList[i].firstHeight(),
                                    otherCubit.shadeList[i].otherHeight(),
                                  ];

                                  int length = otherCubit.shadeList[i].length;
                                  List<String> cutLength = [
                                    'عدد',
                                    '$length',
                                    '${length * 4}',
                                    '${length * 2}',
                                    '${length * 8}'
                                  ];
                                  return Column(
                                    children: [
                                      Card(
                                        color: Colors.lightGreen.shade300,
                                        child: DPadding(
                                          child:
                                              BTextB6('    تقرير التندا    '),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          color: Colors.black12,
                                          child: DPadding(
                                              child: BTextB5(
                                                  'تقرير قص الألومنيوم')),
                                        ),
                                      ),
                                      Table(
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        columnWidths: {
                                          0: FixedColumnWidth(size.width * .6),
                                        },
                                        children: List.generate(
                                            5,
                                            (j) => TableRow(children: [
                                                  Card(
                                                      color: Colors.white12,
                                                      child: DPadding(
                                                          child: Center(
                                                              child: BTextB5(
                                                                  '${cutTitle[j]}')))),
                                                  Card(
                                                      color: Colors.white70,
                                                      child: DPadding(
                                                          child: Center(
                                                              child: BTextB5(
                                                                  cutLength[
                                                                      j])))),
                                                ])),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          color: Colors.black12,
                                          child: DPadding(
                                              child: BTextB5('تقرير الخامات')),
                                        ),
                                      ),
                                      Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: {
                                            0: FixedColumnWidth(
                                                size.width * .6),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Card(
                                                  color: Colors.white12,
                                                  child: DPadding(
                                                      child: Center(
                                                          child: BTextB5(
                                                              'الألومنيوم')))),
                                              Card(
                                                  color: Colors.white70,
                                                  child: DPadding(
                                                      child: Center(
                                                          child: BTextB5(
                                                              '${otherCubit.shadeList[i].aluminum().round()} عود')))),
                                            ]),
                                            TableRow(children: [
                                              Card(
                                                  color: Colors.white12,
                                                  child: DPadding(
                                                      child: Center(
                                                          child: BTextB5(
                                                              'الجلـــد')))),
                                              Card(
                                                  color: Colors.white70,
                                                  child: DPadding(
                                                      child: Center(
                                                          child: BTextB5(
                                                              '${(otherCubit.shadeList[i].leather() * length).toStringAsFixed(1)} م ')))),
                                            ]),
                                          ]),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          color: Colors.black12,
                                          child: DPadding(
                                              child: BTextB5(
                                                  'مقاس الجلد في كل باكية')),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.white12,
                                        child: DPadding(
                                          val: .06,
                                          child: BTextB6(
                                              '${otherCubit.shadeList[i].splitLeather()} سم'),
                                        ),
                                      ),
                                      if (otherCubit.shadeList.length > 1)
                                        Card(
                                          color: Colors.red.shade200,
                                          child: DPadding(
                                            child: BTextB4(
                                                'تقرير التند الأخري اسحب الشاشة يميناً'),
                                          ),
                                        )
                                    ],
                                  );
                                }),
                            onTapAddNew: () {
                              MyShadeData s = MyShadeData(componentCubit.width,
                                  componentCubit.height, componentCubit.length);
                              otherCubit.addItemToList(s);
                            })));
              });
        });
  }
}
