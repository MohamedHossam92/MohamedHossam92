class ShutterData {
  final double width, height;
  final double sliceSize, boxSize;
  final int length;
  final String sliceType;

  ShutterData(
      {required this.width,
      required this.height,
      required this.sliceSize,
      required this.boxSize,
      required this.length,
      required this.sliceType});

  boxWidth() => width - 1;
  boxCoverSize() => width - 1;
  streamSize() => height - boxSize + 5;
  sliceWidth() => width - 12;
  sliceLength() => ((height - .5 * boxSize) / sliceSize).round();
  underSize() => sliceWidth();
  xSize() => width - 7;
  supportLength() => (width / 40).round();
}
