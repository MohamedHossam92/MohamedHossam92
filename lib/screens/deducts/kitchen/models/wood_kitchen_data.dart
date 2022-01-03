class WoodKitchenData {
  final int unitId, unitType, id, imageId;
  final String unitName;
  final double width, height, deep;
  final int widthShutterLength, heightShutterLength, rackLength, drawerLength;
  final double thickness, shutterDeduct, rackDeduct;
  final bool isUp, isOpened, isFixed, isWithTilt, isBasket;
  final double openedUnitHeight,
      fixedWidth,
      heightDrawerShutter,
      heightDrawerBody;
  final bool withoutShutter, isDrawer, isShutterGlass;
  final bool isShutterOnceColor, isShutterMultiColor, isShutterMixColor;
  //
  final bool isMultiHeight, isMultiWidth, isShutterWithDrawer;
  final double entryHeightMulti, entryWidthMulti;
  final int widthMultiShutterLength, heightMultiShutterLength;
  //

  WoodKitchenData({
    required this.id,
    required this.imageId,
    required this.unitId,
    required this.unitType,
    required this.unitName,
    required this.width,
    required this.height,
    required this.deep,
    required this.widthShutterLength,
    required this.heightShutterLength,
    required this.rackLength,
    required this.drawerLength,
    required this.thickness,
    required this.shutterDeduct,
    required this.rackDeduct,
    required this.isUp,
    required this.isOpened,
    required this.isFixed,
    required this.isWithTilt,
    required this.isBasket,
    required this.openedUnitHeight,
    required this.fixedWidth,
    required this.heightDrawerShutter,
    required this.heightDrawerBody,
    required this.withoutShutter,
    required this.isDrawer,
    required this.isShutterGlass,
    required this.isShutterOnceColor,
    required this.isShutterMultiColor,
    required this.isShutterMixColor,
    required this.isMultiHeight,
    required this.isMultiWidth,
    required this.isShutterWithDrawer,
    required this.entryHeightMulti,
    required this.entryWidthMulti,
    required this.widthMultiShutterLength,
    required this.heightMultiShutterLength,
  });

  thicknessCM() => thickness * .1;

  shutterDeductCM() => shutterDeduct * .1;

  totalThickness() => thicknessCM() * 2;

  resultWidth() => isUp ? width : width - totalThickness();

  resultHeight() => isUp ? height - totalThickness() : height;

  resultDeep() => deep;

  openedSizeFinal() =>
      isOpened || isWithTilt ? thicknessCM() + openedUnitHeight : 0;

  double fixedSizeFinal() => isFixed ? thicknessCM() + fixedWidth : 0;

  entryWidth() => isMultiWidth
      ? width -
          entryWidthMulti -
          totalThickness() -
          fixedSizeFinal() -
          thicknessCM()
      : width - totalThickness() - fixedSizeFinal();

  entryHeight() => isMultiHeight
      ? entryHeightMulti
      : height - totalThickness() - openedSizeFinal();

  entryHeightMultiUp() =>
      height -
      entryHeight() -
      thicknessCM() -
      totalThickness() -
      openedSizeFinal();

  entryWidthMultiRight() => entryWidthMulti;

  shutterDeductFinal() => isMultiWidth || isMultiHeight && !isOpened
      ? (thicknessCM() * 1.5) - shutterDeductCM()
      : totalThickness() - shutterDeductCM();

  resultWidthMultiHeightShutter() =>
      (entryWidth() + shutterDeductFinal()) / widthMultiShutterLength;

  resultHeightMultiHeightShutter() =>
      (entryHeightMultiUp() + shutterDeductFinal()) / heightMultiShutterLength;

  resultWidthMultiWidthShutter() =>
      (entryWidthMultiRight() + shutterDeductFinal()) / widthMultiShutterLength;

  resultHeightMultiWidthShutter() =>
      (height - totalThickness() + shutterDeductFinal()) /
      heightMultiShutterLength;

  resultWidthShutter() =>
      (entryWidth() + shutterDeductFinal()) / widthShutterLength;

  resultWidthDrawerShutter() => entryWidth() + shutterDeductFinal();

  resultHeightShutter() => isDrawer && withoutShutter
      ? ((entryHeight() + shutterDeductFinal()) / drawerLength) - .2
      : (entryHeight() +
              shutterDeductFinal() -
              (heightDrawerShutter * drawerLength)) /
          heightShutterLength;

  lShutter() => widthShutterLength * heightShutterLength;
  shutterMultiLength() => widthMultiShutterLength * heightMultiShutterLength;

  resultWidthRack() => isFixed ? entryWidth() + fixedSizeFinal() : entryWidth();

  resultDeepRack() => isOpened || isFixed ? deep - rackDeduct : deep - 2;

  resultWidthDrawer() => entryWidth() - 2.5 - totalThickness();

  resultDeepDrawer() => deep - 5;

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

  resultWidthBack() => width - 2;

  resultHeightBack() => height - 2;

  resultWidthDrawerBack() => resultWidthDrawer() + 1.2;

  resultDeepDrawerBack() => resultDeepDrawer() - 2;
}
