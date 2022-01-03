import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/button.dart';

import '../../a-component/cubit/cubit.dart';
import '../../a-component/cubit/state.dart';

class windowsEditDetails extends StatelessWidget {
  final bool isSlide, isTilt;

  windowsEditDetails(this.isSlide, [this.isTilt = false]);

  @override
  Widget build(BuildContext context) {
    final List<DetailsData> detailsDataList = [
      DetailsData(
          icons: Icons.layers,
          title: 'عدد الدرف',
          widget: SashLength(isSlide, isTilt)),
      DetailsData(
          icons: Icons.calendar_view_day_sharp,
          title: 'اضافة ثابت',
          widget: Fixed(isTilt)),
      DetailsData(
          icons: Icons.more_horiz,
          title: 'المزيد',
          widget: MoreOptions(isSlide, isTilt)),
    ];
    return Container(
      color: Colors.black,
      child: Row(
          children: detailsDataList
              .map((e) => TextButton(
                    child: Row(
                      children: [
                        DPadding(
                          val: .01,
                          child: Icon(
                            e.icons,
                            color: Colors.yellow,
                          ),
                        ),
                        WTextB5(e.title)
                      ],
                    ),
                    onPressed: () {
                      showBottomSheet(
                          context: context, builder: (context) => e.widget);
                    },
                  ))
              .toList()),
    );
  }
}

class SashLength extends StatelessWidget {
  final bool isSlide, isTilt;
  SashLength(this.isSlide, this.isTilt);
  final List<String> slideSashLength = ['4 درفة', '2 درفة', '3/3سكة', '2/3سكة'];
  final List<String> turnSashLength = ['1 درفة', '2 درفة', '3 درفة', '4 درفة'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);
          print(componentCubit.sashFixedSize);
          return Container(
            height:
                size.height * (componentCubit.isPanda && !isTilt ? .2 : .15),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (i) => MaterialButton(
                          color: isSlide
                              ? (componentCubit.sashLength == i ||
                                      (componentCubit.sashLength == 4 && i == 3)
                                  ? Colors.green
                                  : Colors.grey.shade200)
                              : (componentCubit.sashLength == i + 1
                                  ? Colors.green
                                  : Colors.grey.shade200),
                          onPressed: () {
                            componentCubit.sashLengthChange(
                                isSlide ? i : i + 1, isSlide);
                          },
                          child: BTextB4(
                              '${isSlide ? slideSashLength.reversed.toList()[i] : turnSashLength[i]}')),
                    ).reversed.toList()),
                Row(
                  children: [
                    isSlide
                        ? Image.asset(
                            'assets/images/windows/slide/${componentCubit.sashLength}.png',
                            width: size.width * .7,
                          )
                        : GestureDetector(
                            onTap: () {
                              componentCubit
                                  .isPandaChoose(!componentCubit.isPanda);

                              componentCubit.fixedState(4, false, context);
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                    value: componentCubit.isPanda,
                                    onChanged: (val) {
                                      componentCubit.isPandaChoose(val!);

                                      componentCubit.fixedState(
                                          4, false, context);
                                    }),
                                BTextB5('اضافة درفة باندا')
                              ],
                            ),
                          ),
                    Spacer(),
                    SaveAndCloseButton(),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                if (!isSlide && !isTilt && componentCubit.isPanda)
                  Row(
                    children: [
                      Checkbox(
                          value: componentCubit.isSashFixed,
                          onChanged: (val) {
                            componentCubit.fixedState(4, val, context);
                          }),
                      GestureDetector(
                          onTap: () {
                            componentCubit.fixedState(
                                4, !componentCubit.isSashFixed, context);
                          },
                          child: BTextB5('اضافة ثابت للدرفة')),
                      if (componentCubit.isSashFixed)
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'مقاس ارتفاع الثابت',
                                suffixText: 'سم'),
                            keyboardType: TextInputType.phone,
                            onChanged: (val) {
                              componentCubit.fixedSize(4, val, context);
                            },
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          );
        });
  }
}

class Fixed extends StatelessWidget {
  final bool isTilt;

  const Fixed(this.isTilt);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);

          List<fixedData> data = [
            fixedData('أعلى', componentCubit.topFixedLength,
                componentCubit.topFixedSize, componentCubit.isTopFixed),
            fixedData('أسفل', componentCubit.bottomFixedLength,
                componentCubit.bottomFixedSize, componentCubit.isBottomFixed),
            fixedData('يمين', componentCubit.rightFixedLength,
                componentCubit.rightFixedSize, componentCubit.isRightFixed),
            fixedData('يسار', componentCubit.leftFixedLength,
                componentCubit.leftFixedSize, componentCubit.isLeftFixed),
          ];
          return Container(
            height: size.height * .2,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                    children: List.generate(
                        data.length,
                        (i) => MaterialButton(
                              color: componentCubit.fixedChoose == i
                                  ? Colors.green
                                  : Colors.grey.shade200,
                              onPressed: () {
                                print(componentCubit.fixedChoose);

                                componentCubit.fixedChooseChange(i);
                                print(componentCubit.fixedChoose);
                              },
                              child: BTextB4(data[i].title),
                            ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                        value: data[componentCubit.fixedChoose].isChoose,
                        onChanged: (val) {
                          componentCubit.fixedState(
                              componentCubit.fixedChoose, val, context);
                        }),
                    GestureDetector(
                        onTap: () {
                          componentCubit.fixedState(
                              componentCubit.fixedChoose,
                              !data[componentCubit.fixedChoose].isChoose,
                              context);
                        },
                        child: Container(
                          color: Colors.yellow.shade200,
                          child: BTextB5(
                              '${data[componentCubit.fixedChoose].isChoose ? 'إلغاء' : 'إضافة'} ${data[componentCubit.fixedChoose].title}'),
                        )),
                    Spacer(),
                    if (data[componentCubit.fixedChoose].isChoose && !isTilt)
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BTextB5('عدد السؤاس'),
                              IconButton(
                                  splashColor: Colors.redAccent,
                                  padding: EdgeInsets.all(1),
                                  icon: Icon(Icons.add_circle),
                                  onPressed: () {
                                    if (data[componentCubit.fixedChoose]
                                            .fixLength <=
                                        8)
                                      componentCubit.incrementFixedLength(
                                          componentCubit.fixedChoose);
                                  }),
                              BTextB5(data[componentCubit.fixedChoose]
                                  .fixLength
                                  .toString()),
                              IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {
                                    if (data[componentCubit.fixedChoose]
                                            .fixLength >
                                        0)
                                      componentCubit.decrementFixedLength(
                                          componentCubit.fixedChoose);
                                  }),
                            ]),
                      ),
                    if (isTilt && data[componentCubit.fixedChoose].isChoose)
                      Row(
                        children: [
                          Checkbox(
                              value: componentCubit
                                  .isSuction[componentCubit.fixedChoose],
                              onChanged: (val) {
                                componentCubit.isSuctionChange(
                                    componentCubit.fixedChoose, val);
                              }),
                          GestureDetector(
                              onTap: () {
                                componentCubit.isSuctionChange(
                                    componentCubit.fixedChoose,
                                    !componentCubit
                                        .isSuction[componentCubit.fixedChoose]);
                              },
                              child: Container(
                                  color: Colors.yellow.shade200,
                                  child: BTextB5('إضافة شفاط للثابت'))),
                        ],
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Row(
                  children: [
                    if (data[componentCubit.fixedChoose].isChoose &&
                        !componentCubit.isSuction[componentCubit.fixedChoose])
                      Container(
                        width: size.width * .7,
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText:
                                  'مقاس ${componentCubit.fixedChoose <= 1 || componentCubit.fixedChoose > 3 ? 'ارتفاع' : 'عرض'} الثابت',
                              suffixText: 'سم'),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) {
                            componentCubit.fixedSize(
                                componentCubit.fixedChoose, val, context);
                          },
                        ),
                      ),
                    if (componentCubit.isSuction[componentCubit.fixedChoose])
                      DropdownButton(
                        hint: Container(
                            color: Colors.grey.shade300,
                            child: DPadding(child: BTextB4('مقاس الشفاط'))),
                        icon: Icon(
                          Icons.edit,
                          color: cLogoColorW,
                        ),
                        elevation: 5,
                        iconEnabledColor: cLogoColor,
                        items: componentCubit.suctionSizeList
                            .map(
                              (e) => DropdownMenuItem(
                                child: BTextB5('$e سم '),
                                value: e,
                              ),
                            )
                            .toList(),
                        value: componentCubit
                            .suctionSize[componentCubit.fixedChoose],
                        onChanged: (val) {
                          componentCubit.suctionSizeChange(
                              componentCubit.fixedChoose, val);
                          componentCubit.fixedSize(
                              componentCubit.fixedChoose,
                              (componentCubit.suctionSize[
                                          componentCubit.fixedChoose]! +
                                      4.5)
                                  .toString(),
                              context);
                        },
                      ),
                    if (componentCubit.isSuction[componentCubit.fixedChoose])
                      DropdownButton(
                        hint: Container(
                            color: Colors.grey.shade300,
                            child: DPadding(child: BTextB4('مكان الشفاط'))),
                        icon: Icon(
                          Icons.edit,
                          color: cLogoColorW,
                        ),
                        elevation: 5,
                        iconEnabledColor: cLogoColor,
                        items: componentCubit.suctionPlaceList
                            .map(
                              (e) => DropdownMenuItem(
                                child: BTextB5(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        value: componentCubit
                            .suctionPlace[componentCubit.fixedChoose],
                        onChanged: (val) {
                          componentCubit.suctionPlaceChange(
                              componentCubit.fixedChoose, val);
                          componentCubit.autoFixedLength(
                              componentCubit.fixedChoose, val);
                        },
                      ),
                    if (!data[componentCubit.fixedChoose].isChoose) Spacer(),
                    if (!componentCubit.isSuction[componentCubit.fixedChoose])
                      SizedBox(
                        width: 10,
                      ),
                    SaveAndCloseButton(),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class MoreOptions extends StatelessWidget {
  final bool isSlide, isTilt;

  const MoreOptions(this.isSlide, this.isTilt);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);

          return Container(
            height: 100,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton(
                      hint: Container(
                          color: Colors.grey.shade300,
                          child: DPadding(child: BTextB4('مقاس البار'))),
                      icon: Icon(
                        Icons.edit,
                        color: cLogoColorW,
                      ),
                      elevation: 5,
                      iconEnabledColor: cLogoColor,
                      items: componentCubit.barSizeList
                          .map(
                            (e) => DropdownMenuItem(
                              child: BTextB5('$e سم '),
                              value: e,
                            ),
                          )
                          .toList(),
                      value: componentCubit.barSize,
                      onChanged: (val) {
                        componentCubit.barSizeChange(0, val);
                      },
                    ),
                    DropdownButton(
                      hint: Container(
                          color: Colors.grey.shade300,
                          child: DPadding(child: BTextB4(' السؤاس'))),
                      icon: Icon(
                        Icons.edit,
                        color: cLogoColorW,
                      ),
                      elevation: 5,
                      iconEnabledColor: cLogoColor,
                      items: componentCubit.tSizeList
                          .map(
                            (e) => DropdownMenuItem(
                              child: BTextB5('$e سم '),
                              value: e,
                            ),
                          )
                          .toList(),
                      value: componentCubit.tSize,
                      onChanged: (val) {
                        componentCubit.barSizeChange(1, val);
                      },
                    ),
                    if (!isTilt && !isSlide)
                      DropdownButton(
                        hint: Container(
                            color: Colors.grey.shade300,
                            child: DPadding(child: BTextB4(' الجلسة'))),
                        icon: Icon(
                          Icons.edit,
                          color: cLogoColorW,
                        ),
                        elevation: 5,
                        iconEnabledColor: cLogoColor,
                        items: componentCubit.underSizeList
                            .map(
                              (e) => DropdownMenuItem(
                                child: BTextB5('$e سم '),
                                value: e,
                              ),
                            )
                            .toList(),
                        value: componentCubit.underSize,
                        onChanged: (val) {
                          componentCubit.barSizeChange(2, val);
                        },
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (!isSlide && !isTilt)
                      Row(
                        children: [
                          Checkbox(
                              value: componentCubit.isWithoutUnder,
                              onChanged: (val) {
                                componentCubit.fixedState(5, val, context);
                              }),
                          GestureDetector(
                              onTap: () {
                                componentCubit.fixedState(
                                    5, !componentCubit.isWithoutUnder, context);
                              },
                              child: BTextB5('بدون جلسة سفلية'))
                        ],
                      ),
                    Spacer(),
                    SaveAndCloseButton(),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

class fixedData {
  final String title;
  final double fixSize;
  final int fixLength;
  final bool isChoose;

  fixedData(this.title, this.fixLength, this.fixSize, this.isChoose);
}

class DetailsData {
  final IconData icons;
  final String title;
  final Widget widget;

  DetailsData({required this.icons, required this.title, required this.widget});
}
