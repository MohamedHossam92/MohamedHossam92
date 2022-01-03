import 'dart:math';

class IrregularAngleData {
  final double leftSide, rightSide, bottomSide, barSize;

  IrregularAngleData(
      this.leftSide, this.rightSide, this.bottomSide, this.barSize);

  rightSideUp() {
    double data = rightSide - leftSide;
    return data;
  }

  topSide() {
    double dataNeed = (pow(rightSideUp(), 2) + pow(bottomSide, 2)).toDouble();
    double data = sqrt(dataNeed);
    return data;
  }

  rightAngle() {
    double up = pow(rightSideUp(), 2).toDouble() +
        pow(topSide(), 2) -
        pow(bottomSide, 2);
    double down = 2.0 * rightSideUp() * topSide();
    double dataRad = acos(up / down);
    double data = (dataRad * 180) / pi;

    return data;
  }

  leftAngle() => 180 - rightAngle();
  cutRightAngle() => leftAngle() / 2;
  cutLeftAngle() => rightAngle() / 2;
}
