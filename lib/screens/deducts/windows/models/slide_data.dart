class SlideData {
  final int id;
  final String windowsType;
  final double windowsWidth, windowsHeight;
  final int windowsLength;
  final bool isPVC;

  // عدد
  final int sashLength;

  // قيم التخصيم
  final double widthSashDeduct2,
      widthSashDeduct4,
      widthSashDeduct32,
      widthSashDeduct33;
  final double widthFlyScreenDeduct2,
      widthFlyScreenDeduct4,
      widthFlyScreenDeduct32,
      widthFlyScreenDeduct33;

  //
  final double heightSashDeduct, heightFluScreenDeduct;

  //
  final double heightHookDeduct, heightAdjoiningDeduct;
  final double widthGlassDeduct, heightGlassDeduct;

  // وزن القطاعات
  final double weightFrame,
      weightFrameWithoutBar,
      weightSash,
      weightFlyScreen,
      weightHook,
      weightAdjoining,
      weightFix,
      weightT,
      weightBead,
      weightBar,
      weightCollect;

  //الثوابت
  final bool isTopFixed, isBottomFixed, isRightFixed, isLeftFixed;
  final int topFixedLength,
      bottomFixedLength,
      rightFixedLength,
      leftFixedLength;

  final double topFixedSize, bottomFixedSize, rightFixedSize, leftFixedSize;

  final double? tSize, barDeduct, trackDeduct;
  final double fixSize, beadSize;

  SlideData({
    this.id = 0,
    required this.windowsType,
    required this.isPVC,
    required this.windowsWidth,
    required this.windowsHeight,
    required this.windowsLength,
    required this.sashLength,
    required this.widthSashDeduct2,
    required this.widthSashDeduct4,
    required this.widthSashDeduct32,
    required this.widthSashDeduct33,
    required this.widthFlyScreenDeduct2,
    required this.widthFlyScreenDeduct4,
    required this.widthFlyScreenDeduct32,
    required this.widthFlyScreenDeduct33,
    required this.heightSashDeduct,
    required this.heightFluScreenDeduct,
    required this.heightHookDeduct,
    required this.heightAdjoiningDeduct,
    required this.widthGlassDeduct,
    required this.heightGlassDeduct,
    required this.barDeduct,
    required this.trackDeduct,
    required this.weightFrame,
    required this.weightFrameWithoutBar,
    required this.weightSash,
    required this.weightFlyScreen,
    required this.weightHook,
    required this.weightAdjoining,
    required this.weightFix,
    required this.weightT,
    required this.weightBead,
    required this.weightBar,
    required this.weightCollect,
    required this.tSize,
    required this.fixSize,
    required this.beadSize,
    required this.isTopFixed,
    required this.isBottomFixed,
    required this.isRightFixed,
    required this.isLeftFixed,
    required this.topFixedLength,
    required this.bottomFixedLength,
    required this.rightFixedLength,
    required this.leftFixedLength,
    required this.topFixedSize,
    required this.bottomFixedSize,
    required this.rightFixedSize,
    required this.leftFixedSize,
  });

  finalWidth() => isRightFixed || isLeftFixed
      ? windowsWidth -
          (isRightFixed ? rightFixedSize : 0) -
          (isLeftFixed ? leftFixedSize : 0)
      : windowsWidth;
  finalHeight() => isTopFixed || isBottomFixed
      ? windowsHeight -
          (isTopFixed ? topFixedSize : 0) -
          (isBottomFixed ? bottomFixedSize : 0)
      : windowsHeight;
  //

//=================   الحلق   =================

  frameCuttingLength() => windowsLength * 2;

  // 0=3/2 ===== 1=3/3
  sashLengthFinal() => sashLength == 0 || sashLength == 1 ? 3 : sashLength;

  flyScreenLength() {
    if (sashLength == 0 || sashLength == 2) return 1;
    if (sashLength == 1 || sashLength == 4) return 2;
  }

  widthSashDeductFinal() {
    switch (sashLength) {
      case 0:
        return widthSashDeduct32;
      case 1:
        return widthSashDeduct33;
      case 2:
        return widthSashDeduct2;
      case 4:
        return widthSashDeduct4;
    }
  }

  widthFlyScreenDeductFinal() {
    switch (sashLength) {
      case 0:
        return widthFlyScreenDeduct32;
      case 1:
        return widthFlyScreenDeduct33;
      case 2:
        return widthFlyScreenDeduct2;
      case 4:
        return widthFlyScreenDeduct4;
    }
  }

//=================   الدرف   =================
  resultSashWidth() =>
      (finalWidth() + widthSashDeductFinal()) / sashLengthFinal();

  resultSashHeight() => finalHeight() + heightSashDeduct;

  sashCollectLength() => windowsLength * sashLengthFinal();

  sashCuttingLength() => sashCollectLength() * 2;

//=================   السلك   =================

  resultFlyScreenWidth() =>
      (finalWidth() + widthFlyScreenDeductFinal()) / sashLengthFinal();

  resultFlyScreenHeight() => finalHeight() + heightFluScreenDeduct;

  flyScreenCollectLength() => windowsLength * flyScreenLength();

  flyScreenCuttingLength() => flyScreenCollectLength() * 2;

  //=================   المكملات   =================

  resultHook() => finalHeight() + heightHookDeduct;

  hookCuttingLength() => windowsLength * flyScreenLength() * 2;

  resultAdjoining() => (finalHeight() + heightAdjoiningDeduct);

  //=================   الزجاج   =================
  widthGlass() => resultSashWidth() + widthGlassDeduct;

  heightGlass() => resultSashHeight() + heightGlassDeduct;
//=================   التراك   =================

  trackWidth() => windowsWidth + trackDeduct!;
}
