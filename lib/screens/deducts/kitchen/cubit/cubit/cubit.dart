import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';

class AddKitchenCubit extends Cubit<AddKitchenState> {
  AddKitchenCubit() : super(InitState());
  late double deductShutterFill;

  int unitId = -1, unitType = 0, imageId = 0;
  String unitName = '';
  double openedUnit = 0, fixed = 0, heightDrawerShutter = 0;

  double entryHeightMulti = 0, entryWidthMulti = 0;

  late double deductShutterFillDouble;

  bool is90 = false;

  bool isShutterGlass = false,
      isShutterDouble = false,
      isShutterPolyLac = false;
  bool isOnceColor = true, isMultiColor = false, isMixColor = false;
  bool isSize3_2 = false, isSize2_2 = false;
  String? selectedShutter, selectedColor;

  Map<String, List<double>> shutterName = {
    'ضبل عدل ': [.3, 7.5],
    'ضبل دوران': [1.5, 7.5],
    'درفة كلاسيك': [8, 0],
    'درفة نيوكلاسيك': [10.5, 0],
    'درفة استار': [10.5, 0],
    'درفة 8 سم': [13.5, 0],
    'درفة دورال': [16.5, 0],
    'درفة 7 سم': [14, 0],
    'درفة شبح': [8, 0],
    'درفة بولي لاك': [0, 0],
    'درفة سوري': [7.5, 0],
    'درفة 4سم': [8, 0]
  };

  void changeUnitData(int id, String name, int image) {
    unitId = id;
    unitName = name;
    imageId = image;
    imageId == 4102 || imageId == 4002 ? is90 = true : is90 = false;

    emit(ChangeUnitIdState());
  }

  void isSizeChanged(int i, val) {
    i == 0 ? isSize3_2 = true : isSize3_2 = false;
    i == 1 ? isSize2_2 = true : isSize2_2 = false;
    emit(IsSizeChangedState());
  }

  void isDrawerFixedOpenedChange(
      {bool isDrawer = false,
      bool isFixed = false,
      bool isOpen = false,
      bool isTilt = false,
      bool isMultiHeight = false,
      bool isMultiWidth = false,
      val}) {
    if (isDrawer) heightDrawerShutter = double.parse(val);
    if (isFixed) fixed = double.parse(val);
    if (isOpen || isTilt) openedUnit = double.parse(val);
    if (isMultiHeight) entryHeightMulti = double.parse(val);
    if (isMultiWidth) entryWidthMulti = double.parse(val);

    emit(IsDrawerFixedOpenedChangeState());
  }

  void unitTypeChange(val) {
    unitType = val;
    emit(UnitTypeChangeState());
  }

  void isSelectedShutterChange(val) {
    selectedShutter = val;

    val == 'ضبل عدل ' || val == 'ضبل دوران'
        ? isShutterDouble = true
        : isShutterDouble = false;
    val == 'درفة بولي لاك' ? isShutterPolyLac = true : isShutterPolyLac = false;

    deductShutterFill = shutterName[selectedShutter]![0];
    deductShutterFillDouble = shutterName[selectedShutter]![1];

    emit(IsSelectedShutterChangeState());
  }

  void isColorChange(i, val, selected) {
    List bool = [true, false, false, false];
    bool.fillRange(0, 4, false);
    bool.replaceRange(i, i + 1, [val]);
    isOnceColor = bool[0];
    isMultiColor = bool[1];
    isMixColor = bool[2];
    isShutterGlass = bool[3];
    selectedColor = selected;

    emit(IsColorChangeState());
  }

  void clearData() {
    is90 = false;
    emit(ClearDataState());
  }
}
