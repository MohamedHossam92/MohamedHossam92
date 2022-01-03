import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';

class WindowsDrawer extends StatelessWidget {
  final double widthQuery, heightWindows, widthWindows;
  final bool isTopFixed, isBottomFixed, isRightFixed, isLeftFixed;
  final bool isSlide, isPanda, isSashFixed, isTilt;
  final int topFixedLength,
      bottomFixedLength,
      rightFixedLength,
      leftFixedLength,
      sashLength;

  final double topFixedSize, bottomFixedSize, rightFixedSize, leftFixedSize;
  final double sashFixedSize;

  const WindowsDrawer({
    Key? key,
    required this.widthQuery,
    required this.heightWindows,
    required this.widthWindows,
    required this.isTopFixed,
    required this.isBottomFixed,
    required this.isRightFixed,
    required this.isLeftFixed,
    required this.topFixedLength,
    required this.bottomFixedLength,
    required this.rightFixedLength,
    required this.leftFixedLength,
    required this.sashLength,
    required this.topFixedSize,
    required this.bottomFixedSize,
    required this.rightFixedSize,
    required this.leftFixedSize,
    this.sashFixedSize = 60,
    required this.isSlide,
    required this.isTilt,
    this.isPanda = false,
    this.isSashFixed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double height = heightWindows / widthWindows * widthQuery;
    final double heightFixed = sashFixedSize / widthWindows * widthQuery;
    final double leftFixed = leftFixedSize / widthWindows * widthQuery;
    final double rightFixed = rightFixedSize / widthWindows * widthQuery;
    final double topFixed = topFixedSize / heightWindows * height;
    final double bottomFixed = bottomFixedSize / heightWindows * height;
    final double centerWidth = (widthQuery -
        (isRightFixed ? rightFixed : 0) -
        (isLeftFixed ? leftFixed : 0));
    final double centerHeight = (height -
        (isTopFixed ? topFixed : 0) -
        (isBottomFixed ? bottomFixed : 0));

    final double pandaHeight =
        !isSashFixed ? centerHeight : centerHeight - heightFixed;

    final double pandaWidthTilt = centerWidth * widthQuery;

    final boxDecorations = BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/windows/glass.jpg'),
            fit: BoxFit.cover),
        border: Border.all(color: Colors.black, width: 5 * widthQuery));

    int sashLengths() {
      if (sashLength >= 2 && isSlide)
        return sashLength;
      else if (sashLength < 2 && isSlide)
        return 3;
      else
        return sashLength;
    }

    return Container(
      height: size.width * height,
      width: size.width * widthQuery,
      decoration: boxDecorations,
      child: Stack(
        alignment: Alignment.center,
        children: [
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          Positioned(
            top: isTopFixed ? size.width * topFixed : 0,
            bottom: isBottomFixed ? size.width * bottomFixed : 0,
            right: isRightFixed ? size.width * rightFixed : 0,
            left: isLeftFixed ? size.width * leftFixed : 0,
            child: !isTilt
                ? Row(
                    children: List.generate(sashLengths(), (i) {
                      closedAlign() {
                        if (i == 0) return Alignment.centerRight;
                        if (i == 1) return null;
                        if (i == 2) return Alignment.centerLeft;
                      }

//==========================================ROW===================================================
                      List<Widget> row(Widget panda,
                          [bool isPandaRow = false, withHung = true]) {
                        return [
                          Container(
                              color: Colors.black,
                              width: widthQuery * 7,
                              height: isPandaRow
                                  ? size.width * pandaHeight -
                                      (widthQuery * 20.7) -
                                      (widthQuery == .25 ? .25 : 0) -
                                      (isSashFixed ? (widthQuery * 14) : 0)
                                  : size.width * centerHeight,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                      heightWindows >= 150 && !isPandaRow
                                          ? 3
                                          : 2,
                                      (i) => SPadding(
                                            h: .0005,
                                            v: isPandaRow
                                                ? pandaHeight * .1
                                                : centerHeight * .08,
                                            child: Image.asset(
                                              'assets/images/windows/hung.png',
                                            ),
                                          )))),
                          Expanded(child: panda),
                          Container(
                            color: Colors.black,
                            width: widthQuery * 14,
                            height: isPandaRow
                                ? size.width * pandaHeight -
                                    (widthQuery * 20.7) -
                                    (widthQuery == .25 ? .25 : 0) -
                                    (isSashFixed ? (widthQuery * 14) : 0)
                                : size.width * centerHeight,
                            child: isPandaRow
                                ? Image.asset(
                                    'assets/images/windows/t_closed.png',
                                  )
                                : withHung
                                    ? Image.asset(
                                        'assets/images/windows/t_closed.png',
                                      )
                                    : SizedBox(),
                          ),
                        ];
                      }

//======================================الجرار====================================
                      return isSlide
                          ? Container(
                              alignment: sashLength != 1
                                  ? (i.isEven
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft)
                                  : closedAlign(),
                              height: size.width * centerHeight,
                              width:
                                  size.width * (centerWidth / sashLengths()) -
                                      ((widthQuery * 10) / sashLengths()),
                              decoration: boxDecorations,
                              child: sashLength == 1 && i == 1
                                  ? SizedBox()
                                  : Image.asset(
                                      'assets/images/windows/closed.png',
                                      width: size.width *
                                          centerWidth *
                                          centerHeight *
                                          .15,
                                    ),
                            )
                          :
                          //=================================== المفصلي ==========================
                          Container(
                              width:
                                  size.width * (centerWidth / sashLengths()) -
                                      ((widthQuery * 10) / sashLengths()),
                              decoration: boxDecorations,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (sashLength <= 2)
                                      ...i.isEven
                                          ? row(
                                              Column(
                                                children: [
                                                  Container(
                                                    width: size.width *
                                                            (centerWidth /
                                                                sashLengths()) -
                                                        ((widthQuery * 10) /
                                                            sashLengths()),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: .1)),
                                                    child: isPanda
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: row(
                                                                      SizedBox(),
                                                                      true)),
                                                              if (isSashFixed)
                                                                Container(
                                                                  color: Colors
                                                                      .black,
                                                                  height:
                                                                      widthQuery *
                                                                          14,
                                                                  width: size.width *
                                                                          (centerWidth /
                                                                              sashLengths()) -
                                                                      ((widthQuery *
                                                                              10) /
                                                                          sashLengths()),
                                                                ),
                                                              if (isSashFixed)
                                                                Container(
                                                                  height: size
                                                                          .width *
                                                                      heightFixed,
                                                                  width: size.width *
                                                                          (centerWidth /
                                                                              sashLengths()) -
                                                                      ((widthQuery *
                                                                              10) /
                                                                          sashLengths()),
                                                                  decoration:
                                                                      boxDecorations,
                                                                )
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : row(
                                              Column(
                                                children: [
                                                  Container(
                                                    width: size.width *
                                                            (centerWidth /
                                                                sashLengths()) -
                                                        ((widthQuery * 10) /
                                                            sashLengths()),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: .2)),
                                                    child: isPanda
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: row(
                                                                          SizedBox(),
                                                                          true)
                                                                      .reversed
                                                                      .toList()),
                                                              if (isSashFixed)
                                                                Container(
                                                                  color: Colors
                                                                      .black,
                                                                  height:
                                                                      widthQuery *
                                                                          14,
                                                                  width: size.width *
                                                                          (centerWidth /
                                                                              sashLengths()) -
                                                                      ((widthQuery *
                                                                              10) /
                                                                          sashLengths()),
                                                                ),
                                                              if (isSashFixed)
                                                                Container(
                                                                  height: size
                                                                          .width *
                                                                      heightFixed,
                                                                  width: size.width *
                                                                          (centerWidth /
                                                                              sashLengths()) -
                                                                      ((widthQuery *
                                                                              10) /
                                                                          sashLengths()),
                                                                  decoration:
                                                                      boxDecorations,
                                                                )
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                ],
                                              ),
                                            ).reversed.toList(),
                                    if (sashLength >= 3)
                                      ...i != 2 && i != 3
                                          ? row(
                                              Column(
                                                children: [
                                                  Container(
                                                    width: size.width *
                                                            (centerWidth /
                                                                sashLengths()) -
                                                        ((widthQuery * 10) /
                                                            sashLengths()),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 0)),
                                                    child: isPanda
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: row(
                                                                      SizedBox(),
                                                                      true,
                                                                      i == 0
                                                                          ? false
                                                                          : true)),
                                                              if (isSashFixed)
                                                                Container(
                                                                  color: Colors
                                                                      .black,
                                                                  height:
                                                                      widthQuery *
                                                                          14,
                                                                  width: size.width *
                                                                          (centerWidth /
                                                                              sashLengths()) -
                                                                      ((widthQuery *
                                                                              10) /
                                                                          sashLengths()),
                                                                ),
                                                              if (isSashFixed)
                                                                Container(
                                                                  height: size
                                                                          .width *
                                                                      heightFixed,
                                                                  width: size.width *
                                                                          (centerWidth /
                                                                              sashLengths()) -
                                                                      ((widthQuery *
                                                                              10) /
                                                                          sashLengths()),
                                                                  decoration:
                                                                      boxDecorations,
                                                                )
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                ],
                                              ),
                                              false,
                                              i == 0 ? false : true)
                                          : row(
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: size.width *
                                                                (centerWidth /
                                                                    sashLengths()) -
                                                            ((widthQuery * 10) /
                                                                sashLengths()),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 0)),
                                                        child: isPanda
                                                            ? Column(
                                                                children: [
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: row(
                                                                              SizedBox(),
                                                                              true,
                                                                              i == 3 ? false : true)
                                                                          .reversed
                                                                          .toList()),
                                                                  if (isSashFixed)
                                                                    Container(
                                                                      color: Colors
                                                                          .black,
                                                                      height:
                                                                          widthQuery *
                                                                              14,
                                                                      width: size.width *
                                                                              (centerWidth /
                                                                                  sashLengths()) -
                                                                          ((widthQuery * 10) /
                                                                              sashLengths()),
                                                                    ),
                                                                  if (isSashFixed)
                                                                    Container(
                                                                      height: size
                                                                              .width *
                                                                          heightFixed,
                                                                      width: size.width *
                                                                              (centerWidth /
                                                                                  sashLengths()) -
                                                                          ((widthQuery * 10) /
                                                                              sashLengths()),
                                                                      decoration:
                                                                          boxDecorations,
                                                                    )
                                                                ],
                                                              )
                                                            : SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                  false,
                                                  i == 3 ? false : true)
                                              .reversed
                                              .toList(),
                                  ]));
                    }),
                  )
                : Column(
                    children: List.generate(sashLengths(), (i) {
                      closedAlign() {
                        if (i == 0) return Alignment.centerRight;
                        if (i == 1) return null;
                        if (i == 2) return Alignment.centerLeft;
                      }

//==========================================ROW===================================================
                      List<Widget> row(Widget panda,
                          [bool isPandaRow = false, withHung = true]) {
                        return [
                          Container(
                            color: Colors.black,
                            height: widthQuery * 30,
                            width: isPandaRow
                                ? size.width * centerWidth - widthWindows * .13
                                : size.width * centerWidth,
                            child: withHung
                                ? Image.asset(
                                    'assets/images/windows/t_closed.png',
                                  )
                                : SizedBox(),
                          ),
                          Expanded(child: panda),
                          if (!isPandaRow)
                            Container(
                              color: Colors.black,
                              height: widthQuery * 10,
                              width: isPandaRow
                                  ? size.width * centerWidth - 14
                                  : size.width * centerWidth,
                            ),
                        ];
                      }

//======================================القلاب====================================
                      return Container(
                          height: size.width * (centerHeight / sashLengths()) -
                              ((widthQuery * 10) / sashLengths()),
                          width:
                              size.width * (centerWidth) - ((widthQuery * 10)),
                          decoration: boxDecorations,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...row(
                                  Column(
                                    children: [
                                      Container(
                                        height: size.width *
                                                (centerHeight / sashLengths()) -
                                            ((widthQuery * 60 * sashLength) /
                                                sashLengths()),
                                        width: size.width * (centerWidth) -
                                            ((widthQuery * 10)),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: .2)),
                                        child: isPanda
                                            ? Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: row(
                                                          SizedBox(), true)),
                                                ],
                                              )
                                            : SizedBox(),
                                      ),
                                    ],
                                  ),
                                )
                              ]));
                    }),
                  ),
          ),
//=======================الثوابت ================================
          if (isRightFixed)
            Positioned(
              right: 0,
              top: isTopFixed ? size.width * topFixed : 0,
              bottom: isBottomFixed ? size.width * bottomFixed : 0,
              child: Container(
                height: size.width * centerHeight,
                width: size.width * rightFixed,
                decoration: boxDecorations,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      rightFixedLength + 2,
                      (i) => Container(
                            height: 6 * widthQuery,
                            width: size.width * rightFixed,
                            color: Colors.black,
                          )),
                ),
              ),
            ),
          if (isLeftFixed)
            Positioned(
              left: 0,
              top: isTopFixed ? size.width * topFixed : 0,
              bottom: isBottomFixed ? size.width * bottomFixed : 0,
              child: Container(
                height: size.width * centerHeight,
                width: size.width * leftFixed,
                decoration: boxDecorations,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      leftFixedLength + 2,
                      (i) => Container(
                            height: 6 * widthQuery,
                            width: size.width * leftFixed,
                            color: Colors.black,
                          )),
                ),
              ),
            ),
          if (isBottomFixed)
            Positioned(
              bottom: 0,
              child: Container(
                height: size.width * bottomFixed,
                width: size.width * widthQuery + 5,
                decoration: boxDecorations,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      bottomFixedLength + 2,
                      (i) => Container(
                            height: size.width * bottomFixed,
                            width: 6 * widthQuery,
                            color: Colors.black,
                          )),
                ),
              ),
            ),
          if (isTopFixed)
            Positioned(
              top: 0,
              child: Container(
                height: size.width * topFixed,
                width: size.width * widthQuery + 5,
                decoration: boxDecorations,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      topFixedLength + 2,
                      (i) => Container(
                            height: size.width * topFixed,
                            width: 6 * widthQuery,
                            color: Colors.black,
                          )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
