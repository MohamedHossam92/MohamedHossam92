import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

class CornerDrawer extends StatelessWidget {
  final double backLeft, backRight, deepLeft, deepRight, height;
  final double columnRight, columnLeft;
  final String cuttingFrontLeftAngle,
      cuttingFrontRightAngle,
      cuttingBackAngle,
      frontSide;
  final double backAngle;
  final bool is90, isWood, isWithColumn;

  const CornerDrawer({
    required this.backLeft,
    required this.backRight,
    required this.columnRight,
    required this.columnLeft,
    required this.deepLeft,
    required this.deepRight,
    required this.height,
    required this.backAngle,
    required this.cuttingFrontLeftAngle,
    required this.cuttingFrontRightAngle,
    required this.cuttingBackAngle,
    required this.frontSide,
    required this.is90,
    this.isWood = false,
    this.isWithColumn = false,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double backRightH = backRight / 85;
    double backLeftH = backLeft / 85;

    double backRightColumn = (backRight - columnRight) / 85;
    double backLeftColumn = (backLeft - columnLeft) / 85;
    double deepRightH = deepRight / 45;
    double deepLeftH = deepLeft / 45;
    Widget resultPosition(left, bottom, result) => Positioned(
        right: size.width * left,
        top: size.height * bottom,
        child: Container(
          color: Colors.yellow.shade200,
          child: BTextB5(
            result,
          ),
        ));
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Column(
              children: [
                DPadding(child: BTextB5('ج :  ${backLeft}')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DPadding(child: BTextB5('أ :  ${backRight}')),
                    Container(
                      child: CornerForm(
                        b1: backRight == 0 ? 85 : backRight,
                        b2: backLeft == 0 ? 85 : backLeft,
                        d1: deepRight == 0 ? 45 : deepRight,
                        d2: deepLeft == 0 ? 45 : deepLeft,
                        columnRight: backRightColumn,
                        columnLeft: backLeftColumn,
                        isWithColumn: isWithColumn,
                        backAngle: backAngle,
                        is90: is90,
                      ),
                    ),
                    Column(
                      children: [
                        DPadding(child: BTextB5('د :  ${deepLeft}')),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DPadding(child: BTextB5('ب :  ${deepRight}')),
                    SizedBox(
                      width: 80,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        if (!is90 && !isWood)
          resultPosition((backLeftH >= 1 ? .56 : .6) * backLeftH,
              (deepLeftH >= 1 ? .13 : .14) * deepLeftH, cuttingFrontLeftAngle),
        if (!is90 && !isWood)
          if (!isWood)
            resultPosition(
                (deepRightH >= 1 ? .36 : .44) * deepRightH,
                (deepRightH >= 1 ? .23 : .22) * backRightH,
                cuttingFrontRightAngle),
        if (!is90 && !isWood)
          resultPosition((backLeftH >= 1 ? .64 : .72) * backLeftH,
              (backRightH >= 1 ? .24 : .23) * backRightH, frontSide),
        if (!isWood) resultPosition(.28, .065, cuttingBackAngle),
      ],
    );
  }
}

//===================== cornet Form =================================
class CornerForm extends StatelessWidget {
  final double b1, b2, d1, d2;
  final double columnRight, columnLeft;

  final double backAngle;
  final bool is90, isWithColumn;

  const CornerForm(
      {required this.b1,
      required this.b2,
      required this.d1,
      required this.d2,
      required this.columnRight,
      required this.columnLeft,
      required this.backAngle,
      required this.is90,
      required this.isWithColumn});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double h = b1 < 40 ? .50 : b1 / 165;
    double w = b2 < 40 ? .50 : b2 / 165;

    // double wColumn = columnLeft - h;
    // double hColumn = columnRight - w;

    double dh = d1 / b1;
    double dw = d2 / b2;

    var h1 = size.width * (h) - 20;
    var w1 = size.width * (w) - 20;

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: Corner90Clipper(dh, dw, backAngle),
          child: Container(
            color: Colors.black,
            height: size.width * h,
            width: size.width * w,
          ),
        ),
        ClipPath(
          clipBehavior: Clip.hardEdge,
          clipper: Corner90Clipper(dh, dw, backAngle),
          child: Container(
            height: size.width * (h - .04),
            width: size.width * (w - .04),
            color: Colors.white,
          ),
        ),
        if (is90)
          Positioned(
            left: 0,
            child: Container(
              width: size.width * (w - .06),
              color: Colors.transparent,
              height: size.width * h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h1 - h1 * (1 - dw) + fillMin(backAngle),
                  ),
                  Container(
                    color: Colors.black,
                    width: size.width * (w - .06),
                    height: 4,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        color: Colors.black,
                        width: 5,
                        height: size.width * h -
                            24 -
                            (h1 - h1 * (1 - dw) + fillMin(backAngle)),
                      ),
                      Container(
                        color: Colors.white,
                        width: w1 - w1 * dh + fillPlus(backAngle),
                        height: size.width * h -
                            24 -
                            (h1 - h1 * (1 - dw) + fillMin(backAngle)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

//=============== العامود ==================
//         Positioned(
//           top: 0,
//           right: 20,
//           child: Container(
//             alignment: Alignment.topRight,
//             color: Colors.black,
//             height: size.width * hColumn,
//             width: size.width * wColumn,
//             child: Container(
//               color: Colors.white,
//               height: size.width * hColumn,
//               width: size.width * wColumn,
//             ),
//           ),
//         )
      ],
    );
  }
}

double fillPlus(backAngle) {
  double angle = backAngle;
  if (angle > 90 && angle < 100)
    return 5;
  else if (angle >= 100 && angle < 110)
    return 10;
  else if (angle >= 110 && angle < 120)
    return 15;
  else if (angle >= 120)
    return 20;
  else
    return 0;
}

double fillMin(backAngle) {
  double angle = backAngle;
  if (angle > 80 && angle < 90)
    return 5;
  else if (angle >= 70 && angle < 80)
    return 10;
  else if (angle >= 60 && angle < 70)
    return 15;
  else if (angle <= 60)
    return 20;
  else
    return 0;
}

class Corner90Clipper extends CustomClipper<Path> {
  double d1, d2;
  double backAngle;
  Corner90Clipper(this.d1, this.d2, this.backAngle);

  @override
  Path getClip(Size size) {
    var path = Path();

    var h = size.height - 20;
    var w = size.width - 20;

    path.moveTo(0, fillMin(backAngle));

    path.lineTo(0, h - h * (1 - d2) + fillMin(backAngle));
    path.lineTo(w - w * d1 + fillPlus(backAngle), h);
    path.lineTo(w + fillPlus(backAngle), h);

    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
