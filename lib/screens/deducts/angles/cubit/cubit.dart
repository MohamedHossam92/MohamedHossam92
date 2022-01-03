import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/corner_data.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/irregular_angle_data.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/rotation_angle_data.dart';

class CornerCubit extends Cubit<CornerState> {
  CornerCubit() : super(InitState());

  double backLeft = 0, backRight = 0, deepLeft = 0, deepRight = 0, height = 0;
  double side1st = 60, side2nd = 80, water = 100, backAngle = 90;
  double leftSide = 0, rightSide = 0, bottomSide = 0;
  double rotationWater = 0, deep = 0;
  double barSize = 5;
  bool showResult = false, showBackAngle = false, isWithBar = false;
  List<CornerData> cornerList = [];
  List<CornerAngleData> cornerAngleList = [];
  List<RotationAngleData> rotateAngleList = [];
  List<IrregularAngleData> irregularAngleList = [];

  List<double> barSizeList = [3, 5, 5.4, 7];

  addNewCorner(CornerData c) {
    cornerList.clear();

    cornerList.add(c);

    emit(AddNewCorner());
  }

  clearLists() {
    cornerList.clear();
    rotateAngleList.clear();
    irregularAngleList.clear();
    backLeft = 0;
    backRight = 0;
    deepLeft = 0;
    deepRight = 0;
    rotationWater = 0;
    deep = 0;
    leftSide = 0;
    rightSide = 0;
    bottomSide = 0;
    showResult = false;
    showBackAngle = false;
    emit(ClearLists());
  }

  clearCornerAngle() {
    height = 0;
    side1st = 60;
    side2nd = 80;
    water = 100;
    backAngle = 90;
    emit(ClearCornerAngle());
  }

  addNewCornerBackAngle(CornerAngleData c) {
    if (cornerAngleList.isNotEmpty) {
      cornerAngleList.removeAt(0);
    }
    cornerAngleList.add(c);
    backAngle = c.backAngle();
    emit(AddNewCornerBackAngle());
  }

  addNewRotateAngle(RotationAngleData r) {
    if (rotateAngleList.isNotEmpty) {
      rotateAngleList.removeAt(0);
    }
    rotateAngleList.add(r);
    emit(AddNewRotateAngle());
  }

  barSizeChange(val) {
    barSize = val;
    emit(BarSizeChange());
  }

  addNewIrregularAngle(IrregularAngleData r) {
    if (irregularAngleList.isNotEmpty) {
      irregularAngleList.removeAt(0);
    }
    irregularAngleList.add(r);
    emit(AddNewIrregularAngle());
  }

  cornerSizesChange(int i, val) {
    if (val.length >= 2)
      switch (i) {
        case 0:
          backRight = double.parse(val);
          break;
        case 1:
          deepRight = double.parse(val);
          break;
        case 2:
          backLeft = double.parse(val);
          break;
        case 3:
          deepLeft = double.parse(val);
          break;
        case 4:
          height = double.parse(val);
          break;
      }
    emit(CornerSizesChange());
  }

  cornerBackAngleChange(int i, val) {
    switch (i) {
      case 0:
        side1st = double.parse(val);
        break;
      case 1:
        side2nd = double.parse(val);
        break;
      case 2:
        water = double.parse(val);
        break;
    }
    emit(CornerBackAngleChange());
  }

  irregularAngleChange(int i, val, context) {
    if (val.length >= 2) {
      if (i == 0) rightSide = double.parse(val);
      if (i == 1) leftSide = double.parse(val);

      if (leftSide >= rightSide) {
        ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
            title: 'يجب أن يكون الضلع (أ) أكبر من الضلع (ب)'));

        val = '${rightSide - 10}';
      }
      if (i == 1) leftSide = double.parse(val);

      if (i == 2) bottomSide = double.parse(val);
    }
    emit(IrregularAngleChange());
  }

  rotationChange(int i, val) {
    switch (i) {
      case 0:
        rotationWater = double.parse(val);
        break;
      case 1:
        deep = double.parse(val);
        break;
    }
    emit(RotationChange());
  }

  showResultChanged() {
    showResult = !showResult;
    emit(ShowResultChanged());
  }

  showAngleChanged() {
    showBackAngle = !showBackAngle;
    emit(ShowAngleChanged());
  }

  withBarChanged(val) {
    isWithBar = val;
    emit(WithBarChanged());
  }
}
