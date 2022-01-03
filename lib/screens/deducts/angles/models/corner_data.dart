import 'dart:math';

class CornerData {
  final int unitId, unitType, id, imageId;

  final double width, height, deepLeft, deepRight, cornerHeight;
  final double backAngle;
  final int rackLength, shutterLength;
  final String unitName;
  final double sk,
      shutterWidthDeduct,
      shutterFillDeduct,
      rackDeduct,
      shutterDoubleFillDeduct;

  final bool isShutterPolyLac, isShutterDouble, isShutterGlass;
  final bool isShutterOnceColor, isShutterMultiColor, isShutterMixColor;
  final bool isDeepNearly, isDeepRemotely;
  final bool isRack25, isHeadCorner, is90, isEnd;

  CornerData({
    required this.unitId,
    required this.unitType,
    required this.id,
    required this.imageId,
    this.sk = 2.5,
    this.shutterWidthDeduct = 25,
    this.shutterFillDeduct = 25,
    required this.shutterDoubleFillDeduct,
    this.rackDeduct = 25,
    required this.width,
    required this.height,
    required this.deepLeft,
    required this.deepRight,
    required this.cornerHeight,
    required this.backAngle,
    required this.rackLength,
    required this.shutterLength,
    required this.unitName,
    this.isShutterPolyLac = false,
    this.isShutterDouble = false,
    this.isShutterGlass = false,
    this.isShutterOnceColor = false,
    this.isShutterMultiColor = false,
    this.isShutterMixColor = false,
    this.isDeepNearly = false,
    this.isDeepRemotely = false,
    this.isRack25 = false,
    this.isHeadCorner = false,
    this.is90 = false,
    this.isEnd = false,
  });

  totalSk() => sk * 2;

  rightWater() => sqrt(pow(height, 2) + pow(deepRight, 2));

  leftWater() => sqrt(pow(width, 2) + pow(deepLeft, 2));

  backRightAngle() {
    double dataRad = acos(height / rightWater());
    double data = (dataRad * 180) / pi;

    return data;
  }

  backLeftAngle() {
    double dataRad = acos(width / leftWater());
    double data = (dataRad * 180) / pi;

    return data;
  }

  backCenterAngle() => backAngle - backRightAngle() - backLeftAngle();

  halfFrontRightAngle() => 90.0 - backRightAngle();

  halfFrontLeftAngle() => 90.0 - backLeftAngle();

  frontSide() {
    double dataRad = backCenterAngle() * pi / 180;
    double dataDeg = cos(dataRad);
    double dataNeed = 2.0 * rightWater() * leftWater() * dataDeg;
    double data = sqrt((pow(rightWater(), 2) + pow(leftWater(), 2) - dataNeed));
    return data;
  }

  otherHalfFrontRightAngle() {
    double up = pow(frontSide(), 2).toDouble() +
        pow(rightWater(), 2) -
        pow(leftWater(), 2);
    double down = 2.0 * frontSide() * rightWater();
    double dataRad = acos(up / down);
    double data = (dataRad * 180) / pi;

    return data;
  }

  otherHalfFrontLeftAngle() {
    double up = pow(frontSide(), 2).toDouble() +
        pow(leftWater(), 2) -
        pow(rightWater(), 2);
    double down = 2.0 * frontSide() * leftWater();
    double dataRad = acos(up / down);
    double data = (dataRad * 180) / pi;

    return data;
  }

  frontRightAngle() => halfFrontRightAngle() + otherHalfFrontRightAngle();

  frontLeftAngle() => halfFrontLeftAngle() + otherHalfFrontLeftAngle();

  cuttingBackAngle() => (180 - backAngle) / 2;

  cuttingFrontRightAngle() => (180 - frontRightAngle()) / 2;

  cuttingFrontLeftAngle() => (180 - frontLeftAngle()) / 2;

  double fillPlus() {
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

  shutterWidthDeductFinal() => shutterWidthDeduct * .1;

  entryWidth() => frontSide() - totalSk();

  entryHeight() => cornerHeight - totalSk();

  resultWidthWoodShutter() => frontSide() - shutterWidthDeduct;
  resultHeightWoodShutter() => cornerHeight - shutterWidthDeduct;

  resultWidthShutter() => entryWidth() + shutterWidthDeductFinal();
  resultHeightShutter() => entryHeight() + shutterWidthDeductFinal();

  right90FrontSide() => height - deepLeft - sk;
  left90FrontSide() => width - deepRight - sk;

  right90widthShutter() => right90FrontSide() + shutterWidthDeduct / 2;
  left90widthShutter() => left90FrontSide() + shutterWidthDeduct / 2;
}
///////////////////////////////////////////////////////

class CornerAngleData {
  final double side1st, side2nd, water;

  CornerAngleData(
      {required this.side1st, required this.side2nd, required this.water});

  backAngle() {
    double up = pow(side1st, 2).toDouble() + pow(side2nd, 2) - pow(water, 2);
    double down = 2 * side1st * side2nd;
    double dataRad = acos(up / down);
    double data = (dataRad * 180) / pi;

    return data;
  }
}
