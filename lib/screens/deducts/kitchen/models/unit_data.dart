class UnitData {
  final int unitId, imageId, unitType;
  final String unitName;
  final int widthShutterLength, heightShutterLength, drawerLength;
  final int rackLength;
  final bool isOpened, isFixed, isDrawer, withoutShutter, isWithTilt;
  final int heightMultiShutterLength, widthMultiShutterLength;
  final bool isMultiHeight, isMultiWidth, isBigLowerHeight;
  final bool isNew, isShutterWithDrawer;
  final bool isSlide, isBasket, isEnd, is90;

  UnitData(
      {required this.unitId,
      required this.imageId,
      required this.unitName,
      this.unitType = 0,
      this.widthShutterLength = 1,
      this.heightShutterLength = 1,
      this.heightMultiShutterLength = 1,
      this.widthMultiShutterLength = 1,
      this.rackLength = 1,
      this.drawerLength = 0,
      this.isMultiHeight = false,
      this.isMultiWidth = false,
      this.isBigLowerHeight = false,
      this.isOpened = false,
      this.isWithTilt = false,
      this.isFixed = false,
      this.withoutShutter = false,
      this.isShutterWithDrawer = false,
      this.isDrawer = false,
      this.isSlide = false,
      this.isBasket = false,
      this.is90 = false,
      this.isEnd = false,
      this.isNew = false});
}
