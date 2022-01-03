class MyShadeData {
  final double width, height;
  final int length;

  MyShadeData(this.width, this.height, this.length);

  firstWidth() => width - 13.5;
  otherWidth() => width - 12;
  firstHeight() => height - 6.5;
  otherHeight() => height - 6;
  splitLeather() => height / 5 * 2 + 2;
  area() => height * 2 + width;
  leather() => (area() + 10) * 2 * .01;
  aluminum() =>
      (firstWidth() +
          otherWidth() * 4 +
          firstHeight() * 2 +
          otherHeight() * 8) *
      length /
      550;
}
