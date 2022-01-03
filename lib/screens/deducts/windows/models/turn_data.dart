class TurnData {
  final int id;
  final String windowsType;
  final int windowsLength, sashLength;
  final double windowsWidth,
      windowsHeight,
      deductFrameWithBar,
      deductFrameWithFex,
      deductLargeZ,
      deductSmallZ,
      deductTCenter,
      bead,
      fixedSize;

  double? tSize, underSize;

  final double sash1Deduct, sash2Deduct, sashHeightDeduct, barDeduct;

  final bool isPanda, isLargeZ, isFexFrame, isPVC, isTilt;

  //الثوابت
  final bool isTopFixed, isBottomFixed, isRightFixed, isLeftFixed;
  final int topFixedLength,
      bottomFixedLength,
      rightFixedLength,
      leftFixedLength;
  final bool isWithoutUnder, isSashFixed;
  final double topFixedSize, bottomFixedSize, rightFixedSize, leftFixedSize;

  TurnData({
    required this.id,
    required this.windowsType,
    required this.windowsLength,
    required this.windowsWidth,
    required this.windowsHeight,
    required this.deductFrameWithBar,
    required this.deductFrameWithFex,
    required this.deductLargeZ,
    required this.deductSmallZ,
    required this.deductTCenter,
    required this.sash1Deduct,
    required this.sash2Deduct,
    required this.sashHeightDeduct,
    required this.barDeduct,
    required this.tSize,
    required this.underSize,
    required this.bead,
    required this.fixedSize,
    required this.sashLength,
    required this.isPanda,
    required this.isSashFixed,
    required this.isWithoutUnder,
    required this.isLargeZ,
    required this.isPVC,
    required this.isTilt,
    required this.isFexFrame,
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

  sashDeducts() =>
      [sash1Deduct, sash2Deduct, 0, -((sash1Deduct + sash2Deduct) / 2)];

  // deduct1Sash() => isPVC ? 1.6 : 1.2;
  //
  // deduct2Sash() => isPVC ? 1.6 : .6;

  tSizeFinal() => isSashFixed ? tSize : 0;

  entryWidthFrame() => isFexFrame
      ? windowsWidth - (deductFrameWithFex * 2)
      : windowsWidth - (deductFrameWithBar * 2);

  entryWidthWithFex() =>
      entryWidthFrame() -
      (isRightFixed ? rightFixedSize + tSize! : 0) -
      (isLeftFixed ? leftFixedSize + tSize! : 0);

  entryHeightFrame() => isFexFrame
      ? windowsHeight - (deductFrameWithFex * (isWithoutUnder ? 1 : 2))
      : windowsHeight - (deductFrameWithBar * (isWithoutUnder ? 1 : 2));

  entryHeightWithFex() =>
      entryHeightFrame() -
      (isTopFixed ? topFixedSize + tSize! : 0) -
      (isBottomFixed ? bottomFixedSize + tSize! : 0) -
      (isTilt ? tSize! * (sashLength - 1) : 0);

  tCenterSize() =>
      resultHeightSash() + (deductTCenter / (isWithoutUnder ? 2 : 1));

  resultWidthSash() =>
      (entryWidthWithFex() +
          (isTilt ? sashHeightDeduct : sashDeducts()[sashLength - 1])) /
      (isTilt ? 1 : sashLength);

  resultHeightSash() =>
      (entryHeightWithFex() / (isTilt ? sashLength : 1)) +
      (isWithoutUnder ? 0 : sashHeightDeduct);

  entryWidthSash() => isLargeZ
      ? resultWidthSash() - (deductLargeZ * 2)
      : resultWidthSash() - (deductSmallZ * 2);

  entryHeightSash() => isLargeZ
      ? resultHeightSash() -
          (deductLargeZ * (isWithoutUnder ? 1 : 2)) -
          (isSashFixed ? fixedSize + tSize! : 0) -
          (isWithoutUnder ? underSize : 0)
      : resultHeightSash() -
          (deductSmallZ * (isWithoutUnder ? 1 : 2)) -
          (isSashFixed ? fixedSize + tSize! : 0) -
          (isWithoutUnder ? underSize : 0);

  resultWidthPanda() => entryWidthSash() + sashDeducts()[0];

  resultHeightPanda() => entryHeightSash() + sashHeightDeduct;

  entryWidthPanda() => resultWidthPanda() - (deductSmallZ * 2);

  entryHeightPanda() => resultHeightPanda() - (deductSmallZ * 2);

  widthSashGlass() => isPanda ? entryWidthPanda() - .5 : entryWidthSash() - .5;

  heightSashGlass() =>
      isPanda ? entryHeightPanda() - .5 : entryHeightSash() - .5;

  widthFixedGlass() => entryWidthSash() - .5;

  heightFixedGlass() => fixedSize - .5;

  widthSashBead() => isPanda ? entryWidthPanda() : entryWidthSash();

  heightSashBead() => isPanda
      ? entryHeightPanda() - (bead * 2)
      : entryHeightSash() - (bead * 2);

  widthFixedBead() => entryWidthSash();

  heightFixedBead() => fixedSize - (bead * 2);

  totalSashLength() => windowsLength * sashLength;

  sashLengthCutting([bool isUnder = false]) =>
      totalSashLength() * (isUnder ? 1 : 2);

  frameLengthCutting([bool isUnder = false]) =>
      windowsLength * (isUnder ? 1 : 2);
}
