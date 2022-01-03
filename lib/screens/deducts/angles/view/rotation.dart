import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/rotation_angle_data.dart';

class RotationAngle extends StatelessWidget {
  static String id = 'RotationAngle';
  RotationAngle({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<CornerCubit, CornerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CornerCubit rotationCubit = BlocProvider.of(context);

          return WillPopScope(
            onWillPop: () async {
              rotationCubit.clearLists();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('زاوية الدورانات'),
              ),
              body: AppBackGround(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: size.height * .35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/windows/radius.jpg'),
                                  fit: BoxFit.cover)),
                          child: Stack(children: [
                            Positioned(
                                bottom: size.height * .145,
                                left: size.width * .63,
                                child:
                                    WTextB5('${rotationCubit.rotationWater}')),
                            Positioned(
                                bottom: size.height * .26,
                                left: size.width * .2,
                                child: WTextB5('${rotationCubit.deep}')),
                          ])),
                      Divider(
                        thickness: 3,
                      ),
                      if (rotationCubit.rotateAngleList.isEmpty)
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Wrap(
                                  alignment: WrapAlignment.center,
                                  children: List.generate(2, (i) {
                                    List<String> data = [
                                      'الوتر',
                                      'العمق',
                                    ];
                                    return SizedBox(
                                      height: size.height * .07,
                                      width: size.width * .48,
                                      child: DPadding(
                                          child: TextFormField(
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                suffix: Text('سم'),
                                                labelText: data[i],
                                              ),
                                              onChanged: (String? val) {
                                                rotationCubit.rotationChange(
                                                    i, val);
                                              },
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'أدخل قيمة';
                                                }
                                              })),
                                    );
                                  })),
                              DPadding(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Checkbox(
                                          value: rotationCubit.isWithBar,
                                          onChanged: (val) {
                                            rotationCubit.withBarChanged(val);
                                          }),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          rotationCubit.withBarChanged(
                                              !rotationCubit.isWithBar);
                                        },
                                        child: BTextB4('إضافة بار')),
                                    Spacer(),
                                    if (rotationCubit.isWithBar)
                                      Row(
                                        children: [
                                          Container(
                                              color: Colors.grey.shade300,
                                              child: DPadding(
                                                  child:
                                                      BTextB4('مقاس البار'))),
                                          DropdownButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: cLogoColorW,
                                            ),
                                            elevation: 5,
                                            iconEnabledColor: cLogoColor,
                                            items: rotationCubit.barSizeList
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    child: BTextB5('$e سم '),
                                                    value: e,
                                                  ),
                                                )
                                                .toList(),
                                            value: rotationCubit.barSize,
                                            onChanged: (val) {
                                              rotationCubit.barSizeChange(val);
                                            },
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      if (rotationCubit.rotateAngleList.isNotEmpty)
                        Container(
                          width: size.width * .9,
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BTextB5('   زاوية القطع      '),
                                    Card(
                                        color: Colors.green.shade900,
                                        child: DPadding(
                                          child: WTextB8(
                                              '${!rotationCubit.isWithBar ? rotationCubit.rotateAngleList[0].cutAngle().toStringAsFixed(1) : rotationCubit.rotateAngleList[0].cutAngleWithBar().toStringAsFixed(1)} ^'),
                                        )),
                                  ]),
                              Divider(
                                thickness: 2,
                              ),
                              Container(
                                  width: double.infinity,
                                  color: Colors.grey.shade200,
                                  child: DPadding(
                                      child: Center(
                                    child:
                                        BTextB5('بيانات خاصة بماكينة الدوران'),
                                  ))),
                              DPadding(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BTextB4('نصف القطر'),
                                      BTextB4('زاوية القوس'),
                                      BTextB4('طول القوس'),
                                    ]),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size.width * .28,
                                      child: Card(
                                          color: Colors.blueGrey.shade900,
                                          child: DPadding(
                                            child: Center(
                                              child: WTextB5(
                                                  '${rotationCubit.rotateAngleList[0].radiusWithBar().toStringAsFixed(1)} سم '),
                                            ),
                                          )),
                                    ),
                                    Container(
                                      width: size.width * .28,
                                      child: Card(
                                          color: Colors.blueGrey.shade900,
                                          child: DPadding(
                                            child: Center(
                                              child: WTextB5(
                                                  '${rotationCubit.rotateAngleList[0].archAngleWithBar().toStringAsFixed(1)} ^'),
                                            ),
                                          )),
                                    ),
                                    Container(
                                      width: size.width * .28,
                                      child: Card(
                                          color: Colors.blueGrey.shade900,
                                          child: DPadding(
                                            child: Center(
                                              child: WTextB5(
                                                  '${rotationCubit.rotateAngleList[0].archSizeWithBar().toStringAsFixed(1)} سم '),
                                            ),
                                          )),
                                    ),
                                  ]),
                              Container(
                                color: Colors.grey.shade300,
                                child: DPadding(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DPadding(
                                            child: Icon(
                                                Icons.notifications_active)),
                                        BTextB4(
                                            'أضف 60 سم علي طول القوس \n قبل الإرسال لماكينة الدوران')
                                      ]),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      MaterialButton(
                          child: WTextB4(
                              '${rotationCubit.showResult ? 'عملية جديدة' : 'أظهر النتائج'}'),
                          color: cLogoColorW,
                          onPressed: () {
                            if (!rotationCubit.showResult &&
                                _formKey.currentState!.validate()) {
                              RotationAngleData r = RotationAngleData(
                                rotationCubit.rotationWater,
                                rotationCubit.deep,
                                rotationCubit.barSize,
                              );
                              rotationCubit.addNewRotateAngle(r);
                              rotationCubit.showResultChanged();
                              _formKey.currentState!.reset();
                            } else {
                              rotationCubit.clearLists();
                            }
                            PrayPlay.playPray();
                          }),
                      MaterialButton(
                          child: WTextB4('خروج'),
                          color: Colors.black,
                          onPressed: () {
                            rotationCubit.clearLists();
                            Navigator.pop(context);
                            PrayPlay.playPray();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
