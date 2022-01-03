class FixedData {
  final double size1, size2, fixSize;
  final double? tSize, suctionSize;
  final int length, tLength;
  final bool isV, isH, isTilt;
  final double beadSize;

  FixedData(
      {required this.size1,
      required this.size2,
      required this.tSize,
      required this.suctionSize,
      required this.tLength,
      required this.fixSize,
      required this.length,
      required this.beadSize,
      this.isV = false,
      this.isH = false,
      this.isTilt = false});

  totalTSize() => tSize! * tLength;
  totalFixedSize() => fixSize * 2;

  cutTSize() => isH ? size2 - totalFixedSize() : size1 - totalFixedSize();

  cutTFrameSize() => isH ? size1 : size2;

  widthGlass() => isH
      ? ((size1 -
                  totalFixedSize() -
                  totalTSize() -
                  (isTilt ? suctionSize! : 0)) /
              (tLength + (isTilt ? 0 : 1))) -
          .5
      : size1 - totalFixedSize() - .5;
  heightGlass() => isV
      ? ((size2 -
                  totalFixedSize() -
                  totalTSize() -
                  (isTilt ? suctionSize! : 0)) /
              (tLength + (isTilt ? 0 : 1))) -
          .5
      : size2 - totalFixedSize() - .5;
}
