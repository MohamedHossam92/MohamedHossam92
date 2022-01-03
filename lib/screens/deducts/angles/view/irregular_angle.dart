import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/drawer/irregulae_drawer.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/irregular_angle_data.dart';

class IrregularAngle extends StatelessWidget {
  static String id = 'IrregularAngle';
  IrregularAngle({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<CornerCubit, CornerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CornerCubit irregularCubit = BlocProvider.of(context);

          return WillPopScope(
            onWillPop: () async {
              irregularCubit.clearLists();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('زاوية الشطرات'),
              ),
              body: AppBackGround(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //     width: double.infinity,
                      //     height: size.height * .35,
                      //     decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //                 'assets/images/windows/angle.jpg'),
                      //             fit: BoxFit.cover)),
                      //     child: Stack(children: [
                      //       Positioned(
                      //           bottom: size.height * .15,
                      //           left: size.width * .82,
                      //           child: WTextB5('${irregularCubit.rightSide}')),
                      //       Positioned(
                      //           bottom: size.height * .15,
                      //           left: size.width * .13,
                      //           child: WTextB5('${irregularCubit.leftSide}')),
                      //       Positioned(
                      //           bottom: size.height * .03,
                      //           left: size.width * .5,
                      //           child: WTextB5('${irregularCubit.bottomSide}')),
                      //       if (irregularCubit.irregularAngleList.isNotEmpty)
                      //         Stack(
                      //           children: [
                      //             Positioned(
                      //                 bottom: size.height * .29,
                      //                 left: size.width * .45,
                      //                 child: YTextB5(
                      //                     '${irregularCubit.irregularAngleList[0].topSide().toStringAsFixed(1)}')),
                      //             Positioned(
                      //                 bottom: size.height * .25,
                      //                 left: size.width * .66,
                      //                 child: YTextB5(
                      //                     '${irregularCubit.irregularAngleList[0].cutRightAngle().toStringAsFixed(1)}')),
                      //             Positioned(
                      //                 bottom: size.height * .19,
                      //                 left: size.width * .3,
                      //                 child: YTextB5(
                      //                     '${irregularCubit.irregularAngleList[0].cutLeftAngle().toStringAsFixed(1)}')),
                      //           ],
                      //         ),
                      //     ])),
                      IrregularDrawer(
                        rightSide: irregularCubit.rightSide,
                        leftSide: irregularCubit.leftSide,
                        bottomSide: irregularCubit.bottomSide,
                        list: irregularCubit.irregularAngleList,
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      Column(
                        children: [
                          if (!irregularCubit.showResult)
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Wrap(
                                      alignment: WrapAlignment.center,
                                      children: List.generate(3, (i) {
                                        List<String> data = [
                                          'الضلع أ',
                                          ' الضلع ب',
                                          ' الضلع جـ',
                                        ];
                                        return SizedBox(
                                          height: size.height * .07,
                                          width: size.width * .48,
                                          child: DPadding(
                                            child: TextFormField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: InputDecoration(
                                                  suffix: Text('سم'),
                                                  labelText: data[i],
                                                ),
                                                onChanged: (String? val) {
                                                  irregularCubit
                                                      .irregularAngleChange(
                                                          i, val, context);
                                                },
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return 'أدخل قيمة';
                                                  }
                                                }),
                                          ),
                                        );
                                      })),
                                ],
                              ),
                            ),
                          MaterialButton(
                              child: WTextB4(
                                  '${irregularCubit.showResult ? 'عملية جديدة' : 'أظهر النتائج'}'),
                              color: cLogoColorW,
                              onPressed: () {
                                if (!irregularCubit.showResult &&
                                    _formKey.currentState!.validate()) {
                                  IrregularAngleData i = IrregularAngleData(
                                      irregularCubit.leftSide,
                                      irregularCubit.rightSide,
                                      irregularCubit.bottomSide,
                                      irregularCubit.barSize);

                                  irregularCubit.addNewIrregularAngle(i);
                                  irregularCubit.showResultChanged();
                                  _formKey.currentState!.reset();
                                } else {
                                  irregularCubit.clearLists();
                                }
                                PrayPlay.playPray();
                              }),
                          MaterialButton(
                              child: WTextB4('خروج'),
                              color: Colors.black,
                              onPressed: () {
                                irregularCubit.clearLists();
                                Navigator.pop(context);
                                PrayPlay.playPray();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
