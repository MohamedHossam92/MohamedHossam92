import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/drawer/corner_drawer.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/state.dart';

class CornerDetails extends StatelessWidget {
  final bool isWood;

  const CornerDetails([this.isWood = false]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit =
              BlocProvider.of<ComponentCubit>(context);
          return BlocConsumer<KitchenCubit, KitchenState>(
              listener: (context, state) {},
              builder: (context, state) {
                KitchenCubit kitchenCubit = BlocProvider.of(context);

                return BlocConsumer<WoodCubit, WoodState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      WoodCubit woodCubit = BlocProvider.of(context);

                      return WillPopScope(
                          onWillPop: () async {
                            componentCubit.pageIndexChange(0);
                            return true;
                          },
                          child: SafeArea(
                            child: Scaffold(
                              body: AppBackGround(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    PageView.builder(
                                        itemCount: isWood
                                            ? woodCubit.cornerList.length
                                            : kitchenCubit.cornerUnits.length,
                                        scrollDirection: Axis.vertical,
                                        onPageChanged: (s) {
                                          componentCubit.pageIndexChange(s);
                                        },
                                        itemBuilder: (context, i) {
                                          return Column(
                                            children: [
                                              DPadding(
                                                val: .028,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Card(
                                                      color: Colors.black54,
                                                      child: DPadding(
                                                          child: WTextB8(
                                                              'تقرير الركن'))),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              isWood
                                                  ? CornerDrawer(
                                                      backLeft: woodCubit
                                                          .cornerList[i].width,
                                                      backRight: woodCubit
                                                          .cornerList[i].height,
                                                      deepLeft: woodCubit
                                                          .cornerList[i]
                                                          .deepLeft,
                                                      deepRight: woodCubit
                                                          .cornerList[i]
                                                          .deepRight,
                                                      height: woodCubit
                                                          .cornerList[i]
                                                          .cornerHeight,
                                                      backAngle: woodCubit
                                                          .cornerList[i]
                                                          .backAngle,
                                                      cuttingFrontLeftAngle:
                                                          woodCubit
                                                              .cornerList[i]
                                                              .cuttingFrontLeftAngle()
                                                              .toStringAsFixed(
                                                                  1),
                                                      cuttingFrontRightAngle:
                                                          woodCubit
                                                              .cornerList[i]
                                                              .cuttingFrontRightAngle()
                                                              .toStringAsFixed(
                                                                  1),
                                                      cuttingBackAngle: woodCubit
                                                          .cornerList[i]
                                                          .cuttingBackAngle()
                                                          .toStringAsFixed(1),
                                                      frontSide: woodCubit
                                                          .cornerList[i]
                                                          .frontSide()
                                                          .toStringAsFixed(1),
                                                      is90: woodCubit
                                                          .cornerList[i].is90,
                                                      isWood: isWood,
                                                      columnLeft: 20,
                                                      columnRight: 40,
                                                      isWithColumn: true,
                                                    )
                                                  : CornerDrawer(
                                                      backLeft: kitchenCubit
                                                          .cornerUnits[i].width,
                                                      backRight: kitchenCubit
                                                          .cornerUnits[i]
                                                          .height,
                                                      deepLeft: kitchenCubit
                                                          .cornerUnits[i]
                                                          .deepLeft,
                                                      deepRight: kitchenCubit
                                                          .cornerUnits[i]
                                                          .deepRight,
                                                      height: kitchenCubit
                                                          .cornerUnits[i]
                                                          .cornerHeight,
                                                      backAngle: kitchenCubit
                                                          .cornerUnits[i]
                                                          .backAngle,
                                                      cuttingFrontLeftAngle:
                                                          kitchenCubit
                                                              .cornerUnits[i]
                                                              .cuttingFrontLeftAngle()
                                                              .toStringAsFixed(
                                                                  1),
                                                      cuttingFrontRightAngle:
                                                          kitchenCubit
                                                              .cornerUnits[i]
                                                              .cuttingFrontRightAngle()
                                                              .toStringAsFixed(
                                                                  1),
                                                      cuttingBackAngle:
                                                          kitchenCubit
                                                              .cornerUnits[i]
                                                              .cuttingBackAngle()
                                                              .toStringAsFixed(
                                                                  1),
                                                      frontSide: kitchenCubit
                                                          .cornerUnits[i]
                                                          .frontSide()
                                                          .toStringAsFixed(1),
                                                      is90: kitchenCubit
                                                          .cornerUnits[i].is90,
                                                      columnLeft: 20,
                                                      columnRight: 40,
                                                      isWithColumn: true,
                                                    ),
                                              if (!isWood)
                                                Column(
                                                  children: [
                                                    Card(
                                                      color: Colors.black12,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              DPadding(
                                                                child: Icon(
                                                                  Icons
                                                                      .notifications_active,
                                                                  color: Colors
                                                                      .red
                                                                      .shade900,
                                                                ),
                                                              ),
                                                              BTextB5(
                                                                  'تعليمات هامة جداً يجب قراءتها'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'في الأعلي رسم الركنة موضحاً عليها الزوايا والأضلاع.'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'وش الركنة والعمق ستقطعهم من خلال الرسم.'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'الارتفاعات تقريرها موجود ضمن تقارير المطبخ.'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'الظهر (ضلع أ - ج) له حالتين :-'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'الحالة الأولي أن زاوية الحائط ستكون قائمة\n  وهنا ستجد تقرير قصهم مع تقارير القص المطبخ.'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'الحالة الثانية أن زاوية الحائط مفتوحة أو مقفولة\n  وهنا خرجهم بنفسك من الرسم في الأعلي.'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        DPadding(
                                                          child: Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color: Colors
                                                                .red.shade900,
                                                          ),
                                                        ),
                                                        BTextB4(
                                                            'احسب الرف بنفسك علماً بأنه محسوب مع الخامات.'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          );
                                        }),
                                    Card(
                                      color: Colors.black54,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CallUs()));
                                              },
                                              child: Row(
                                                children: [
                                                  DPadding(
                                                    child: Icon(
                                                      Icons
                                                          .notifications_active,
                                                      color: Colors.yellow,
                                                    ),
                                                  ),
                                                  WTextB4(
                                                      'ابلغنا عن خطأ أو مشكلة'),
                                                ],
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  DPadding(
                                                    child: Icon(
                                                      Icons.exit_to_app,
                                                      color: Colors.yellow,
                                                    ),
                                                  ),
                                                  WTextB4('خروج'),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: size.height * .09,
                                        left: size.width * .02,
                                        child: Card(
                                          color: cLogoColorW,
                                          child: SPadding(
                                            h: .03,
                                            v: 0,
                                            child: WTextB4(
                                                '${componentCubit.pageIndex + 1} / ${kitchenCubit.cornerUnits.length}'),
                                          ),
                                        )),
                                    Positioned(
                                        top: size.height * .01,
                                        left: size.width * .02,
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                          width: size.width * .15,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ));
                    });
              });
        });
  }
}
