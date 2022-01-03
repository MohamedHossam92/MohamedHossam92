import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/list_is_empty.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/slide_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/slide_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/turn_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/turn_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/windows_drawer.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/windows_drawer_details.dart';

import '../../a-component/text_form.dart';

class AddNewWindows extends StatelessWidget {
  final List list;
  final bool isSlide, isTilt;

  const AddNewWindows(
      {Key? key,
      required this.list,
      required this.isSlide,
      this.isTilt = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TurnCubit, TurnState>(
        listener: (context, state) {},
        builder: (context, state) {
          TurnCubit turnCubit = BlocProvider.of(context);
          return BlocConsumer<SlideCubit, SlideState>(
              listener: (context, state) {},
              builder: (context, state) {
                SlideCubit slideCubit = BlocProvider.of(context);
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
                                  children: list.isNotEmpty
                                      ? List.generate(
                                          list.length,
                                          (i) => Stack(
                                            alignment: Alignment.topLeft,
                                            children: [
                                              DPadding(
                                                val: .008,
                                                child: Container(
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(0, 1),
                                                            spreadRadius: 0)
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
                                                              child:
                                                                  WindowsDrawer(
                                                                isSlide:
                                                                    isSlide,
                                                                isTilt: isSlide
                                                                    ? false
                                                                    : list[i]
                                                                        .isTilt,
                                                                sashFixedSize:
                                                                    20,
                                                                widthQuery: list[i].windowsHeight /
                                                                            list[i]
                                                                                .windowsWidth >=
                                                                        .22
                                                                    ? .22 /
                                                                        (list[i].windowsHeight /
                                                                            list[i].windowsWidth)
                                                                    : .22,
                                                                heightWindows:
                                                                    list[i]
                                                                        .windowsHeight,
                                                                widthWindows: list[
                                                                        i]
                                                                    .windowsWidth,
                                                                isTopFixed: list[
                                                                        i]
                                                                    .isTopFixed,
                                                                isBottomFixed:
                                                                    list[i]
                                                                        .isBottomFixed,
                                                                isRightFixed: list[
                                                                        i]
                                                                    .isRightFixed,
                                                                isLeftFixed: list[
                                                                        i]
                                                                    .isLeftFixed,
                                                                topFixedLength:
                                                                    list[i]
                                                                        .topFixedLength,
                                                                bottomFixedLength:
                                                                    list[i]
                                                                        .bottomFixedLength,
                                                                rightFixedLength:
                                                                    list[i]
                                                                        .rightFixedLength,
                                                                leftFixedLength:
                                                                    list[i]
                                                                        .leftFixedLength,
                                                                sashLength: list[
                                                                        i]
                                                                    .sashLength,
                                                                topFixedSize: list[
                                                                        i]
                                                                    .topFixedSize,
                                                                bottomFixedSize:
                                                                    list[i]
                                                                        .bottomFixedSize,
                                                                rightFixedSize:
                                                                    list[i]
                                                                        .rightFixedSize,
                                                                leftFixedSize:
                                                                    list[i]
                                                                        .leftFixedSize,
                                                                isSashFixed: isSlide
                                                                    ? false
                                                                    : list[i]
                                                                        .isSashFixed,
                                                                isPanda: isSlide
                                                                    ? false
                                                                    : list[i]
                                                                        .isPanda,
                                                              ),
                                                            ),
                                                            BTextB4(
                                                                '${list[i].windowsWidth} * ${list[i].windowsHeight} '),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    isSlide
                                                        ? slideCubit
                                                            .deleteWindowsFromList(
                                                                list[i].id)
                                                        : turnCubit
                                                            .deleteWindowsFromList(
                                                                list[i].id);
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
                      Expanded(
                        child: WindowsDrawerDetails(isSlide, isTilt),
                      ),
                      AddSize()
                    ],
                  ),
                );
              });
        });
  }
}
