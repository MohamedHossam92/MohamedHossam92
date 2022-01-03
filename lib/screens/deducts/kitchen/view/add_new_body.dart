import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/list_is_empty.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/text_form.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/cupboard_unit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/lower_unit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/unit_card.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/upper_unit.dart';

import 'units_style/corner_unit.dart';

class AddNewKitchen extends StatelessWidget {
  final List list;
  final bool isWood;

  AddNewKitchen(
    this.list,
    this.isWood,
  );
  final List<UnitStyle> buttonList = [
    UnitStyle(0, 'سفلي', LowerUnit()),
    UnitStyle(1, 'علوي', UpperUnit()),
    UnitStyle(2, 'دولاب', CupboardUnit()),
    UnitStyle(3, 'ركنة', CornerUnit()),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddKitchenCubit, AddKitchenState>(
        listener: (context, state) {},
        builder: (context, state) {
          AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;

          return BlocConsumer<WoodCubit, WoodState>(
              listener: (context, state) {},
              builder: (context, state) {
                WoodCubit woodCubit = BlocProvider.of(context);
                return BlocConsumer<ComponentCubit, ComponentState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      ComponentCubit componentCubit = BlocProvider.of(context);
                      return BlocConsumer<KitchenCubit, KitchenState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            KitchenCubit kitchenCubit =
                                BlocProvider.of(context);

                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
//  ============================ list of units ============================================
                                              children: list.isNotEmpty
                                                  ? List.generate(
                                                      list.length,
                                                      (i) => Stack(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        children: [
                                                          DPadding(
                                                            val: .008,
                                                            child: Container(
                                                              height: 130,
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
                                                                            offset: Offset(0,
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
                                                                    DPadding(
                                                                      child:
                                                                          UnitCard1(
                                                                        height:
                                                                            .12,
                                                                        onTap:
                                                                            () {},
                                                                        unitId: list[i]
                                                                            .imageId
                                                                            .toString(),
                                                                        unitName:
                                                                            list[i].unitName,
                                                                      ),
                                                                    ),
                                                                    BTextB4(
                                                                        '${list[i].width} * ${list[i].height} ')
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                isWood
                                                                    ? woodCubit.deleteUnitFromList(
                                                                        list[i]
                                                                            .id)
                                                                    : kitchenCubit
                                                                        .deleteUnitFromList(
                                                                            list[i].id);
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color: Colors
                                                                    .red
                                                                    .shade900,
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
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.white70,
                                            child: DPadding(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  BTextB5(
                                                      '${addKitchenCubit.selectedShutter ?? ''}'),
                                                  BTextB5(
                                                      '${addKitchenCubit.selectedColor ?? ''}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
//  ========================================= units button =========================
                                                    Card(
                                                      color: Colors.black54,
                                                      child: DPadding(
                                                          child:
                                                              WTextB4('وحدات')),
                                                    ),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: List.generate(
                                                            buttonList.length,
                                                            (i) {
                                                          return SPadding(
                                                            v: .01,
                                                            h: 0,
                                                            child: Container(
                                                              width:
                                                                  size.width *
                                                                      .24,
                                                              height:
                                                                  size.height *
                                                                      .04,
                                                              decoration: BoxDecoration(
                                                                  color: buttonList[i]
                                                                              .i ==
                                                                          addKitchenCubit
                                                                              .unitType
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey
                                                                          .shade300,
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(size.width *
                                                                              .015),
                                                                      topLeft: Radius.circular(
                                                                          size.width *
                                                                              .015))),
                                                              child: Center(
                                                                child:
                                                                    MaterialButton(
                                                                  child: buttonList[i]
                                                                              .i ==
                                                                          addKitchenCubit
                                                                              .unitType
                                                                      ? WTextB5(
                                                                          buttonList[i]
                                                                              .title)
                                                                      : RTextB5(
                                                                          buttonList[i]
                                                                              .title),
                                                                  onPressed:
                                                                      () {
                                                                    addKitchenCubit
                                                                        .unitTypeChange(
                                                                            i);
                                                                    showBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                buttonList[i].widget);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        })),
                                                  ],
                                                ),
// =========================================== unit style =====================================
                                                Container(
                                                  width: size.width * .75,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height:
                                                            size.height * .23,
                                                        width: size.width * .55,
                                                        child: addKitchenCubit
                                                                    .unitId !=
                                                                -1
                                                            ? UnitCard(
                                                                height: .2,
                                                                onTap: () {},
                                                                unitName:
                                                                    addKitchenCubit
                                                                        .unitName,
                                                                unitId: addKitchenCubit
                                                                    .imageId
                                                                    .toString(),
                                                              )
                                                            : Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    'من فضلك حدد نوع الوحدة \n من علي اليمين')),
                                                      ),
                                                      //================================================ add new unit ================
                                                      if (!componentCubit
                                                          .isLengthHide)
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            BTextB5(
                                                                'عدد الأرفف'),
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .add_circle,
                                                                  size:
                                                                      size.width *
                                                                          .06,
                                                                ),
                                                                onPressed: () {
                                                                  componentCubit
                                                                      .incrementWindowsList();
                                                                }),
                                                            BTextB5(
                                                                componentCubit
                                                                    .length
                                                                    .toString()),
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .remove_circle,
                                                                  size:
                                                                      size.width *
                                                                          .06,
                                                                ),
                                                                onPressed: () {
                                                                  componentCubit
                                                                      .decrementWindowsList(
                                                                          0);
                                                                }),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          addKitchenCubit.unitType != 3
                                              ? AddSize(isKitchen: true)
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    });
              });
        });
  }
}

class UnitStyle {
  final String title;

  final int i;
  final Widget widget;

  UnitStyle(this.i, this.title, this.widget);
}
