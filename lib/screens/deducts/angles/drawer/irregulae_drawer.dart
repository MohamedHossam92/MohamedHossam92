import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

class IrregularDrawer extends StatelessWidget {
  final double rightSide, leftSide, bottomSide;
  final List list;

  const IrregularDrawer(
      {required this.rightSide,
      required this.leftSide,
      required this.bottomSide,
      required this.list});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Column(
              children: [
                list.isNotEmpty
                    ? DPadding(
                        child: BTextB5(
                            'ج :  ${list[0].topSide().toStringAsFixed(1)}'))
                    : SizedBox(
                        height: 25,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DPadding(child: BTextB5('أ :  ${rightSide}')),
                    Container(
                      child: IrregularForm(
                          rightSide == 0 ? 30 : rightSide - leftSide,
                          bottomSide == 0 ? 60 : bottomSide,
                          rightSide == 0 ? 70 : rightSide,
                          list.isNotEmpty
                              ? list[0].cutRightAngle().toStringAsFixed(1)
                              : '',
                          list.isNotEmpty
                              ? list[0].cutLeftAngle().toStringAsFixed(1)
                              : ''),
                    ),
                    Column(
                      children: [
                        DPadding(child: BTextB5('ب :  ${leftSide}')),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DPadding(child: BTextB5('جـ :  ${bottomSide}')),
                    SizedBox(
                      width: 80,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IrregularForm extends StatelessWidget {
  final double n, bottom, right;
  final String rightIrregular, leftIrregular;

  const IrregularForm(
      this.n, this.bottom, this.right, this.rightIrregular, this.leftIrregular);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double finalBottom = bottom >= 80 ? 300 : 150;
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: Corner90Clipper(n),
          child: Container(
            color: Colors.black,
            height: size.width * (right / finalBottom),
            width: size.width * (bottom / finalBottom),
          ),
        ),
        ClipPath(
          clipBehavior: Clip.hardEdge,
          clipper: Corner90Clipper(n),
          child: Container(
            alignment: Alignment.topCenter,
            height: size.width * (right / finalBottom - .03),
            width: size.width * (bottom / finalBottom - .03),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: n / 2,
                    ),
                    Container(
                        color: Colors.yellow.shade200,
                        child: BTextB5(rightIrregular)),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: n,
                    ),
                    Container(
                        color: Colors.yellow.shade200,
                        child: BTextB5(leftIrregular)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Corner90Clipper extends CustomClipper<Path> {
  final double n;

  Corner90Clipper(this.n);
  @override
  Path getClip(Size size) {
    var path = Path();

    var h = size.height;
    var w = size.width;

    path.moveTo(0, n);

    path.lineTo(0, h - h);
    path.lineTo(w - w, h);
    path.lineTo(w, h);

    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
