class MaterialList {
  final String size;
  final String length;

  MaterialList({required this.size, required this.length});
}

class SizeAndLength {
  final double size;
  final int length;

  SizeAndLength({required this.size, required this.length});
}

class Size2AndLength {
  final double size1, size2;
  final int length;

  Size2AndLength(
      {required this.size1, required this.size2, required this.length});
}

class ResultData {
  final bool i2, i4;
  final String title;
  final List list;
  ResultData(this.title, this.list, [this.i2 = false, this.i4 = false]);
}
