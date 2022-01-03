import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/exit_message.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/a_home/screens/settings/a_settings.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/class.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/deduct_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/list_is_empty.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/result_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/text_form.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/model/shutter_data.dart';

class Shutter extends StatelessWidget {
  const Shutter({Key? key}) : super(key: key);

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

                List<ResultData> boxComponent = [
                  ResultData('تقطيع الشريحة', otherCubit.sliceList),
                  ResultData('تقطيع الصندوق', otherCubit.BoxList),
                  ResultData('تقطيع الغطاء ', otherCubit.coverList),
                ];

                List<ResultData> slice = [
                  ResultData('تقطيع السفلية', otherCubit.underList),
                  ResultData('تقطيع المجري', otherCubit.streamList),
                  ResultData('تقطيع المحور', otherCubit.xList),
                ];

                List<ResultData> materialData = [
                  ResultData('الخامات', otherCubit.shutterMaterial()),
                ];

                List<ResultData> accessoriesData = [
                  ResultData('الاكسسوارات', otherCubit.shutterAccessories()),
                ];

                List<ResultData> titleList = [
                  ResultData('تقرير الصندوق-الشريحة', boxComponent),
                  ResultData('تقرير المُكملات', slice, true),
                  ResultData('تقرير الخامات', materialData, true),
                  ResultData('تقرير الأكسسوارت', accessoriesData, true),
                ];

                return DOnWillPop(
                    toExit: () {
                      otherCubit.clearList(true);

                      Navigator.of(context).pop(true);
                    },
                    child: Scaffold(
                      body: DeductHome(
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
                                            otherCubit.shutterList.isNotEmpty
                                                ? List.generate(
                                                    otherCubit
                                                        .shutterList.length,
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
                                                                          color: Colors
                                                                              .grey,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: Offset(
                                                                              0,
                                                                              1),
                                                                          spreadRadius:
                                                                              0)
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                            child: DPadding(
                                                              val: .008,
                                                              child: Column(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      DPadding(
                                                                        child: Image.asset(
                                                                            'assets/images/other/shutters.jpg',
                                                                            width:
                                                                                size.width * .32),
                                                                      ),
                                                                      BTextB4(
                                                                          '${otherCubit.shutterList[i].width} * ${otherCubit.shutterList[i].height} '),
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
                                                                      .shutterList,
                                                                  i);
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            )),
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
                                'assets/images/other/shutters.jpg',
                                fit: BoxFit.cover,
                                width: size.width * .85,
                              ),
                            ),
                            AddSize()
                          ],
                        ),
                        showResultBody: otherCubit.shutterList.isNotEmpty
                            ? ResultHome()
                            : ListIsEmpty(),
                        detailsEdit: Card(
                          color: Colors.black,
                          child: Card(
                            color: Colors.grey.shade200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton(
                                  hint: Container(
                                      color: Colors.grey.shade300,
                                      child: DPadding(
                                          child: BTextB5(' مقاس الصندوق'))),
                                  icon: Icon(
                                    Icons.edit,
                                    color: cLogoColorW,
                                  ),
                                  elevation: 5,
                                  iconEnabledColor: cLogoColor,
                                  items: otherCubit.boxSizeList
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: BTextB5('$e سم '),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  value: otherCubit.boxSize,
                                  onChanged: (val) {
                                    otherCubit.detailsChange(0, val);
                                  },
                                ),
                                DropdownButton(
                                  hint: Container(
                                      color: Colors.grey.shade300,
                                      child: DPadding(
                                          child: BTextB5('نوع الشريحة'))),
                                  icon: Icon(
                                    Icons.edit,
                                    color: cLogoColorW,
                                  ),
                                  elevation: 5,
                                  iconEnabledColor: cLogoColor,
                                  items: otherCubit.sliceTypeList.keys
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: BTextB5(e),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  value: otherCubit.sliceType,
                                  onChanged: (val) {
                                    otherCubit.detailsChange(1, val);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        showResultAction: () {
                          otherCubit.addMaterialToLists();
                          componentCubit.resultDataListChange(titleList);
                        },
                        onTapAddNew: () {
                          if (otherCubit.boxSize == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                dSnackBarShowResult(
                                    title: 'يجب تحديد مقاس الصندوق أولاً .'));
                          } else if (otherCubit.sliceType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                dSnackBarShowResult(
                                    title: 'يجب تحديد نوع الشريحة أولاً .'));
                          } else {
                            ShutterData s = ShutterData(
                                width: componentCubit.width,
                                height: componentCubit.height,
                                sliceSize: otherCubit
                                    .sliceTypeList[otherCubit.sliceType]!,
                                boxSize: otherCubit.boxSize!,
                                length: componentCubit.length,
                                sliceType: otherCubit.sliceType!);

                            otherCubit.addItemToShutterList(s);
                          }
                        },
                        appBarTitle: 'الشيش حصيرة',
                      ),
                    ));
              });
        });
  }
}
