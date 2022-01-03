import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:the_smart_workshop/screens/deducts/z_other/model/fly_screen_data.dart';

class FlyScreen extends StatelessWidget {
  const FlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);
          return BlocConsumer<OtherDeductCubit, OtherDeductState>(
              listener: (context, state) {},
              builder: (context, state) {
                OtherDeductCubit otherCubit = BlocProvider.of(context);
                Size size = MediaQuery.of(context).size;

                List<ResultData> resultCollectData = [
                  ResultData('التجميع', otherCubit.flyScreenCollectList),
                ];

                List<ResultData> resultCuttingData = [
                  ResultData('تقطيع الإطار', otherCubit.flyScreenFrame),
                  ResultData('تقطيع الدرفة', otherCubit.flyScreenSash),
                ];

                List<ResultData> flyScreenData = [
                  ResultData('تقطيع السلك', otherCubit.flyScreenFly),
                ];

                List<ResultData> materialData = [
                  ResultData('الخامات', otherCubit.AlList()),
                ];

                List<ResultData> titleList = [
                  ResultData('تقرير التجميع', resultCollectData),
                  ResultData('تقرير التقطيع ', resultCuttingData, true),
                  ResultData('تقرير  تقطيع السلك', flyScreenData),
                  ResultData('تقرير الخامات', materialData, true),
                ];

                return DOnWillPop(
                  toExit: () {
                    otherCubit.clearList(true);
                    Navigator.of(context).pop(true);
                  },
                  child: Scaffold(
                      body: DeductHome(
                    appBarTitle: 'السلك البيليسة',
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
                                    children: otherCubit
                                            .flyScreenList.isNotEmpty
                                        ? List.generate(
                                            otherCubit.flyScreenList.length,
                                            (i) => Stack(
                                              alignment: Alignment.topLeft,
                                              children: [
                                                DPadding(
                                                  val: .008,
                                                  child: Container(
                                                    height: size.height * .4,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(0, 1),
                                                              spreadRadius: 0)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: DPadding(
                                                      val: .008,
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              DPadding(
                                                                child: Image.asset(
                                                                    'assets/images/other/fly_screen.jpg',
                                                                    width: size
                                                                            .width *
                                                                        .28),
                                                              ),
                                                              BTextB4(
                                                                  '${otherCubit.flyScreenList[i].width} * ${otherCubit.flyScreenList[i].height} '),
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
                                                              .flyScreenList,
                                                          i);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
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
                        Card(
                          color: Colors.white70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (otherCubit.flyScreenList.isEmpty)
                                DPadding(child: BTextB4('تحديد نوع القطاع')),
                              SizedBox(
                                width: 15,
                              ),
                              otherCubit.flyScreenList.isEmpty
                                  ? DropdownButton(
                                      hint: BTextB5('تحديد نوع القطاع'),
                                      value: otherCubit.flyType,
                                      onChanged: (val) {
                                        otherCubit.flyTypeChange(val);
                                      },
                                      items: otherCubit.flyTypeList
                                          .map((e) => DropdownMenuItem(
                                                child: BTextB5(e),
                                                value: e,
                                              ))
                                          .toList())
                                  : DPadding(
                                      child: BTextB5('${otherCubit.flyType}')),
                              if (otherCubit.flyScreenList.isNotEmpty)
                                MaterialButton(
                                    color: Colors.red.shade200,
                                    child: BTextB4('تغيير القطاع'),
                                    onPressed: () {
                                      otherCubit.clearList();
                                    })
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                height: size.height * .35,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        color: Colors.black54,
                                        child: DPadding(
                                            child: WTextB4('اتجاه الفتح')),
                                      ),
                                      SPadding(
                                        v: .01,
                                        h: 0,
                                        child: Container(
                                          width: size.width * .24,
                                          height: size.height * .04,
                                          decoration: BoxDecoration(
                                              color: !otherCubit.isFlyUp
                                                  ? Colors.green
                                                  : Colors.grey.shade300,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      size.width * .015),
                                                  topLeft: Radius.circular(
                                                      size.width * .015))),
                                          child: Center(
                                            child: MaterialButton(
                                              child: !otherCubit.isFlyUp
                                                  ? WTextB5('أفقي')
                                                  : RTextB5('أفقي'),
                                              onPressed: () {
                                                otherCubit.isFlyUpChange(false);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SPadding(
                                        v: .01,
                                        h: 0,
                                        child: Container(
                                          width: size.width * .24,
                                          height: size.height * .04,
                                          decoration: BoxDecoration(
                                              color: otherCubit.isFlyUp
                                                  ? Colors.green
                                                  : Colors.grey.shade300,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      size.width * .015),
                                                  topLeft: Radius.circular(
                                                      size.width * .015))),
                                          child: Center(
                                            child: MaterialButton(
                                              child: otherCubit.isFlyUp
                                                  ? WTextB5('رأسي')
                                                  : RTextB5('رأسي'),
                                              onPressed: () {
                                                otherCubit.isFlyUpChange(true);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              Image.asset(
                                'assets/images/other/fly_screen.jpg',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        AddSize()
                      ],
                    ),
                    showResultBody: otherCubit.flyScreenList.isNotEmpty
                        ? ResultHome()
                        : ListIsEmpty(),
                    detailsEdit: Card(
                      color: Colors.black,
                      child: Card(
                        color: Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BTextB5('عدد الدرف'),
                            GestureDetector(
                              onTap: () {
                                otherCubit.flyDirectionChange(0);
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: 0,
                                      groupValue: otherCubit.flySashLength,
                                      onChanged: (val) {
                                        otherCubit.flyDirectionChange(val);
                                      }),
                                  BTextB5('درفة')
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                otherCubit.flyDirectionChange(1);
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: otherCubit.flySashLength,
                                      onChanged: (val) {
                                        otherCubit.flyDirectionChange(val);
                                      }),
                                  BTextB5('درفتين'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    showResultAction: () {
                      otherCubit.addFlyScreenDataToLists();
                      componentCubit.resultDataListChange(titleList);
                    },
                    onTapAddNew: () {
                      if (otherCubit.flyType == null)
                        ScaffoldMessenger.of(context).showSnackBar(
                            dSnackBarShowResult(
                                title: 'يجب تحديد نوع القطاع أولاً .'));
                      else
                        for (var data in flyScreenList) {
                          if (data.flyType == otherCubit.flyType) {
                            if (formKey.currentState!.validate() &&
                                otherCubit.flyType != null) {
                              FlyScreenData f = FlyScreenData(
                                  flyType: otherCubit.flyType.toString(),
                                  width: componentCubit.width,
                                  height: componentCubit.height,
                                  length: componentCubit.length,
                                  sashLength: otherCubit.sashLength,
                                  deductWidth: data.deductWidth,
                                  deductHeight: data.deductHeight,
                                  deductSash: data.deductSash,
                                  deductFlyScreen: data.deductFlyScreen,
                                  isUp: otherCubit.isFlyUp);
                              otherCubit.addItemToFlyScreen(f);
                            }
                          }
                        }
                    },
                  )),
                );
              });
        });
  }
}
