import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_smart_workshop/sql/kitchen/cubit/state.dart';

class KitchenSettingCubit extends Cubit<KitchenSettingState> {
  KitchenSettingCubit() : super(InitState());

  bool isSk25 = true, isSk30 = false, isSk40 = false;
  double skSize = 2.5, deductShutter = 25, rackDeduct = 15;

  bool isWoodUp = true, isWoodDown = false;

  double woodThickness = 18, woodDeductShutter = 2;

  bool isDeepNearly = true, isDeepRemotely = false;
  bool isHeadCorner = false, isHeadDirect = true;
  bool isFaceUnit = false, isAllUnit = true;
  bool isBackOut = false, isBackIn = true, isBackInOut = false;
  bool isDrawer45 = false, isDrawer90 = true;
  bool isRaf25 = false, isRaf = true;
  double listLength = 8;
  double heightDrawerBody = 10;

  SharedPreferences? isSk25Prefs,
      isSk30Prefs,
      isSk40Prefs,
      skSizePrefs,
      deductShutterPrefs,
      rackDeductPrefs,
      isWoodUpPrefs,
      isWoodDownPrefs,
      woodThicknessPrefs,
      woodDeductShutterPrefs,
      isDeepNearlyPrefs,
      isDeepRemotelyPrefs,
      isHeadCornerPrefs,
      isHeadDirectPrefs,
      isFaceUnitPrefs,
      isAllUnitPrefs,
      isBackOutPrefs,
      isBackInPrefs,
      isBackInOutPrefs,
      isDrawer45Prefs,
      isDrawer90Prefs,
      isRaf25Prefs,
      isRafPrefs,
      listLengthPrefs;

  void isSkSizeChanged(double i, val) {
    i == 2.5 ? isSk25 = val : isSk25 = false;
    i == 3 ? isSk30 = val : isSk30 = false;
    i == 4 ? isSk40 = val : isSk40 = false;

    if (!val) isSk25 = true;

    skSize = i;

    saveUserType(isSk25Prefs, 'isSk25Prefs', isSk25);
    saveUserType(isSk30Prefs, 'isSk30Prefs', isSk30);
    saveUserType(isSk40Prefs, 'isSk40Prefs', isSk40);
    saveUserType(skSizePrefs, 'skSizePrefs', skSize, false);

    emit(IsSkChangedState());
  }

  isWoodUpChanged(val) {
    isWoodDown = !isWoodDown;

    isWoodUp = !isWoodUp;

    saveUserType(isWoodDownPrefs, 'isWoodDownPrefs', isWoodDown);
    saveUserType(isWoodUpPrefs, 'isWoodUpPrefs', isWoodUp);

    emit(IsWoodUpChangedState());
  }

  void isDeepSystemChanged(val) {
    isDeepRemotely = !isDeepRemotely;

    isDeepNearly = !isDeepNearly;
    if (isBackInOut) {
      isBackInOut = false;
      isBackIn = true;
    }

    saveUserType(isDeepRemotelyPrefs, 'isDeepRemotelyPrefs', isDeepRemotely);
    saveUserType(isDeepNearlyPrefs, 'isDeepNearlyPrefs', isDeepNearly);
    saveUserType(isBackOutPrefs, 'isBackOutPrefs', isBackInOut);
    saveUserType(isBackInPrefs, 'isBackInPrefs', isBackIn);

    emit(IsDeepChangedState());
  }

  void isHeadChanged(val) {
    isHeadCorner = !isHeadCorner;

    isHeadDirect = !isHeadDirect;

    saveUserType(isHeadCornerPrefs, 'isHeadCornerPrefs', isHeadCorner);
    saveUserType(isHeadDirectPrefs, 'isHeadDirectPrefs', isHeadDirect);

    emit(IsHeadChangedState());
  }

  void isFaceChanged(val) {
    isFaceUnit = !isFaceUnit;

    isAllUnit = !isAllUnit;

    isFaceUnit ? listLength = 4 : listLength = 8;
    saveUserType(isAllUnitPrefs, 'isAllUnitPrefs', isAllUnit, true);

    saveUserType(isFaceUnitPrefs, 'isFaceUnitPrefs', isFaceUnit);

    saveUserType(listLengthPrefs, 'listLengthPrefs', listLength, false);

    emit(IsFaceChangedState());
  }

  void isBackTypeChanged(i, val) {
    i == 0 ? isBackIn = val : isBackIn = false;
    i == 2 ? isBackOut = val : isBackOut = false;
    i == 1 ? isBackInOut = val : isBackInOut = false;

    if (!val) isBackIn = true;
    if (i == 1) {
      isDeepNearly = true;
      isDeepRemotely = false;
    }

    saveUserType(isDeepRemotelyPrefs, 'isDeepRemotelyPrefs', isDeepRemotely);
    saveUserType(isDeepNearlyPrefs, 'isDeepNearlyPrefs', isDeepNearly);
    saveUserType(isBackOutPrefs, 'isBackOutPrefs', isBackInOut);
    saveUserType(isBackInPrefs, 'isBackInPrefs', isBackIn);
    saveUserType(isBackInOutPrefs, 'isBackInOutPrefs', isBackInOut);

    emit(IsBackTypeChangedState());
  }

  void isDrawerChange(val) {
    isDrawer45 = !isDrawer45;

    isDrawer90 = !isDrawer45;
    saveUserType(isDrawer45Prefs, 'isDrawer45Prefs', isDrawer45);
    saveUserType(isDrawer90Prefs, 'isDrawer90Prefs', isDrawer90);
    emit(IsDrawerChangeState());
  }

  isRackChange(val) {
    isRaf = !isRaf;

    isRaf25 = !isRaf25;

    saveUserType(isRafPrefs, 'isRafPrefs', isRaf);
    saveUserType(isRaf25Prefs, 'isRaf25Prefs', isRaf25);
    emit(IsRackChangeState());
  }

  void isShutterDeduct(val) {
    deductShutter = val;
    saveUserType(
        deductShutterPrefs, 'deductShutterPrefs', deductShutter, false);

    emit(IsShutterDeductState());
  }

  void isWoodShutterDeduct(val) {
    woodDeductShutter = val;
    saveUserType(woodDeductShutterPrefs, 'woodDeductShutterPrefs',
        woodDeductShutter, false);

    emit(IsWoodShutterDeductState());
  }

  void woodDetailsChange(i, val) {
    if (i == 0) heightDrawerBody = val;

    if (i == 1) woodThickness = val;
    if (i == 2) rackDeduct = val;
    if (i == 3) woodDeductShutter = val;

    saveUserType(
        woodThicknessPrefs, 'woodThicknessPrefs', woodThickness, false);
    saveUserType(rackDeductPrefs, 'deductShutterPrefs', rackDeduct, false);
    saveUserType(woodDeductShutterPrefs, 'woodDeductShutterPrefs',
        woodDeductShutter, false);
    emit(WoodDetailsChange());
  }

  Future<void> saveUserType(SharedPreferences? prefs, String prefsName, val,
      [bool isBool = true]) async {
    prefs = await SharedPreferences.getInstance();
    isBool ? prefs.setBool(prefsName, val) : prefs.setDouble(prefsName, val);
    await getAllPrefs();
  }

  getAllPrefs() async {
    isSk25Prefs = await SharedPreferences.getInstance();
    isSk25 = isSk25Prefs!.getBool('isSk25Prefs') ?? isSk25;
    isSk30Prefs = await SharedPreferences.getInstance();
    isSk30 = isSk30Prefs!.getBool('isSk30Prefs') ?? isSk30;
    isSk40Prefs = await SharedPreferences.getInstance();
    isSk40 = isSk40Prefs!.getBool('isSk40Prefs') ?? isSk40;
    skSizePrefs = await SharedPreferences.getInstance();
    skSize = skSizePrefs!.getDouble('skSizePrefs') ?? skSize;
    isWoodDownPrefs = await SharedPreferences.getInstance();
    isWoodDown = isWoodDownPrefs!.getBool('isWoodDownPrefs') ?? isWoodDown;
    isWoodUpPrefs = await SharedPreferences.getInstance();
    isWoodUp = isWoodUpPrefs!.getBool('isWoodUpPrefs') ?? isWoodUp;

    isDeepRemotelyPrefs = await SharedPreferences.getInstance();
    isDeepRemotely =
        isDeepRemotelyPrefs!.getBool('isDeepRemotelyPrefs') ?? isDeepRemotely;
    isDeepNearlyPrefs = await SharedPreferences.getInstance();
    isDeepNearly =
        isDeepNearlyPrefs!.getBool('isDeepNearlyPrefs') ?? isDeepNearly;
    isBackOutPrefs = await SharedPreferences.getInstance();
    isBackInOut = isBackOutPrefs!.getBool('isBackOutPrefs') ?? isBackInOut;
    isBackInPrefs = await SharedPreferences.getInstance();
    isBackIn = isBackInPrefs!.getBool('isBackInPrefs') ?? isBackIn;

    isHeadCornerPrefs = await SharedPreferences.getInstance();
    isHeadCorner =
        isHeadCornerPrefs!.getBool('isHeadCornerPrefs') ?? isHeadCorner;
    isHeadDirectPrefs = await SharedPreferences.getInstance();
    isHeadDirect =
        isHeadDirectPrefs!.getBool('isHeadDirectPrefs') ?? isHeadDirect;
    isAllUnitPrefs = await SharedPreferences.getInstance();
    isAllUnit = isAllUnitPrefs!.getBool('isAllUnitPrefs') ?? isAllUnit;
    isFaceUnitPrefs = await SharedPreferences.getInstance();
    isFaceUnit = isFaceUnitPrefs!.getBool('isFaceUnitPrefs') ?? isFaceUnit;
    listLengthPrefs = await SharedPreferences.getInstance();
    listLength = listLengthPrefs!.getDouble('listLengthPrefs') ?? listLength;
    isBackInOutPrefs = await SharedPreferences.getInstance();
    isBackInOut = isBackInOutPrefs!.getBool('isBackInOutPrefs') ?? isBackInOut;
    isDrawer45Prefs = await SharedPreferences.getInstance();
    isDrawer45 = isDrawer45Prefs!.getBool('isDrawer45Prefs') ?? isDrawer45;
    isDrawer90Prefs = await SharedPreferences.getInstance();
    isDrawer90 = isDrawer90Prefs!.getBool('isDrawer90Prefs') ?? isDrawer90;
    isRafPrefs = await SharedPreferences.getInstance();
    isRaf = isRafPrefs!.getBool('isRafPrefs') ?? isRaf;
    isRaf25Prefs = await SharedPreferences.getInstance();
    isRaf25 = isRaf25Prefs!.getBool('isRaf25Prefs') ?? isRaf25;

    deductShutterPrefs = await SharedPreferences.getInstance();
    deductShutter =
        deductShutterPrefs!.getDouble('deductShutterPrefs') ?? deductShutter;

    woodDeductShutterPrefs = await SharedPreferences.getInstance();
    woodDeductShutter =
        woodDeductShutterPrefs!.getDouble('woodDeductShutterPrefs') ??
            woodDeductShutter;
    woodThicknessPrefs = await SharedPreferences.getInstance();
    woodThickness =
        woodThicknessPrefs!.getDouble('woodThicknessPrefs') ?? woodThickness;
    rackDeductPrefs = await SharedPreferences.getInstance();
    rackDeduct = rackDeductPrefs!.getDouble('rackDeductPrefs') ?? rackDeduct;

    emit(GetAllPrefs());
  }
}
