class FlyScreenData {
  final String flyType;

  final double width, height;
  final int length, sashLength;
  final double deductWidth, deductHeight, deductSash, deductFlyScreen;
  final bool isUp;

  FlyScreenData(
      {required this.flyType,
      required this.width,
      required this.height,
      required this.length,
      required this.sashLength,
      required this.deductWidth,
      required this.deductHeight,
      required this.deductSash,
      required this.deductFlyScreen,
      required this.isUp});

  sashType() => isUp ? width : height;
  fluType() => isUp ? height : width;
  widthFrame() => width - deductWidth;
  heightFrame() => height - deductHeight;
  sashFrame() => sashType() - deductSash;
  flyScreenWithSash() => sashFrame() + deductFlyScreen;
  flyScreenZigZag() => fluType() / 100 * 34 / sashLength - sashLength;
  area() => width * height * .0001 * length;
}

List<FlyScreenListData> flyScreenList = [
  FlyScreenListData(
      flyType: 'شركة الاتحاد',
      deductWidth: 7,
      deductHeight: 4,
      deductSash: 7.7,
      deductFlyScreen: 3.2),
  FlyScreenListData(
      flyType: 'كومبن - ComPen',
      deductWidth: 2.5,
      deductHeight: 6,
      deductSash: 8,
      deductFlyScreen: 6),
  FlyScreenListData(
      flyType: 'شركة SM',
      deductWidth: 2.7,
      deductHeight: 6,
      deductSash: 8.2,
      deductFlyScreen: 5.2),
  FlyScreenListData(
      flyType: 'شركة قباري',
      deductWidth: 2.5,
      deductHeight: 6,
      deductSash: 8,
      deductFlyScreen: 6),
];

class FlyScreenListData {
  final String flyType;
  final double deductWidth, deductHeight, deductSash, deductFlyScreen;

  FlyScreenListData(
      {required this.flyType,
      required this.deductWidth,
      required this.deductHeight,
      required this.deductSash,
      required this.deductFlyScreen});
}
