import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/button.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class WoodUnitDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<KitchenSettingCubit, KitchenSettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          KitchenSettingCubit kitchenSettingState = BlocProvider.of(context);
          return SafeArea(
              child: Scaffold(
                  body: SingleChildScrollView(
                      child: Container(
                          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * .26,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: size.width * .18,
                      child: Container(
                          height: size.height * .26,
                          child: Image.asset(
                              'assets/images/kitchen_unit/wood00${kitchenSettingState.isWoodUp ? 1 : 2}.png')),
                    ),
                    Positioned(
                        bottom: size.height * .1,
                        left: size.width * .12,
                        child: Card(
                          child: DPadding(
                            child: Text(
                                '${kitchenSettingState.isWoodUp ? 'التجميع رأسي من أعلي' : 'التجميع أفقي من الجنب'}'),
                          ),
                        )),
                  ],
                ),
              ),
              Divider(
                thickness: 5,
              ),
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.white70,
                  child: Column(children: [
                    DPadding(
                      child: BTextB5('طريقة تجميع الوحدات'),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: kitchenSettingState.isWoodUp
                              ? WTextB4('   رأسي من أعلي  ')
                              : BTextB4('   رأسي من أعلي  '),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          selectedColor: Colors.green,
                          onSelected: (val) {
                            kitchenSettingState.isWoodUpChanged(val);
                          },
                          selected: kitchenSettingState.isWoodUp,
                        ),
                        ChoiceChip(
                          label: kitchenSettingState.isWoodDown
                              ? WTextB4('   أفقي من الجنب  ')
                              : BTextB4('   أفقي من الجنب  '),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          selectedColor: Colors.green,
                          onSelected: (val) {
                            kitchenSettingState.isWoodUpChanged(val);
                          },
                          selected: kitchenSettingState.isWoodDown,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Column(
                children: List.generate(4, (i) {
                  List<String> title = [
                    'إرتفاع الأدراج   ${kitchenSettingState.heightDrawerBody.toStringAsFixed(0)}  سم',
                    'تخانة الألواح   ${kitchenSettingState.woodThickness.toStringAsFixed(0)}  مم',
                    'بُعد عمل مفحار الظهرية ${kitchenSettingState.rackDeduct.toStringAsFixed(0)} مم من الخلف ',
                    'تخصيم الدرف - ${kitchenSettingState.woodDeductShutter.toStringAsFixed(0)} مم من الخارج ',
                  ];
                  List<double> val = [
                    kitchenSettingState.heightDrawerBody,
                    kitchenSettingState.woodThickness,
                    kitchenSettingState.rackDeduct,
                    kitchenSettingState.woodDeductShutter,
                  ];
                  return Container(
                    width: double.infinity,
                    child: Card(
                        color: Colors.white70,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (i == 0)
                                Image.asset(
                                    'assets/images/kitchen_unit/wood_drawer.png'),
                              Column(
                                children: [
                                  DPadding(
                                    child: BTextB5(title[i]),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: size.width * .5,
                                        child: Slider(
                                            activeColor: Colors.black,
                                            inactiveColor: Colors.black12,
                                            min: 0,
                                            max: 25,
                                            value: val[i],
                                            onChanged: (val) {
                                              kitchenSettingState
                                                  .woodDetailsChange(
                                                      i, val.roundToDouble());
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ])),
                  );
                }),
              ),
              SaveAndCloseButton()
            ],
          )))));
        });
  }
}
