import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/windows_drawer.dart';

class WindowsDrawerDetails extends StatelessWidget {
  final bool isSlide, isTilt;
  const WindowsDrawerDetails(this.isSlide, this.isTilt);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);

          double query() => componentCubit.height / componentCubit.width >= .6
              ? .6 / (componentCubit.height / componentCubit.width)
              : .6;

          final double height =
              componentCubit.height / componentCubit.width * query();
          final double leftFixed =
              componentCubit.leftFixedSize / componentCubit.width * query();
          final double rightFixed =
              componentCubit.rightFixedSize / componentCubit.width * query();
          final double topFixed =
              componentCubit.topFixedSize / componentCubit.height * height;
          final double bottomFixed =
              componentCubit.bottomFixedSize / componentCubit.height * height;
          final double centerWidth = (query() -
              (componentCubit.isRightFixed ? rightFixed : 0) -
              (componentCubit.isLeftFixed ? leftFixed : 0));
          final double centerHeight = (height -
              (componentCubit.isTopFixed ? topFixed : 0) -
              (componentCubit.isBottomFixed ? bottomFixed : 0));

          final widthMark = Container(
            color: Colors.black,
            height: 1.5,
            width: size.width * .03,
          );
          final heightMark = Container(
            color: Colors.black,
            width: 1.5,
            height: 12,
          );

          return SafeArea(
              child: WillPopScope(
                  onWillPop: () async {
                    componentCubit.clearFixedData();
                    return true;
                  },
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight,
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        componentCubit.isTopFixed ||
                                                componentCubit.isBottomFixed
                                            ? Column(
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        color: Colors
                                                            .grey.shade300,
                                                        height:
                                                            size.width * height,
                                                        width: 3,
                                                      ),
                                                      Column(
                                                        children: [
                                                          if (componentCubit
                                                              .isTopFixed)
                                                            Container(
                                                              height:
                                                                  size.width *
                                                                      topFixed,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Divider(
                                                                    thickness:
                                                                        3,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      widthMark,
                                                                      Container(
                                                                          color: Colors
                                                                              .white,
                                                                          child: BTextB5(componentCubit
                                                                              .topFixedSize
                                                                              .toString())),
                                                                      widthMark,
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          Container(
                                                            height: size.width *
                                                                centerHeight,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          1.0),
                                                                  child:
                                                                      widthMark,
                                                                ),
                                                                Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child: BTextB5(
                                                                        '${componentCubit.centerHeightSize()}')),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          1.0),
                                                                  child:
                                                                      widthMark,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          if (componentCubit
                                                              .isBottomFixed)
                                                            Container(
                                                              height: size
                                                                      .width *
                                                                  bottomFixed,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  widthMark,
                                                                  Container(
                                                                      color: Colors
                                                                          .white,
                                                                      child: BTextB5(componentCubit
                                                                          .bottomFixedSize
                                                                          .toString())),
                                                                  widthMark,
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : SizedBox(
                                                width: size.width * .13,
                                              ),
                                        Column(
                                          children: [
                                            SPadding(
                                              v: .02,
                                              h: 0,
                                              child: Container(
                                                width: size.width * query(),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Divider(
                                                      thickness: 3,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        heightMark,
                                                        Container(
                                                            color: Colors.white,
                                                            child: BTextB5(
                                                                '${componentCubit.width}')),
                                                        heightMark,
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            WindowsDrawer(
                                              isSlide: isSlide,
                                              widthQuery: query(),
                                              heightWindows:
                                                  componentCubit.height,
                                              widthWindows:
                                                  componentCubit.width,
                                              isTopFixed:
                                                  componentCubit.isTopFixed,
                                              isBottomFixed:
                                                  componentCubit.isBottomFixed,
                                              isRightFixed:
                                                  componentCubit.isRightFixed,
                                              isLeftFixed:
                                                  componentCubit.isLeftFixed,
                                              topFixedLength:
                                                  componentCubit.topFixedLength,
                                              bottomFixedLength: componentCubit
                                                  .bottomFixedLength,
                                              rightFixedLength: componentCubit
                                                  .rightFixedLength,
                                              leftFixedLength: componentCubit
                                                  .leftFixedLength,
                                              sashLength:
                                                  componentCubit.sashLength,
                                              isPanda: componentCubit.isPanda,
                                              isSashFixed:
                                                  componentCubit.isSashFixed,
                                              sashFixedSize:
                                                  componentCubit.sashFixedSize,
                                              topFixedSize:
                                                  componentCubit.topFixedSize,
                                              bottomFixedSize: componentCubit
                                                  .bottomFixedSize,
                                              rightFixedSize:
                                                  componentCubit.rightFixedSize,
                                              leftFixedSize:
                                                  componentCubit.leftFixedSize,
                                              isTilt: isTilt,
                                            ),
                                            componentCubit.isRightFixed ||
                                                    componentCubit.isLeftFixed
                                                ? SPadding(
                                                    v: .02,
                                                    h: 0,
                                                    child: Container(
                                                      width:
                                                          size.width * query(),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          if (componentCubit
                                                              .isRightFixed)
                                                            Container(
                                                              width: size
                                                                      .width *
                                                                  rightFixed,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Divider(
                                                                    thickness:
                                                                        3,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      heightMark,
                                                                      Container(
                                                                          color:
                                                                              Colors.white,
                                                                          child: componentCubit.rightFixedSize >= 45
                                                                              ? BTextB5(componentCubit.rightFixedSize.toString())
                                                                              : Text(
                                                                                  componentCubit.rightFixedSize.toString(),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * rightFixed * .3),
                                                                                )),
                                                                      heightMark,
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          Spacer(),
                                                          Container(
                                                            width: size.width *
                                                                centerWidth,
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Divider(
                                                                  thickness: 3,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              1),
                                                                      child:
                                                                          heightMark,
                                                                    ),
                                                                    Container(
                                                                      color: Colors
                                                                          .white,
                                                                      child: BTextB5(
                                                                          '${componentCubit.centerWidthSize()}'),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              1),
                                                                      child:
                                                                          heightMark,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          if (componentCubit
                                                              .isLeftFixed)
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      leftFixed,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Divider(
                                                                    thickness:
                                                                        3,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      heightMark,
                                                                      Container(
                                                                        color: Colors
                                                                            .white,
                                                                        child: componentCubit.leftFixedSize >=
                                                                                45
                                                                            ? BTextB5(componentCubit.leftFixedSize.toString())
                                                                            : Text(
                                                                                componentCubit.leftFixedSize.toString(),
                                                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * leftFixed * .3),
                                                                              ),
                                                                      ),
                                                                      heightMark,
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: size.height * .047,
                                                  ),
                                          ],
                                        ),

                                        //=============== height ================
                                        Container(
                                            child: Row(children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    color: Colors.grey.shade300,
                                                    height: size.width * height,
                                                    width: 3,
                                                  ),
                                                  Container(
                                                    height: size.width * height,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        widthMark,
                                                        Container(
                                                            color: Colors.white,
                                                            child: BTextB5(
                                                                componentCubit
                                                                    .height
                                                                    .toString())),
                                                        widthMark
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ])),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))));
        });
  }
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height * .4;
    blockSizeHorizontal = screenWidth;
    blockSizeVertical = screenHeight;
    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;

    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!);
    safeBlockVertical = (screenHeight! - _safeAreaVertical!);
  }
}
