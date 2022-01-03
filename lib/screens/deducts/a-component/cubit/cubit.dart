import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';

import '../../a-component/cubit/state.dart';
import '../result_home.dart';
import 'class.dart';

class ComponentCubit extends Cubit<ComponentState> {
  ComponentCubit() : super(InitDeductState());

  int length = 1, id = 0;
  int sashLength = 2;
  bool isPanda = false;
  late double keyboardDouble;

  int expansionIndex = -1, pageIndex = 0;
  double width = 100, height = 100, deep = 50;
  late double windowsPrice;
  bool isDeduct = true, isZ = false, isFexFrame = false;
  bool isLengthHide = false;
  String? selectedBar, selectedZ;
  String? selectedPVCBar, selectedPVCZ;
  late SharedPreferences prefsId;

  double? barSize;
  double? tSize, underSize;

  late int fixedChoose = 0;

  int barGroupVal = -1, zGroupVal = -1;

  groupValChange(int i, val) {
    if (i == 0) {
      barGroupVal = val;
      if (val == 1) isFexFrame = true;
    }
    if (i == 1) {
      zGroupVal = val;
      if (val == 0) isZ = true;
    }

    emit(SelectedTurnSystemChange());
  }

  List<bool> isSuction = [false, false, false, false];
  List<String?> suctionPlace = [null, null, null, null];
  List<double?> suctionSize = [null, null, null, null];

  isSuctionChange(i, val) {
    isSuction.replaceRange(i, i + 1, [val]);
    emit(IsSuctionState());
  }

  suctionSizeChange(i, val) {
    suctionSize.replaceRange(i, i + 1, [val]);
    emit(IsSuctionState());
  }

  resultDataListChange(List<ResultData> list) {
    resultDataList = list;
    emit(ResultDataListState());
  }

  suctionPlaceChange(i, val) {
    suctionPlace.replaceRange(i, i + 1, [val]);
    emit(IsSuctionState());
  }

  bool isTopFixed = false,
      isBottomFixed = false,
      isRightFixed = false,
      isLeftFixed = false;

  int topFixedLength = 0,
      bottomFixedLength = 0,
      rightFixedLength = 0,
      leftFixedLength = 0;

  double topFixedSize = 30,
      bottomFixedSize = 30,
      rightFixedSize = 30,
      leftFixedSize = 30;

  bool isSashFixed = false, isWithoutUnder = false;
  late double sashFixedSize = 40;

  List<double> barSizeList = [3, 4, 5, 5.4, 5.8, 7];
  List<double> tSizeList = [3.2, 4, 4.6, 6.7, 10.7, 13.7];
  List<double> underSizeList = [5.1, 8.6, 11.1, 12.6, 15.6];
  List<double> suctionSizeList = [25, 30, 35, 40];
  List<String> suctionPlaceList = ['في زاوية', 'في المنتصف'];

  centerWidthSize() =>
      width -
      (isRightFixed ? rightFixedSize : 0) -
      (isLeftFixed ? leftFixedSize : 0);

  centerHeightSize() =>
      height -
      (isTopFixed ? topFixedSize : 0) -
      (isBottomFixed ? bottomFixedSize : 0);

  sashHeightSizeWithFixed() =>
      height -
      15 -
      (isSashFixed ? sashFixedSize : 0) -
      (isTopFixed ? topFixedSize : 0) -
      (isBottomFixed ? bottomFixedSize : 0);

  void sashLengthChange(int i, bool isSlide) {
    i == 3 && isSlide ? sashLength = 4 : sashLength = i;
    emit(IsSashLengthState());
  }

  void isPandaChoose(bool val) {
    isPanda = val;
    emit(IsPandaState());
  }

  fixedChooseChange(int i) {
    fixedChoose = i;
    emit(FixedChooseState());
  }

  fixedState(i, val, context) {
    if ((i == 1 || i == 0) && centerHeightSize() >= (!val ? 20 : 80)) {
      switch (i) {
        case 0:
          isTopFixed = val;
          if (!val && isSuction[i]) {
            isSuction.replaceRange(i, i + 1, [false]);
          }
          break;
        case 1:
          if (isWithoutUnder) {
            ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
                icon: Icons.error_outline_rounded,
                title: 'لا يمكن اضافة ثابت سفلي مع حلق بدون جلسة.'));
          } else
            isBottomFixed = val;
          if (!val && isSuction[i]) {
            isSuction.replaceRange(i, i + 1, [false]);
          }
          break;
      }
    } else if ((i == 3 || i == 2) && centerWidthSize() >= (!val ? 20 : 80)) {
      switch (i) {
        case 2:
          isRightFixed = val;
          if (!val && isSuction[i]) {
            isSuction.replaceRange(i, i + 1, [false]);
          }
          break;
        case 3:
          isLeftFixed = val;
          if (!val && isSuction[i]) {
            isSuction.replaceRange(i, i + 1, [false]);
          }
          break;
      }
    } else if (sashHeightSizeWithFixed() >= (!val ? 20 : 80) && i == 4) {
      isSashFixed = val;
    } else if (i == 5) {
      if (!isBottomFixed)
        isWithoutUnder = val;
      else
        ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
            icon: Icons.error_outline_rounded,
            title: 'لا يمكن إلغاء الجلسة مع حلق له ثابت سفلي.'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
          icon: Icons.error_outline_rounded,
          title: 'مساحة الشباك لا تسمح بإضافة ثابت.'));
    }

    emit(FixedStateChange());
  }

  fixedSize(i, String val, context) {
    if (val.length >= 2) {
      switch (i) {
        case 0:
          topFixedSize = double.parse(val);
          break;
        case 1:
          bottomFixedSize = double.parse(val);
          break;
        case 2:
          rightFixedSize = double.parse(val);
          break;
        case 3:
          leftFixedSize = double.parse(val);
          break;
        case 4:
          sashFixedSize = double.parse(val);
          break;
      }

      if (centerWidthSize() < 40 ||
          centerHeightSize() < 40 ||
          sashHeightSizeWithFixed() < 40) {
        ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
            icon: Icons.error_outline_rounded,
            title: 'مساحة الشباك لا تسمح بهذا المقاس.'));
        val = '40';

        switch (i) {
          case 0:
            topFixedSize = double.parse(val);
            break;
          case 1:
            bottomFixedSize = double.parse(val);
            break;
          case 2:
            rightFixedSize = double.parse(val);
            break;
          case 3:
            leftFixedSize = double.parse(val);
            break;
          case 4:
            sashFixedSize = double.parse(val);
            break;
        }
      }
    }

    emit(FixedSizeChange());
  }

  incrementFixedLength(i) {
    switch (i) {
      case 0:
        topFixedLength++;
        break;
      case 1:
        bottomFixedLength++;
        break;
      case 2:
        rightFixedLength++;
        break;
      case 3:
        leftFixedLength++;
        break;
    }

    emit(IncrementFixedLength());
  }

  decrementFixedLength(i) {
    switch (i) {
      case 0:
        topFixedLength--;
        break;
      case 1:
        bottomFixedLength--;
        break;
      case 2:
        rightFixedLength--;
        break;
      case 3:
        leftFixedLength--;
        break;
    }

    emit(DecrementFixedLength());
  }

  autoFixedLength(i, val) {
    switch (i) {
      case 0:
        topFixedLength = suctionPlaceList.indexOf(val) + 1;
        break;
      case 1:
        bottomFixedLength = suctionPlaceList.indexOf(val) + 1;
        break;
      case 2:
        rightFixedLength = suctionPlaceList.indexOf(val) + 1;
        break;
      case 3:
        leftFixedLength = suctionPlaceList.indexOf(val) + 1;
        break;
    }

    emit(AutoFixedLength());
  }

  double windowsArea() {
    double area = width * height * .0001;
    return area < 1 ? 1 : area;
  }

  double oncePrice() => windowsArea() * windowsPrice;

  double totalPrice() => oncePrice() * length;

  double totalArea() => windowsArea() * length;

  void isDeductChange() {
    isDeduct = !isDeduct;

    emit(IsDeductChangeState());
  }

  void incrementWindowsList() {
    length++;
    emit(IncrementWindowsListState());
  }

  Future<void> saveId(int id) async {
    prefsId = await SharedPreferences.getInstance();
    prefsId.setInt('id', id);
  }

  getId() async {
    prefsId = await SharedPreferences.getInstance();
    id = prefsId.getInt('id') ?? id;
    emit(GetId());
  }

  void incrementId() {
    id++;
    saveId(id);
    getId();

    emit(IncrementIdState());
  }

  void decrementWindowsList(i) {
    if (length > i) length--;
    emit(DecrementWindowsListState());
  }

  void pageIndexChange(i) {
    pageIndex = i;
    emit(PageIndexChange());
  }

  void expansionIndexChange(int i) {
    expansionIndex == i ? expansionIndex = -1 : expansionIndex = i;

    emit(ExpansionIndexChangeState());
  }

  void sizeChange(int i, String val) {
    if (val.length >= 2 && val != '10')
      switch (i) {
        case 0:
          width = double.parse(val);
          break;
        case 1:
          height = double.parse(val);
          break;
        case 2:
          deep = double.parse(val);
          break;
      }

    emit(SizeChangeState());
  }

  void priceChange(String val) {
    windowsPrice = double.parse(val);
    emit(PriceChangeState());
  }

  void priceValueChange(int val, bool isLengthHidden) {
    length = val;
    isLengthHidden ? isLengthHide = true : isLengthHide = false;
    emit(PriceValueChangeState());
  }

  void restWindowsLength() {
    length = 1;

    emit(RestWindowsLengthState());
  }

  void clearData() {
    length = 1;
    expansionIndex = -1;
    isDeduct = true;

    emit(ClearDataState());
  }

  barSizeChange(i, val) {
    if (i == 0) barSize = val;
    if (i == 1) tSize = val;
    if (i == 2) underSize = val;
    emit(BarSizeChange());
  }

  void clearFixedData() {
    isSashFixed = false;
    isTopFixed = false;
    isBottomFixed = false;
    isRightFixed = false;
    isLeftFixed = false;

    topFixedLength = 1;
    bottomFixedLength = 1;
    rightFixedLength = 1;
    leftFixedLength = 1;

    topFixedSize = 40;
    bottomFixedSize = 40;
    rightFixedSize = 40;
    leftFixedSize = 40;
    sashFixedSize = 40;

    emit(ClearFixedData());
  }
}
