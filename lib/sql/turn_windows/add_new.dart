import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/state.dart';
import 'package:the_smart_workshop/sql/turn_windows/data.dart';

import '../home.dart';
import 'const.dart';
import 'cubit/cubit.dart';

class AddNewTurnDeduct extends StatelessWidget {
  final bool isPVC, isEdit;

  AddNewTurnDeduct(this.isPVC, this.isEdit);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<SQLTurnCubit, SQLTurnState>(
        listener: (context, state) {},
        builder: (context, state) {
          SQLTurnCubit cubit = BlocProvider.of(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      thickness: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DPadding(
                          val: .01,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black54),
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(
                                  'assets/images/logo.png',
                                ))),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.black54,
                            child: DPadding(
                                child: WTextB6(
                                    '${isEdit ? 'تعديل' : 'إضافة'} تخصيم')),
                          ),
                        ),
                        DPadding(
                          val: .01,
                          child: Image.asset(
                            'assets/images/windows/systems/s006.png',
                            width: size.width * .15,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Row(
                      children: [
                        Card(
                            color: Colors.white12,
                            child: DPadding(
                                child:
                                    Center(child: BTextB5('اسم القطاع     ')))),
                        Flexible(
                          child: DTextField(
                              child: Form(
                            key: addNewFormKey[0],
                            child: TextFormField(
                              controller: !isEdit ? null : addController[0],
                              validator: (val) {
                                if (val!.isEmpty) return 'يجب ادخال قيمة';
                              },
                              decoration: InputDecoration(),
                              onChanged: (val) {
                                cubit.sashDeductOnChange(4, val);
                              },
                            ),
                          )),
                        ),
                      ],
                    ),
                    Card(
                        color: Colors.black12,
                        child: DPadding(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BTextB5('التخصيم'),
                            BTextB4('يتم تزويد قيمة التخصيم من الداخل')
                          ],
                        ))),
                    Card(
                      color: Colors.red.shade200,
                      child: DPadding(
                        child: BTextB4(
                            'تنبيه مهم \n إذا كان التخصيم بالناقص ضع علامة (-) قبل التخصيم \n أو ألق نظرة علي تعديل التخصيمات أولاً لتفعل مثلها'),
                      ),
                    ),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List.generate(
                          3,
                          (i) => TableRow(children: [
                                Card(
                                    color: Colors.white12,
                                    child: DPadding(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BTextB5(sashColumnTitle[i]),
                                      ],
                                    ))),
                                Form(
                                  key: addNewFormKey[1 + i],
                                  child: DTextField(
                                    child: TextFormField(
                                      controller:
                                          !isEdit ? null : addController[1 + i],
                                      validator: (val) {
                                        if (val!.isEmpty)
                                          return 'يجب ادخال قيمة';
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration:
                                          InputDecoration(suffixText: 'مم'),
                                      onChanged: (val) {
                                        cubit.sashDeductOnChange(i, val);
                                      },
                                    ),
                                  ),
                                ),
                              ])),
                    ),
                    Card(
                        color: Colors.black12,
                        child: DPadding(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BTextB5(
                                'تخصيم ${isPVC ? 'البوكلير' : 'مرد الدرفة'} '),
                            BTextB4('يتم الخصم من ارتفاع الدرفة')
                          ],
                        ))),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Card(
                              color: Colors.white12,
                              child: DPadding(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BTextB5(
                                      'ارتفاع ${isPVC ? 'البوكلير' : 'مرد الدرفة'}'),
                                ],
                              ))),
                          Form(
                            key: addNewFormKey[4],
                            child: DTextField(
                                child: TextFormField(
                              controller: !isEdit ? null : addController[4],
                              validator: (val) {
                                if (val!.isEmpty) return 'يجب ادخال قيمة';
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(suffixText: 'مم'),
                              onChanged: (val) {
                                cubit.sashDeductOnChange(3, val);
                              },
                            )),
                          ),
                        ])
                      ],
                    ),
                    Card(
                        color: Colors.black12,
                        child: DPadding(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BTextB5('أبعاد القطاع'),
                          ],
                        ))),
                    Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: List.generate(
                            profilesValue(isPVC).length,
                            (i) => TableRow(children: [
                                  Card(
                                      color: Colors.white12,
                                      child: Center(
                                          child: DPadding(
                                              child: BTextB5(
                                                  profilesValue(isPVC)[i])))),
                                  Form(
                                    key: addNewFormKey[5 + i],
                                    child: DTextField(
                                        child: TextFormField(
                                      controller:
                                          !isEdit ? null : addController[5 + i],
                                      validator: (val) {
                                        if (val!.isEmpty)
                                          return 'يجب ادخال قيمة';
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration:
                                          InputDecoration(suffixText: 'مم'),
                                      onChanged: (val) {
                                        cubit.profilesValue(i, val);
                                      },
                                    )),
                                  ),
                                ]))),
                    if (!isPVC)
                      Card(
                          color: Colors.black12,
                          child: DPadding(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BTextB5('الأوزان'),
                              BTextB4(' الوزن يكون بالعود')
                            ],
                          ))),
                    if (!isPVC)
                      Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: List.generate(
                              WeightColumnTitle.length,
                              (i) => TableRow(children: [
                                    Card(
                                        color: Colors.white12,
                                        child: Center(
                                            child: DPadding(
                                                child: BTextB5(
                                                    WeightColumnTitle[i])))),
                                    Form(
                                      key: weightFormKey[i],
                                      child: DTextField(
                                          child: TextFormField(
                                        controller: !isEdit
                                            ? null
                                            : addController[10 + i],
                                        validator: (val) {
                                          if (val!.isEmpty)
                                            return 'يجب ادخال قيمة';
                                        },
                                        keyboardType: TextInputType.phone,
                                        decoration:
                                            InputDecoration(suffixText: 'كجم'),
                                        onChanged: (val) {
                                          cubit.profilesValue(i, val);
                                        },
                                      )),
                                    ),
                                  ]))),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  cubit.validateInc(1);

                  addNewFormKey.forEach((e) {
                    if (e.currentState!.validate()) cubit.validateInc();
                  });
                  if (!isPVC)
                    weightFormKey.forEach((e) {
                      if (e.currentState!.validate()) cubit.validateInc();
                    });
                  if (isPVC ? cubit.validate == 10 : cubit.validate == 17) {
                    TurnDeductData t = TurnDeductData({
                      cTId: isEdit ? cubit.id : null,
                      cTCountry: 'egypt',
                      cTSystemType: isEdit
                          ? cubit.windowsSystem
                          : (isPVC ? qPVC : qMySystem),
                      cTWindowsProfile: cubit.windowsProfile,
                      cTOneSashDeDuct: cubit.oneSashDeDuct,
                      cTTowSashDeDuct: cubit.towSashDeDuct,
                      cTHeightSashDeduct: cubit.heightSashDeduct,
                      cTDeductFrameWithBar: cubit.deductFrameWithBar,
                      cTDeductFrameWithFex: cubit.deductFrameWithFex,
                      cTBead: cubit.bead,
                      cTDeductSmallZ: cubit.deductSmallZ,
                      cTDeductLargeZ: cubit.deductLargeZ,
                      cTDeductTCenter: cubit.deductTCenter,
                      cTWeightFrame: isPVC ? 0.0 : cubit.weightFrame,
                      cTWeightFrameWithFex:
                          isPVC ? 0.0 : cubit.weightFrameWithFex,
                      cTWeightSash: isPVC ? 0.0 : cubit.weightSash,
                      cTWeightPanda: isPVC ? 0.0 : cubit.weightPanda,
                      cTWeightT: isPVC ? 0.0 : cubit.weightT,
                      cTWeightBead: isPVC ? 0.0 : cubit.weightBead,
                      cTWeightBar: isPVC ? 0.0 : cubit.weightBar,
                    });
                    print(t.toMap());
                    isEdit ? cubit.updateData(t) : cubit.insertDataToDb(t);
                    ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
                        title:
                            'تمت ${isEdit ? 'تعديل' : 'إضافة'} قطاع ${cubit.windowsProfile} بنجاح . '));
                    isEdit
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SlideDeductSetting(true, false)))
                        : Navigator.pop(context);
                  } else
                    ScaffoldMessenger.of(context).showSnackBar(
                        dSnackBarShowResult(title: 'يوجد خانة فارغة'));
                },
                label: Row(
                  children: [
                    Icon(
                      Icons.open_in_new,
                      color: Colors.white,
                    ),
                    DPadding(
                        child: isEdit
                            ? WTextB5('حفظ عملية التعديل')
                            : WTextB5('اضافة تخصيم جديد'))
                  ],
                ),
                backgroundColor: cLogoColorW,
              ),
            ),
          );
        });
  }
}

List<GlobalKey<FormState>> addNewFormKey =
    List.generate(10, (i) => GlobalKey<FormState>(), growable: false);
List<GlobalKey<FormState>> weightFormKey = List.generate(
    WeightColumnTitle.length, (i) => GlobalKey<FormState>(),
    growable: false);

const List<String> sashColumnTitle = [
  'العرض 1 درفة',
  'العرض 2 درفة',
  'ارتفاع الدرفة'
];
List<String> profilesValue(bool isPVC) => [
      'حلق ${isPVC ? 'بار 4 سم' : 'ببار'}',
      'حلق بار ${isPVC ? '6 سم' : 'خارجي'}',
      '${isPVC ? 'درفة كبيرة' : 'Z كبير'} ',
      '${isPVC ? 'درفة صغيرة' : 'z صغير'} ',
      'الباكتة'
    ];

const List<String> WeightColumnTitle = [
  'الحلق ببار',
  'حلق بار خارجي',
  'Z كبير',
  ' z صغير',
  'السؤاس',
  'الباكتة',
  'البـار',
];
