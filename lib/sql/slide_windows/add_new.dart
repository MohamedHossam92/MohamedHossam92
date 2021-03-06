import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/state.dart';
import 'package:the_smart_workshop/sql/slide_windows/data.dart';

import '../home.dart';
import 'const.dart';
import 'cubit/cubit.dart';

final List<GlobalKey<FormState>> addNewFormKey =
    List.generate(16, (i) => GlobalKey<FormState>(), growable: false);

final trackKey = GlobalKey<FormState>();
final beadKey = GlobalKey<FormState>();

final List<GlobalKey<FormState>> weightFormKey =
    List.generate(10, (i) => GlobalKey<FormState>(), growable: false);

class AddNewSlideDeduct extends StatelessWidget {
  final bool isPVC, isEdit;

  const AddNewSlideDeduct(this.isPVC, this.isEdit);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<SQLSlideCubit, SQLSlideState>(
        listener: (context, state) {},
        builder: (context, state) {
          SQLSlideCubit cubit = BlocProvider.of(context);
          return Scaffold(
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
                                  '${isEdit ? '??????????' : '??????????'} ??????????')),
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
                                  Center(child: BTextB5('?????? ????????????     ')))),
                      Flexible(
                        child: DTextField(
                            child: Form(
                          key: addNewFormKey[0],
                          child: TextFormField(
                            controller: !isEdit ? null : addController[0],
                            validator: (val) {
                              if (val!.isEmpty) return '?????? ?????????? ????????';
                            },
                            decoration: InputDecoration(),
                            onChanged: (val) {
                              cubit.otherOnChange(3, val);
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
                          BTextB5('??????????'),
                          BTextB4('?????????? ?????????? ?????????????? ???????????????????? ??????')
                        ],
                      ))),
                  Card(
                    color: Colors.red.shade200,
                    child: DPadding(
                      child: BTextB4(
                          '?????????? ?????? \n ?????? ?????? ?????????????? ?????????????? ???? ?????????? (-) ?????? ?????????????? \n ???? ?????? ???????? ?????? ?????????? ?????????????????? ?????????? ?????????? ??????????'),
                    ),
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        SizedBox(),
                        Card(
                            color: Colors.white12,
                            child: DPadding(
                                child: Center(child: BTextB5('??????????')))),
                        Card(
                            color: Colors.white12,
                            child: DPadding(
                                child: Center(child: BTextB5('??????????')))),
                      ]),
                    ],
                  ),
                  Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List.generate(
                        5,
                        (i) => TableRow(children: [
                          Card(
                              color: Colors.white12,
                              child: Center(
                                  child: DPadding(
                                      val: i == 1 || i == 2 ? 0 : .02,
                                      child: BTextB5(columnTitle[i])))),
                          Form(
                            key: addNewFormKey[1 + i],
                            child: DTextField(
                                child: TextFormField(
                              controller: !isEdit ? null : addController[i + 1],
                              validator: (val) {
                                if (val!.isEmpty) return '?????? ?????????? ????????';
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(suffixText: '????'),
                              onChanged: (val) {
                                cubit.sashOnChange(i, val);
                              },
                            )),
                          ),
                          Form(
                            key: addNewFormKey[6 + i],
                            child: DTextField(
                                child: TextFormField(
                              controller: !isEdit ? null : addController[6 + i],
                              validator: (val) {
                                if (val!.isEmpty) return '?????? ?????????? ????????';
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(suffixText: '????'),
                              onChanged: (val) {
                                cubit.flyScreenOnChange(i, val);
                              },
                            )),
                          ),
                        ]),
                      )),
                  Container(
                      width: double.infinity,
                      child: Card(
                          color: Colors.black12,
                          child: DPadding(
                              child: Center(child: BTextB5('????????????????'))))),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(
                      otherColumnTitle.length,
                      (i) => TableRow(children: [
                        Card(
                            color: Colors.white12,
                            child: Center(
                                child: DPadding(
                                    child: BTextB5(otherColumnTitle[i])))),
                        Form(
                          key: addNewFormKey[11 + i],
                          child: DTextField(
                              child: TextFormField(
                            controller: !isEdit ? null : addController[11 + i],
                            validator: (val) {
                              if (val!.isEmpty) return '?????? ?????????? ????????';
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(suffixText: '????'),
                            onChanged: (val) {
                              cubit.otherOnChange(i, val);
                            },
                          )),
                        ),
                      ]),
                    ),
                  ),
                  Card(
                      color: Colors.black12,
                      child: DPadding(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BTextB5('??????????????'),
                          BTextB4('?????????? ???????????? ???????? ???? ???????? ????????????')
                        ],
                      ))),
                  Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List.generate(
                        glassColumnTitle.length,
                        (i) => TableRow(children: [
                          Card(
                              color: Colors.white12,
                              child: Center(
                                  child: DPadding(
                                      child: BTextB5(glassColumnTitle[i])))),
                          Form(
                            key: addNewFormKey[13 + i],
                            child: DTextField(
                                child: TextFormField(
                              controller:
                                  !isEdit ? null : addController[13 + i],
                              validator: (val) {
                                if (val!.isEmpty) return '?????? ?????????? ????????';
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(suffixText: '????'),
                              onChanged: (val) {
                                cubit.glassOnChange(i, val);
                              },
                            )),
                          ),
                        ]),
                      )),
                  Card(
                      color: Colors.black12,
                      child: DPadding(
                          child: Center(
                              child: BTextB5('?????????? ?????? ???????????? (??????????)')))),
                  Row(
                    children: [
                      Card(
                          color: Colors.white12,
                          child: DPadding(
                              child: Center(
                                  child: BTextB5('?????????? ?????? ????????????     ')))),
                      Form(
                        key: addNewFormKey[15],
                        child: Flexible(
                          child: DTextField(
                              child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: !isEdit ? null : addController[25],
                            validator: (val) {
                              if (val!.isEmpty) return '?????? ?????????? ????????';
                            },
                            decoration: InputDecoration(suffixText: '????'),
                            onChanged: (val) {
                              cubit.otherOnChange(2, val);
                            },
                          )),
                        ),
                      ),
                    ],
                  ),
                  if (!isPVC)
                    Row(
                      children: [
                        Card(
                            color: Colors.white12,
                            child: DPadding(
                                child: Center(
                                    child: BTextB5('?????????? ??????????????     ')))),
                        Form(
                          key: beadKey,
                          child: Flexible(
                            child: DTextField(
                                child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: !isEdit ? null : addController[26],
                              validator: (val) {
                                if (val!.isEmpty) return '?????? ?????????? ????????';
                              },
                              decoration: InputDecoration(suffixText: '????'),
                              onChanged: (val) {
                                cubit.otherOnChange(5, val);
                              },
                            )),
                          ),
                        ),
                      ],
                    ),
                  if (isPVC)
                    Card(
                        color: Colors.black12,
                        child: DPadding(
                            child: Center(child: BTextB5('?????????? ????????????')))),
                  if (isPVC)
                    Row(
                      children: [
                        Card(
                            color: Colors.white12,
                            child: DPadding(
                                child: Center(child: BTextB5('?????????? ????????????')))),
                        Form(
                          key: trackKey,
                          child: Flexible(
                            child: DTextField(
                                child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: !isEdit ? null : addController[27],
                              validator: (val) {
                                if (val!.isEmpty) return '?????? ?????????? ????????';
                              },
                              decoration: InputDecoration(suffixText: '????'),
                              onChanged: (val) {
                                cubit.otherOnChange(4, val);
                              },
                            )),
                          ),
                        ),
                      ],
                    ),
                  if (!isPVC)
                    Card(
                        color: Colors.black12,
                        child: DPadding(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BTextB5('??????????????'),
                            BTextB4(' ?????????? ???????? ????????????')
                          ],
                        ))),
                  if (!isPVC)
                    Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: List.generate(WeightColumnTitle.length, (i) {
                          return TableRow(children: [
                            Card(
                                color: Colors.white12,
                                child: Center(
                                    child: DPadding(
                                        child: BTextB5(WeightColumnTitle[i])))),
                            Form(
                              key: weightFormKey[i],
                              child: DTextField(
                                  child: TextFormField(
                                controller:
                                    !isEdit ? null : addController[15 + i],
                                validator: (val) {
                                  if (val!.isEmpty) return '?????? ?????????? ????????';
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(suffixText: '??????'),
                                onChanged: (val) {
                                  cubit.weightOnChange(i, val);
                                },
                              )),
                            ),
                          ]);
                        })),
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

                if (!isPVC) {
                  weightFormKey.forEach((e) {
                    if (e.currentState!.validate()) cubit.validateInc();
                  });
                }
                if (isPVC
                    ? cubit.validate == 16 && trackKey.currentState!.validate()
                    : cubit.validate == 26) {
                  SlideDeduct slideDeduct = SlideDeduct({
                    cSId: isEdit ? cubit.id : null,
                    cSCountry: 'egypt',
                    cSWindowsSystem: isEdit
                        ? cubit.windowsSystem
                        : (isPVC ? qPVC : qMySystem),
                    cSWindowsProfile: cubit.windowsProfile,
                    cSWidthSashDeduct2: cubit.widthSashDeduct2!,
                    cSWidthSashDeduct4: cubit.widthSashDeduct4!,
                    cSWidthSashDeduct32: cubit.widthSashDeduct32!,
                    cSWidthSashDeduct33: cubit.widthSashDeduct33!,
                    cSWidthFlyScreenDeduct2: cubit.widthFlyScreenDeduct2!,
                    cSWidthFlyScreenDeduct4: cubit.widthFlyScreenDeduct4!,
                    cSWidthFlyScreenDeduct32: cubit.widthFlyScreenDeduct32!,
                    cSWidthFlyScreenDeduct33: cubit.widthFlyScreenDeduct33!,
                    cSHeightSashDeduct: cubit.heightSashDeduct!,
                    cSHeightFluScreenDeduct: cubit.heightFluScreenDeduct!,
                    cSHeightHookDeduct: cubit.heightHookDeduct!,
                    cSHeightAdjoiningDeduct: cubit.heightAdjoiningDeduct!,
                    cSWidthGlassDeduct: cubit.widthGlassDeduct!,
                    cSHeightGlassDeduct: cubit.heightGlassDeduct!,
                    cSFrameFixSize: isPVC ? 0.0 : cubit.frameFixSize!,
                    cSBeadSize: isPVC ? 0.0 : cubit.beadSize!,
                    cSWeightFrame: isPVC ? 0.0 : cubit.weightFrame!,
                    cSWeightFrameWithoutBar:
                        isPVC ? 0.0 : cubit.weightFrameWithoutBar!,
                    cSWeightSash: isPVC ? 0.0 : cubit.weightSash!,
                    cSWeightFlyScreen: isPVC ? 0.0 : cubit.weightFlyScreen!,
                    cSWeightHook: isPVC ? 0.0 : cubit.weightHook!,
                    cSWeightAdjoining: isPVC ? 0.0 : cubit.weightAdjoining!,
                    cSWeightFix: isPVC ? 0.0 : cubit.weightFix!,
                    cSWeightT: isPVC ? 0.0 : cubit.weightT!,
                    cSWeightBead: isPVC ? 0.0 : cubit.weightBead!,
                    cSWeightBar: isPVC ? 0.0 : cubit.weightBar!,
                    cSWeightCollect: isPVC ? 0.0 : (cubit.weightBead! / 2),
                    cSTrackDeduct: isPVC ? cubit.deductTrack : 0.0
                  });
                  isEdit
                      ? cubit.updateData(slideDeduct)
                      : cubit.insertDataToDb(slideDeduct);
                  ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
                      title:
                          '?????? ${isEdit ? '??????????' : '??????????'} ???????? ${cubit.windowsProfile} ?????????? . '));

                  isEdit
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SlideDeductSetting()))
                      : Navigator.pop(context);
                } else
                  ScaffoldMessenger.of(context).showSnackBar(
                      dSnackBarShowResult(title: '???????? ???????? ??????????'));
              },
              label: Row(
                children: [
                  Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                  ),
                  DPadding(
                      child: isEdit
                          ? WTextB5('?????? ?????????? ??????????????')
                          : WTextB5('?????????? ?????????? ????????'))
                ],
              ),
              backgroundColor: cLogoColorW,
            ),
          );
        });
  }
}

const List<String> columnTitle = [
  '2 ????????',
  '3 ???????? / \n 3??????',
  '3 ???????? / \n 2??????',
  '4 ????????',
  '????????????????'
];
const List<String> glassColumnTitle = ['??????????', '????????????????'];
const List<String> otherColumnTitle = ['??????????????', '??????????????'];

const List<String> WeightColumnTitle = [
  '?????????? ????????',
  '?????? ???????? ??????',
  '????????????',
  '???????? ??????????',
  '??????????????',
  '??????????????',
  '?????? ????????',
  '????????????',
  '??????????????',
  '??????????',
];
