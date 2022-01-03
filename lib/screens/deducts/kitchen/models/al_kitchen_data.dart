class AluminiumKitchenData {
  final int unitId, unitType, id, imageId;
  String? shutterType;
  final String unitName;
  final double width, height, deep;
  //
  final bool isMultiHeight, isMultiWidth, isShutterWithDrawer;
  final double entryHeightMulti, entryWidthMulti;
  final int widthMultiShutterLength, heightMultiShutterLength;
  //
  final int widthShutterLength, heightShutterLength, rackLength, drawerLength;
  final double sk;
  final bool isBackOut, isBackIn, isBackInOut, isHeadCorner, isFaceUnit;
  final double shutterWidthDeduct;
  final double shutterFillDeduct, shutterDoubleFillDeduct;
  final bool isOpened, isFixed, isWithTilt;
  final bool isSlide, isBasket;
  final double openedUnitHeight, fixedWidth, heightDrawer;
  final bool isDeepNearly, isDeepRemotely;
  final bool isDrawer45, isRack25, isDrawer;
  final bool withoutShutter, isShutterPolyLac, isShutterDouble, isShutterGlass;
  final bool isShutterOnceColor, isShutterMultiColor, isShutterMixColor;

  AluminiumKitchenData({
    required this.isMultiHeight,
    required this.isMultiWidth,
    required this.entryHeightMulti,
    required this.entryWidthMulti,
    required this.widthMultiShutterLength,
    required this.heightMultiShutterLength,
    required this.isShutterWithDrawer,
    required this.id,
    required this.unitId,
    required this.imageId,
    required this.unitType,
    required this.unitName,
    required this.shutterType,
    required this.width,
    required this.height,
    required this.deep,
    required this.widthShutterLength,
    required this.heightShutterLength,
    required this.rackLength,
    required this.drawerLength,
    required this.sk,
    required this.isBackOut,
    required this.isBackIn,
    required this.isBackInOut,
    required this.isHeadCorner,
    required this.isFaceUnit,
    required this.shutterWidthDeduct,
    required this.shutterFillDeduct,
    required this.shutterDoubleFillDeduct,
    required this.isOpened,
    required this.isWithTilt,
    required this.isFixed,
    required this.openedUnitHeight,
    required this.fixedWidth,
    required this.heightDrawer,
    required this.isDeepNearly,
    required this.isDeepRemotely,
    required this.isDrawer45,
    required this.withoutShutter,
    required this.isShutterPolyLac,
    required this.isDrawer,
    required this.isRack25,
    required this.isShutterDouble,
    required this.isShutterGlass,
    required this.isShutterOnceColor,
    required this.isShutterMultiColor,
    required this.isShutterMixColor,
    required this.isSlide,
    required this.isBasket,
  });

  totalSk() => sk * 2;

  shutterWidthDeductFinal() => shutterWidthDeduct * .1;

  openedSizeFinal() => isOpened || isWithTilt ? sk + openedUnitHeight : 0;

  fixedSizeFinal() => isFixed ? fixedWidth - sk : 0;

  resultWidthSk() => width - totalSk();

  resultHeightSk() => height - totalSk();

  resultDeepSk() => deep - totalSk();

  entryWidth() => isMultiWidth
      ? width - entryWidthMulti - sk - totalSk() - fixedSizeFinal()
      : resultWidthSk() - fixedSizeFinal();

  entryHeight() =>
      isMultiHeight ? entryHeightMulti : resultHeightSk() - openedSizeFinal();

  entryHeightMultiUp() =>
      height - entryHeight() - sk - totalSk() - openedSizeFinal();

  entryWidthMultiRight() => entryWidthMulti;
  resultWidthShutter() =>
      (entryWidth() + shutterWidthDeductFinal()) / widthShutterLength;

  resultWidthMultiHeightShutter() =>
      (entryWidth() + shutterWidthDeductFinal()) / widthMultiShutterLength;

  resultHeightMultiHeightShutter() =>
      (entryHeightMultiUp() + shutterWidthDeductFinal()) /
      heightMultiShutterLength;

  resultWidthMultiWidthShutter() =>
      (entryWidthMultiRight() + shutterWidthDeductFinal()) /
      widthMultiShutterLength;

  resultHeightMultiWidthShutter() =>
      (resultHeightSk() + shutterWidthDeductFinal()) / heightMultiShutterLength;

  resultWidthDrawerShutter() => (entryWidth() + shutterWidthDeductFinal());

  resultHeightShutter() {
    if (isDrawer && !withoutShutter)
      return (entryHeight() +
              shutterWidthDeductFinal() -
              (heightDrawer - .2) * drawerLength) /
          heightShutterLength;
    else if (isDrawer && withoutShutter)
      return ((entryHeight() + shutterWidthDeductFinal()) / drawerLength) - .2;
    else
      return (entryHeight() + shutterWidthDeductFinal()) / heightShutterLength;
  }

  resultWidthRack() {
    if (!isMultiWidth) {
      if (isDeepNearly) return resultWidthSk();
      if (isDeepRemotely && isBackIn) return resultWidthSk() + 3.5;
      if (isDeepRemotely && isBackOut) return resultWidthSk();
    } else {
      if (isDeepNearly) return resultWidthSk() - entryWidthMultiRight() - sk;
      if (isDeepRemotely && isBackIn)
        return resultWidthSk() + 3.5 - entryWidthMultiRight() - sk;
      if (isDeepRemotely && isBackOut)
        return resultWidthSk() - entryWidthMultiRight() - sk;
    }
  }

  resultDeepRack() {
    if (isFixed) {
      if (isBackOut) return deep - sk;
      if (isBackIn && isDeepNearly) return deep - totalSk();
      if (isBackIn && isDeepRemotely) return deep - totalSk();
      if (isBackInOut) return deep - sk - 1.5;
    } else {
      if (isBackOut) return deep - .5;
      if (isBackIn && isDeepNearly) return deep - sk - .5;
      if (isBackIn && isDeepRemotely) return deep - totalSk();
      if (isBackInOut) return deep - 1.5;
    }
  }

  resultWidthDrawer() => isDrawer45 ? entryWidth() - 2.6 : entryWidth() - 6.6;

  resultDeepDrawer() => isDrawer45 ? resultDeepSk() : resultDeepSk() - 4;

  int shutterLength() => widthShutterLength * heightShutterLength;
  shutterMultiLength() => widthMultiShutterLength * heightMultiShutterLength;

  drawerMixColor1stLength() {
    switch (drawerLength) {
      case 1:
        return 1;
      case 2:
        return 1;
      case 3:
        return 2;
      case 4:
        return 2;
      case 5:
        return 3;
    }
  }

  drawerMixColor2ndLength() => drawerLength - drawerMixColor1stLength();

  resultDeepFixed() {
    if (isBackOut) return deep;
    if (isBackIn) return deep - sk;
    if (isBackInOut) return deep - 1;
  }

  resultWidthFixed() {
    if (isOpened || heightShutterLength > 1 || isMultiHeight || isWithTilt)
      return entryWidth();
    if (isFixed) return fixedWidth - sk;
  }

  resultHeightFixed() => resultHeightSk();
}
