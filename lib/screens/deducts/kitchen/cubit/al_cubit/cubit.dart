import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/class.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/corner_data.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/al_kitchen_data.dart';

class KitchenCubit extends Cubit<KitchenState> {
  KitchenCubit() : super(InitState());

  List<dynamic> listOfUnits = [];
  List<AluminiumKitchenData> unitsList = [];
  List<CornerData> cornerUnits = [];
  //================ تجميع ==================

  List<Size2AndLength> fixedCollectList = [];
  List<Size2AndLength> shutterCollect1stColorList = [];
  List<Size2AndLength> shutterCollect2ndColorList = [];
  List<Size2AndLength> shutterGlassCollectList = [];
  List<Size2AndLength> rackCollectList = [];
  List<Size2AndLength> drawerCollectList = [];
  List<Size2AndLength> basketCollectList = [];

//================ ألومنيوم ==================
  List<SizeAndLength> nearlyList = [];
  List<SizeAndLength> remotelyList = [];
  List<SizeAndLength> onceSKList = [];
  List<SizeAndLength> cornerSKList = [];
  /////////////////
  //////////////////////////
  List<SizeAndLength> onceSK45List = [];
  List<SizeAndLength> drawerList = [];
  List<SizeAndLength> basketList = [];
  List<SizeAndLength> slideTrackList = [];

  List<SizeAndLength> rackList = [];
  List<SizeAndLength> shutter1stColorList = [];
  List<SizeAndLength> shutter2ndColorList = [];
  List<SizeAndLength> shutterGlassList = [];
//================ فايبر ==================
  List<Size2AndLength> fillBackList = [];
  List<Size2AndLength> fillInList = [];
  List<Size2AndLength> fillRackList = [];
  List<Size2AndLength> fillDrawerList = [];
  List<Size2AndLength> fillFixedList = [];
  List<Size2AndLength> shutter1stFillList = [];
  List<Size2AndLength> shutter2ndFillList = [];
  List<Size2AndLength> shutterDoubleFillList = [];
//================ زجاج ==================
  List<Size2AndLength> glassShutter = [];

  Map<double, List> collectSK = {};
  List<CollectSKData> collectSKList = [];

  Map<double, List> collectShutter = {};
  List<CollectSKData> collectShutterList = [];

  int totalHing = 0,
      totalDrawer = 0,
      shutterLength = 0,
      hingeLength = 0,
      totalDrawerUnit = 0,
      totalTilt = 0,
      totalRack = 0,
      totalFixed = 0,
      totalLowerUnit = 0,
      slideBike = 0,
      basketLength = 0;
  double fillSize = 1,
      fillShutter1Size = 1,
      fillShutter2Size = 1,
      fillShutterDoubleSize = 1,
      frontSize = 80,
      underSize = 120;
  double nearlyCorner = 0, remotelyCorner = 0, skCorner = 0, rackCorner = 0;

  void insertUnitToList(AluminiumKitchenData k) {
    unitsList.insert(0, k);
    listOfUnits.insert(0, k);

    emit(InsertUnitToListState());
  }

  void insertCornerUnitToList(CornerData c) {
    cornerUnits.insert(0, c);
    listOfUnits.insert(0, c);
    emit(InsertCornerUnitToListState());
  }

  addItemsToList() {
    clearLists(false);

    //=============================== الركنة =============================
    for (var c in cornerUnits) {
      double sk = c.totalSk();
      if (c.backAngle == 90) {
        nearlyList.addAll([
          SizeAndLength(
              size: c.isHeadCorner ? c.height : c.height - sk,
              length: c.unitType == 0 ? 1 : 2),
          SizeAndLength(
              size: c.isHeadCorner ? c.width : c.width - sk,
              length: c.unitType == 0 ? 1 : 2),
        ]);
        rackList.addAll([
          SizeAndLength(size: c.width - sk, length: c.rackLength),
          SizeAndLength(size: c.height - sk, length: c.rackLength),
        ]);
      } else {
        nearlyCorner += c.height * (c.unitType == 0 ? 1 : 2);

        nearlyCorner += c.width * (c.unitType == 0 ? 1 : 2);
        rackCorner += (c.height + c.width) * c.rackLength;
      }

      if (c.is90) {
        onceSKList
            .addAll([SizeAndLength(size: c.entryWidth() - sk, length: 2)]);
        onceSKList.addAll(
            [SizeAndLength(size: c.height - c.deepLeft - sk / 2, length: 2)]);
      }

      if (c.backAngle == 90 && c.unitType == 0) {
        nearlyList.addAll([
          SizeAndLength(
              size: c.isHeadCorner ? c.height : c.height - sk, length: 1),
          SizeAndLength(
              size: c.isHeadCorner ? c.width : c.width - sk, length: 1),
        ]);
      } else {
        skCorner += c.height * 1;
        skCorner += c.width * 1;
      }
      nearlyList.add(SizeAndLength(
          size: c.isHeadCorner ? c.cornerHeight : c.cornerHeight - sk,
          length: c.isDeepNearly && !c.isEnd ? 3 : 1));

      if (c.isDeepRemotely && !c.isEnd)
        remotelyList.add(SizeAndLength(
            size: c.isHeadCorner ? c.cornerHeight : c.cornerHeight - sk,
            length: 2));

      if (c.isEnd)
        onceSKList.add(SizeAndLength(
            size: c.isHeadCorner ? c.cornerHeight : c.cornerHeight - sk,
            length: 2));

      if (!c.isEnd)
        cornerSKList.add(SizeAndLength(size: c.cornerHeight - sk, length: 2));

      if (c.isDeepRemotely) {
        remotelyCorner += c.deepLeft * (c.unitType == 0 ? 1 : 2) +
            c.deepRight * (c.unitType == 0 ? 1 : 2);
      }
      if (c.isDeepNearly) {
        nearlyCorner += c.deepLeft * (c.unitType == 0 ? 1 : 2) +
            c.deepRight * (c.unitType == 0 ? 1 : 2);
      }
      if (c.unitType == 0) {
        skCorner += c.deepLeft;
        skCorner += c.deepRight;
      }
      rackCorner += (c.deepLeft + c.deepRight + c.frontSide()) * c.rackLength;
      skCorner += c.frontSide() * 2;

      fillBackList.addAll([
        Size2AndLength(
            size1: c.width - sk, size2: c.cornerHeight - sk, length: 1),
        Size2AndLength(
            size1: c.height - sk, size2: c.cornerHeight - sk, length: 1)
      ]);

      fillInList.addAll([
        if (!c.is90)
          Size2AndLength(
              size1: c.height - sk + (c.backAngle > 90 ? c.fillPlus() : 0),
              size2: c.width - sk,
              length: c.unitType == 0 ? 1 : 2),
        if (c.is90)
          Size2AndLength(
              size1: c.width - sk,
              size2: c.deepLeft - sk + (c.backAngle > 90 ? c.fillPlus() : 0),
              length: c.unitType == 0 ? 1 : 2),
        if (c.is90)
          Size2AndLength(
              size1: c.deepRight - sk,
              size2: c.height - c.deepLeft - sk / 2,
              length: c.unitType == 0 ? 1 : 2),
        if (!c.isEnd)
          Size2AndLength(
              size1: c.deepRight - (sk / 2),
              size2: c.cornerHeight - sk,
              length: 1),
        if (!c.isEnd)
          Size2AndLength(
              size1: c.deepLeft - (sk / 2),
              size2: c.cornerHeight - sk,
              length: 1),
      ]);
      fillRackList.add(Size2AndLength(
          size1: c.height +
              (c.backAngle > 90 ? c.fillPlus() : 0) -
              sk -
              (c.isRack25 ? 5 : .5),
          size2: c.width - sk - (c.isRack25 ? 5 : .5),
          length: c.rackLength));

      //===============    الدرف    ============

      if (!c.isShutterPolyLac && !c.isShutterGlass && !c.isEnd) {
        if (c.isShutterOnceColor || c.isShutterMixColor) {
          shutterCollect1stColorList.addAll([
            Size2AndLength(
                size1: c.is90
                    ? c.right90widthShutter()
                    : c.resultWidthShutter() / c.shutterLength,
                size2: c.resultHeightShutter(),
                length: c.shutterLength),
            if (c.is90)
              Size2AndLength(
                  size1: c.left90widthShutter(),
                  size2: c.resultHeightShutter(),
                  length: 1),
          ]);
        }
        if (c.isShutterMultiColor) {
          shutterCollect2ndColorList.addAll([
            Size2AndLength(
                size1: c.is90
                    ? c.right90widthShutter()
                    : c.resultWidthShutter() / c.shutterLength,
                size2: c.resultHeightShutter(),
                length: c.shutterLength),
            if (c.is90)
              Size2AndLength(
                  size1: c.left90widthShutter(),
                  size2: c.resultHeightShutter(),
                  length: 1),
          ]);
        }
      }
      //===============    الدرف بولي لاك    ============

      if (c.isShutterPolyLac && !c.isEnd) {
        if (c.isShutterOnceColor || c.isShutterMixColor) {
          shutter1stFillList.addAll([
            Size2AndLength(
                size1: c.is90
                    ? c.right90widthShutter()
                    : c.resultWidthShutter() / c.shutterLength,
                size2: c.resultHeightShutter(),
                length: c.shutterLength),
            if (c.is90)
              Size2AndLength(
                  size1: c.left90widthShutter(),
                  size2: c.resultHeightShutter(),
                  length: 1),
          ]);
        }
        if (c.isShutterMultiColor) {
          shutter2ndFillList.addAll([
            Size2AndLength(
                size1: c.is90
                    ? c.right90widthShutter()
                    : c.resultWidthShutter() / c.shutterLength,
                size2: c.resultHeightShutter(),
                length: c.shutterLength),
            if (c.is90)
              Size2AndLength(
                  size1: c.left90widthShutter(),
                  size2: c.resultHeightShutter(),
                  length: 1),
          ]);
        }
      }
      if (c.isShutterGlass && !c.isEnd) {
        shutterGlassCollectList.addAll([
          Size2AndLength(
              size1: c.is90
                  ? c.right90widthShutter()
                  : c.resultWidthShutter() / c.shutterLength,
              size2: c.resultHeightShutter(),
              length: c.shutterLength),
          if (c.is90)
            Size2AndLength(
                size1: c.left90widthShutter(),
                size2: c.resultHeightShutter(),
                length: 1),
        ]);

        shutterGlassList.addAll([
          SizeAndLength(
              size: c.is90
                  ? c.right90widthShutter()
                  : c.resultWidthShutter() / c.shutterLength,
              length: c.shutterLength * 2),
          SizeAndLength(size: c.resultHeightShutter(), length: c.is90 ? 4 : 2),
          if (c.is90) SizeAndLength(size: c.left90widthShutter(), length: 2)
        ]);
        glassShutter.addAll([
          Size2AndLength(
              size1: c.is90
                  ? c.right90widthShutter()
                  : c.resultWidthShutter() / c.shutterLength -
                      c.shutterFillDeduct,
              size2: c.resultHeightShutter() - c.shutterFillDeduct,
              length: c.shutterLength),
          if (c.is90)
            Size2AndLength(
                size1: c.left90widthShutter() - c.shutterFillDeduct,
                size2: c.resultHeightShutter() - c.shutterFillDeduct,
                length: 2)
        ]);
      }

      if (c.unitType == 0) totalLowerUnit += 5;
    }

    for (var k in unitsList) {
      if (!k.isFaceUnit) {
//=================================ألومنيوم الوش============================
        onceSKList.addAll([
          SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultWidthSk() + k.totalSk()
                  : k.resultWidthSk(),
              length: k.isBackOut ? 4 : 2),
          SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultHeightSk() + k.totalSk()
                  : k.resultHeightSk(),
              length: k.isBackOut ? 4 : 2)
        ]);
//===============ألومنيوم العمق ============

        if (k.isDeepNearly)
          nearlyList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultDeepSk() + k.totalSk()
                  : k.resultDeepSk(),
              length: k.unitType == 0 ? 2 : 4));

        if (k.isDeepRemotely)
          remotelyList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultDeepSk() + k.totalSk()
                  : k.resultDeepSk(),
              length: k.unitType == 0 ? 2 : 4));

        if (k.unitType == 0)
          onceSKList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultDeepSk() + k.totalSk()
                  : k.resultDeepSk(),
              length: 2));

//=============== ألومنيوم الظهر============

        if (k.isBackIn)
          nearlyList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultWidthSk() + k.totalSk()
                  : k.resultWidthSk(),
              length: k.unitType == 0 ? 1 : 2));
        if (k.isBackInOut)
          remotelyList.addAll([
            SizeAndLength(
                size: k.isHeadCorner
                    ? k.resultWidthSk() + k.totalSk()
                    : k.resultWidthSk(),
                length: k.unitType == 0 ? 1 : 2),
            SizeAndLength(
                size: k.isHeadCorner
                    ? k.resultHeightSk() + k.totalSk()
                    : k.resultHeightSk(),
                length: 2),
          ]);
        if (k.unitType == 0 && k.isBackIn || k.isBackInOut)
          onceSKList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultWidthSk() + k.totalSk()
                  : k.resultWidthSk(),
              length: 1));

        if (k.isBackIn && k.isDeepRemotely)
          remotelyList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultHeightSk() + k.totalSk()
                  : k.resultHeightSk(),
              length: 2));
        if (k.isBackIn && k.isDeepNearly)
          nearlyList.add(SizeAndLength(
              size: k.isHeadCorner
                  ? k.resultHeightSk() + k.totalSk()
                  : k.resultHeightSk(),
              length: 2));
//===============ألومنيوم الدرج العلبة============
        if (k.isShutterWithDrawer) {
          double width = k.resultWidthSk() - 2.5 - k.totalSk();
          double height = k.resultHeightShutter() - 5 - k.totalSk();
          double deep = k.resultDeepSk() - k.totalSk();
          int length = 2 * k.shutterLength();
          onceSKList.addAll([
            SizeAndLength(size: width, length: length),
            SizeAndLength(size: deep, length: length),
          ]);
          nearlyList.addAll([
            SizeAndLength(size: width, length: length),
            SizeAndLength(size: deep, length: length),
            SizeAndLength(size: height, length: length * 2),
          ]);
          fillDrawerList.addAll([
            Size2AndLength(size1: width, size2: height, length: length),
            Size2AndLength(size1: deep, size2: height, length: length),
            Size2AndLength(size1: deep, size2: width, length: length ~/ 2),
          ]);
        }
//===============ألومنيوم البامبو============

        if (k.isBasket) {
          basketCollectList.add(Size2AndLength(
              size1: k.entryWidth() - 2.5, size2: k.deep - 7, length: 3));
          basketList.addAll([
            SizeAndLength(size: k.entryWidth() - 2.5, length: 6),
            SizeAndLength(size: k.deep - 7, length: 6),
          ]);

          if (!k.withoutShutter) {
            shutterCollect1stColorList.add(Size2AndLength(
                size1: k.resultWidthShutter(), size2: 10, length: 3));
          }

          basketLength += 3;
        }
//===============ألومنيوم مجري الجرار============

        if (k.isSlide) {
          slideTrackList.addAll([
            SizeAndLength(size: k.entryWidth(), length: 4),
            SizeAndLength(size: k.entryHeight(), length: 2),
          ]);

          if (k.isShutterOnceColor || k.isShutterMixColor) {
            shutterCollect1stColorList.add(Size2AndLength(
                size1: k.width / 2,
                size2: k.entryHeight() - 1.5,
                length: k.isShutterMixColor ? 1 : k.shutterLength()));
          }
          if (k.isShutterMultiColor ||
              k.isShutterMixColor && k.shutterLength() > 1) {
            shutterCollect2ndColorList.add(Size2AndLength(
                size1: k.width / 2,
                size2: k.entryHeight() - 1.5,
                length: k.isShutterMixColor ? 1 : k.shutterLength()));
          }

          slideBike += 4;
        }

//===============      القواطع      ============

        if (k.isOpened ||
            k.isFixed ||
            k.heightShutterLength > 1 ||
            k.isWithTilt)
          fixedCollectList.add(Size2AndLength(
              size1: k.resultWidthFixed(),
              size2: k.isFixed ? k.resultHeightFixed() : k.resultDeepFixed(),
              length: 1));

//===============   الرف    ============

        if (k.rackLength >= 1)
          rackCollectList.add(Size2AndLength(
              size1: k.resultWidthRack(),
              size2: k.resultDeepRack(),
              length: k.rackLength));

//===============    الدرف    ============

        if (!k.withoutShutter &&
            !k.isShutterPolyLac &&
            !k.isBasket &&
            !k.isSlide) {
          if (k.isShutterOnceColor || k.isShutterMixColor) {
            shutterCollect1stColorList.add(Size2AndLength(
                size1: k.resultWidthShutter(),
                size2: k.resultHeightShutter(),
                length: k.isShutterMixColor ? 1 : k.shutterLength()));
          }
          if (k.isShutterMultiColor ||
              k.isShutterMixColor && k.shutterLength() > 1) {
            shutterCollect2ndColorList.add(Size2AndLength(
                size1: k.resultWidthShutter(),
                size2: k.resultHeightShutter(),
                length: k.isShutterMixColor ? 1 : k.shutterLength()));
          }
          if (k.isWithTilt) {
            shutterCollect1stColorList.add(Size2AndLength(
                size1: k.resultWidthSk() + k.shutterWidthDeductFinal(),
                size2: k.openedUnitHeight + k.shutterWidthDeductFinal(),
                length: 1));
          }
        }

        //===============    الدرف بولي لاك    ============

        if (k.isShutterPolyLac && !k.isBasket && !k.isSlide) {
          if (k.isShutterOnceColor || k.isShutterMixColor) {
            shutter1stFillList.add(Size2AndLength(
                size1: k.resultWidthShutter(),
                size2: k.resultHeightShutter(),
                length: k.isShutterMixColor ? 1 : k.shutterLength()));
          }
          if (k.isShutterMultiColor ||
              k.isShutterMixColor && k.shutterLength() > 1) {
            shutter2ndFillList.add(Size2AndLength(
                size1: k.resultWidthShutter(),
                size2: k.resultHeightShutter(),
                length: k.isShutterMixColor ? 1 : k.shutterLength()));
          }
          if (k.isWithTilt) {
            shutter1stFillList.add(Size2AndLength(
                size1: k.resultWidthSk() + k.shutterWidthDeduct,
                size2: k.openedUnitHeight + k.shutterWidthDeduct,
                length: 1));
          }
        }
//======================== دولايب ========================

        if (k.isMultiHeight) {
          if (k.isShutterGlass)
            shutterGlassCollectList.add(Size2AndLength(
                size1: k.resultWidthMultiHeightShutter(),
                size2: k.resultHeightMultiHeightShutter(),
                length: k.shutterMultiLength()));
          else {
            if (k.isShutterOnceColor || k.isShutterMixColor) {
              shutterCollect1stColorList.add(Size2AndLength(
                  size1: k.resultWidthMultiHeightShutter(),
                  size2: k.resultHeightMultiHeightShutter(),
                  length: k.isShutterMixColor ? 1 : k.shutterMultiLength()));
            }
            if (k.isShutterMultiColor ||
                k.isShutterMixColor && k.shutterMultiLength() > 1) {
              shutterCollect2ndColorList.add(Size2AndLength(
                  size1: k.resultWidthMultiHeightShutter(),
                  size2: k.resultHeightMultiHeightShutter(),
                  length: k.isShutterMixColor ? 1 : k.shutterMultiLength()));
            }
          }
          fixedCollectList.add(Size2AndLength(
              size1: k.resultWidthFixed(),
              size2: k.resultDeepFixed(),
              length: 1));
        }
//======================== وحدات بالعرض ========================
        if (k.isMultiWidth) {
          if (k.isShutterGlass)
            shutterGlassCollectList.add(Size2AndLength(
                size1: k.resultWidthMultiWidthShutter(),
                size2: k.resultHeightMultiWidthShutter(),
                length: k.shutterMultiLength()));
          else {
            if (k.isShutterOnceColor || k.isShutterMixColor) {
              shutterCollect1stColorList.add(Size2AndLength(
                  size1: k.resultWidthMultiWidthShutter(),
                  size2: k.resultHeightMultiWidthShutter(),
                  length: k.isShutterMixColor ? 1 : k.shutterMultiLength()));
            }
            if (k.isShutterMultiColor ||
                k.isShutterMixColor && k.shutterMultiLength() > 1) {
              shutterCollect2ndColorList.add(Size2AndLength(
                  size1: k.resultWidthMultiWidthShutter(),
                  size2: k.resultHeightMultiWidthShutter(),
                  length: k.isShutterMixColor ? 1 : k.shutterMultiLength()));
            }
          }
          fixedCollectList.add(Size2AndLength(
              size1: k.resultHeightFixed(),
              size2: k.resultDeepFixed(),
              length: 1));

          rackCollectList.add(Size2AndLength(
              size1: k.entryWidthMultiRight(),
              size2: k.resultDeepRack(),
              length: 1));
        }
//======================== الأدراج ========================

        if (k.isDrawer) {
          if (k.isShutterOnceColor || k.isShutterMixColor)
            shutterCollect1stColorList.add(Size2AndLength(
                size1: k.resultWidthDrawerShutter(),
                size2:
                    k.withoutShutter ? k.resultHeightShutter() : k.heightDrawer,
                length: k.isShutterMixColor
                    ? k.drawerMixColor1stLength()
                    : k.drawerLength));

          if (k.isShutterMultiColor ||
              k.isShutterMixColor && k.drawerLength > 1)
            shutterCollect2ndColorList.add(Size2AndLength(
                size1: k.resultWidthDrawerShutter(),
                size2:
                    k.withoutShutter ? k.resultHeightShutter() : k.heightDrawer,
                length: k.isShutterMixColor
                    ? k.drawerMixColor2ndLength()
                    : k.drawerLength));

          drawerCollectList.add(Size2AndLength(
              size1: k.resultWidthDrawer(),
              size2: k.resultDeepDrawer(),
              length: k.drawerLength));

          drawerList.addAll([
            SizeAndLength(
                size: k.resultWidthDrawer(), length: k.drawerLength * 2),
            SizeAndLength(
                size: k.resultDeepDrawer(), length: k.drawerLength * 2),
          ]);
          fillDrawerList.add(Size2AndLength(
              size1: k.isDrawer
                  ? k.resultWidthDrawer()
                  : k.resultWidthDrawer() + 4,
              size2: k.resultDeepSk(),
              length: k.drawerLength));
        }

//===============فايبر التسقيط============

        if (!k.isFaceUnit) {
          fillInList.addAll([
            Size2AndLength(
                size1: k.resultDeepSk(), size2: k.resultHeightSk(), length: 2),
            Size2AndLength(
                size1: k.resultDeepSk(),
                size2: k.resultWidthSk(),
                length: k.unitType == 0 ? 1 : 2)
          ]);
//===============فايبر الظهرية============

          if (k.isBackIn)
            fillBackList.add(Size2AndLength(
                size1: k.resultWidthSk(),
                size2: k.resultHeightSk(),
                length: 1));
          if (k.isBackOut)
            fillBackList.add(Size2AndLength(
                size1: k.width - .5, size2: k.height - .5, length: 1));
        }
//===============زجاج الدرف============

        if (k.isShutterGlass && !k.isMultiHeight) {
          shutterGlassCollectList.add(Size2AndLength(
              size1: k.resultWidthShutter(),
              size2: k.resultHeightShutter(),
              length: k.shutterLength()));

          shutterGlassList.addAll([
            SizeAndLength(
                size: k.resultWidthShutter(), length: k.shutterLength() * 2),
            SizeAndLength(
                size: k.resultHeightShutter(), length: k.shutterLength() * 2),
          ]);
          glassShutter.add(Size2AndLength(
              size1: k.resultWidthShutter() - k.shutterFillDeduct,
              size2: k.resultHeightShutter() - k.shutterFillDeduct,
              length: k.shutterLength()));
        }
      }
    }
    final k = listOfUnits.last;
    for (var data in shutterCollect1stColorList) {
      shutter1stColorList.addAll([
        SizeAndLength(size: data.size1, length: data.length * 2),
        SizeAndLength(size: data.size2, length: data.length * 2)
      ]);
      shutter1stFillList.add(Size2AndLength(
          size1: data.size1 - k.shutterFillDeduct,
          size2: data.size2 - k.shutterFillDeduct,
          length: data.length));
      if (k.isShutterDouble)
        shutterDoubleFillList.add(Size2AndLength(
            size1: data.size1 - k.shutterDoubleFillDeduct,
            size2: data.size2 - k.shutterDoubleFillDeduct,
            length: data.length));
    }
    for (var data in shutterCollect2ndColorList) {
      shutter2ndColorList.addAll([
        SizeAndLength(size: data.size1, length: data.length * 2),
        SizeAndLength(size: data.size2, length: data.length * 2)
      ]);
      shutter2ndFillList.add(Size2AndLength(
          size1: data.size1 - k.shutterFillDeduct,
          size2: data.size2 - k.shutterFillDeduct,
          length: data.length));
      if (k.isShutterDouble)
        shutterDoubleFillList.add(Size2AndLength(
            size1: data.size1 - k.shutterDoubleFillDeduct,
            size2: data.size2 - k.shutterDoubleFillDeduct,
            length: data.length));
    }
    for (var data in fixedCollectList) {
      onceSK45List.addAll([
        SizeAndLength(size: data.size1, length: 2),
        SizeAndLength(size: data.size2, length: 2),
      ]);

      fillFixedList.add(Size2AndLength(
          size1: data.size1 - k.totalSk(),
          size2: data.size2 - k.totalSk(),
          length: 1));
    }
    for (var data in rackCollectList) {
      rackList.addAll([
        SizeAndLength(size: data.size1, length: data.length * 2),
        SizeAndLength(size: data.size2, length: data.length * 2)
      ]);
      fillRackList.add(Size2AndLength(
          size1: k.isRack25 ? data.size1 - 5 : data.size1 - .5,
          size2: k.isRack25 ? data.size2 - 5 : data.size2 - .5,
          length: k.rackLength));
    }

    emit(AddUnitState());
  }

  sortLists() {
    collectSK.clear();
    collectSKList.clear();
    collectShutter.clear();
    collectShutterList.clear();

    List<List<SizeAndLength>> sizeList = [
      nearlyList,
      remotelyList,
      onceSKList,
      onceSK45List,
      cornerSKList,
      drawerList,
      basketList,
      rackList,
      shutter1stColorList,
      shutter2ndColorList,
      shutterGlassList,
      slideTrackList,
    ];
    for (var data in sizeList) {
      data.sort((a, b) => b.size.compareTo(a.size));

      for (var i = 0; i <= data.length - 2; i++) {
        double size = data[i].size;
        int length = data[i].length;

        if (data[i].size == data[i + 1].size) {
          data.removeAt(i);
          for (var j = 0; j <= data.length - 1; j++) {
            if (data[i].size == data[j].size) {
              length += data[j].length;
            }
          }
        }

        data.removeWhere((e) => e.size == data[i].size);
        data.insert(0, SizeAndLength(size: size, length: length));
        data.sort(((a, b) => b.size.compareTo(a.size)));
      }
    }

    List<List<Size2AndLength>> size2List = [
      fixedCollectList,
      shutterCollect1stColorList,
      shutterCollect2ndColorList,
      rackCollectList,
      drawerCollectList,
      basketCollectList,
      fillBackList,
      fillInList,
      fillRackList,
      fillDrawerList,
      fillFixedList,
      shutter1stFillList,
      shutter2ndFillList,
      shutterDoubleFillList,
      shutterGlassCollectList,
      glassShutter,
    ];
    for (var data in size2List) {
      data.sort((a, b) => (b.size1 * b.size2).compareTo(a.size1 * a.size2));

      for (var i = 0; i <= data.length - 2; i++) {
        double size1 = data[i].size1;
        double size2 = data[i].size2;
        int length = data[i].length;

        if (data[i].size1 == data[i + 1].size1 &&
            data[i].size2 == data[i + 1].size2) {
          data.removeAt(i);
          for (var j = 0; j <= data.length - 1; j++) {
            if (data[i].size1 == data[j].size1 &&
                data[i].size2 == data[j].size2) {
              length += data[j].length;
            }
          }
        }

        data.removeWhere(
            (e) => e.size1 == data[i].size1 && e.size2 == data[i].size2);
        data.insert(
            0, Size2AndLength(size1: size1, size2: size2, length: length));
        data.sort((a, b) => (b.size1 * b.size2).compareTo(a.size1 * a.size2));
      }
    }

//===================== تجميع العلب في قايمة واحدة ===================

    for (var data in onceSKList) {
      collectSK.update(data.size, (v) => [data.length, 0, 0],
          ifAbsent: () => [data.length, 0, 0]);
    }
    for (var data in nearlyList) {
      collectSK.update(
          data.size, (v) => [collectSK[data.size]![0], data.length, 0],
          ifAbsent: () => [0, data.length, 0]);
    }
    for (var data in remotelyList) {
      collectSK.update(
          data.size,
          (v) =>
              [collectSK[data.size]![0], collectSK[data.size]![1], data.length],
          ifAbsent: () => [0, 0, data.length]);
    }

    collectSK.forEach((k, v) {
      collectSKList.add(CollectSKData(size: k, length: v));
    });

//===================== تجميع الدرف في قايمة واحدة ===================

    for (var data in shutter1stColorList) {
      collectShutter.update(data.size, (v) => [data.length, 0, 0],
          ifAbsent: () => [data.length, 0, 0]);
    }
    for (var data in shutter2ndColorList) {
      collectShutter.update(
          data.size, (v) => [collectShutter[data.size]![0], data.length, 0],
          ifAbsent: () => [0, data.length, 0]);
    }
    for (var data in shutterGlassList) {
      collectShutter.update(
          data.size,
          (v) => [
                collectShutter[data.size]![0],
                collectShutter[data.size]![1],
                data.length
              ],
          ifAbsent: () => [0, 0, data.length]);
    }

    collectShutter.forEach((k, v) {
      collectShutterList.add(CollectSKData(size: k, length: v));
    });

    emit(SortListsState());
  }

  void clearLists([bool clearUnitList = true]) {
    if (clearUnitList) unitsList.clear();
    if (clearUnitList) listOfUnits.clear();
    //================ تجميع ==================

    fixedCollectList.clear();
    shutterCollect1stColorList.clear();
    shutterCollect2ndColorList.clear();
    shutterGlassCollectList.clear();
    rackCollectList.clear();
    drawerCollectList.clear();
    basketCollectList.clear();

    //================ ألومنيوم ==================
    nearlyList.clear();
    remotelyList.clear();
    onceSKList.clear();
    cornerSKList.clear();

    onceSK45List.clear();
    drawerList.clear();
    basketList.clear();
    slideTrackList.clear();
    rackList.clear();
    shutter1stColorList.clear();
    shutter2ndColorList.clear();
    shutterGlassList.clear();
    //================ فايبر ==================
    fillBackList.clear();
    fillInList.clear();
    fillRackList.clear();
    fillDrawerList.clear();
    shutter1stFillList.clear();
    shutter2ndFillList.clear();
    shutterDoubleFillList.clear();
    fillFixedList.clear();
    //================ زجاج ==================
    glassShutter.clear();
    basketLength = 0;
    slideBike = 0;
    emit(ClearListsState());
  }

  List<double> materialList = [];

  materialsList() {
    materialList.clear();
    totalHing = 0;
    shutterLength = 0;
    hingeLength = 0;
    totalDrawer = 0;
    totalRack = 0;
    totalFixed = 0;
    totalTilt = 0;
    totalDrawerUnit = 0;
    fillSize = 0;
    fillShutter1Size = 0;
    fillShutter2Size = 0;
    fillShutterDoubleSize = 0;
    totalLowerUnit = 0;
    frontSize = 80;

    List<List<SizeAndLength>> size1List = [
      onceSKList,
      onceSK45List,
      nearlyList,
      remotelyList,
      cornerSKList,
      drawerList,
      rackList,
      shutter1stColorList,
      shutter2ndColorList,
      shutterGlassList,
      slideTrackList,
      basketList,
    ];

    for (var data in size1List) {
      double size = 0;
      for (var e in data) {
        size = (size + (e.size * e.length));
      }
      materialList.add(size);
    }

    //============ لدمج المفرد والمفرد مشطوف 45
    double size = materialList[0] + materialList[1];
    materialList.removeRange(0, 2);
    materialList.insert(0, size);
    //========================================
    skCorner += materialList[0];
    nearlyCorner += materialList[1];
    remotelyCorner += materialList[2];
    rackCorner += materialList[5];
    materialList.removeAt(0);
    materialList.insert(0, skCorner);
    materialList.removeAt(1);
    materialList.insert(1, nearlyCorner);
    materialList.removeAt(2);

    materialList.insert(2, remotelyCorner);

    materialList.removeAt(5);
    materialList.insert(5, rackCorner);
    skCorner = 0;
    nearlyCorner = 0;
    remotelyCorner = 0;
    rackCorner = 0;

    for (var data in unitsList) {
      if (data.unitType == 1) frontSize += data.width + 8;
    }
    materialList.add(frontSize == 80 ? 0 : frontSize);

    for (var data in unitsList) {
      if (data.unitType == 0) underSize += data.width;
    }
    materialList.add(underSize == 120 ? 0 : underSize);

    for (var data in shutterCollect1stColorList) {
      totalHing += data.length;
      shutterLength += data.length;
      hingeLength += data.length;

      if (unitsList.any((e) => e.isSlide)) {
        hingeLength -= 2;
      }

      if (unitsList.any((e) => e.isBasket && !e.withoutShutter)) {
        totalHing -= 3;
      }
    }

    for (var data in shutterCollect2ndColorList) {
      totalHing += data.length;
      shutterLength += data.length;

      hingeLength += data.length;

      if (unitsList.any((e) => e.isSlide)) {
        hingeLength -= 2;
      }
    }
    for (var data in basketCollectList) {
      totalHing += data.length;
      totalDrawer += data.length;
      totalFixed += data.length;
      skCorner += (data.size1 * 6) + (data.size2 * 6);
    }
    for (var data in rackCollectList) {
      totalRack += data.length;
    }
    for (var data in drawerCollectList) {
      totalDrawer += data.length;
    }

    for (var data in unitsList) {
      if (data.isShutterWithDrawer) {
        totalDrawer += data.shutterLength();
        totalDrawerUnit += data.shutterLength();
      }
    }
    for (var data in unitsList) {
      if (data.unitType == 0) {
        totalLowerUnit += 4;
      }
    }

    for (var data in unitsList) {
      if (data.heightShutterLength > 1) {
        totalTilt += 4;
      }
    }
    for (var data in fixedCollectList) {
      totalFixed += data.length;
    }

    for (var e in fillBackList) {
      fillSize += (e.size1 * e.size2 * e.length);
    }
    for (var e in fillInList) {
      fillSize += (e.size1 * e.size2 * e.length);
    }
    for (var e in fillRackList) {
      fillSize += (e.size1 * e.size2 * e.length);
    }
    for (var e in fillDrawerList) {
      fillSize += (e.size1 * e.size2 * e.length);
    }
    for (var e in fillFixedList) {
      fillSize += (e.size1 * e.size2 * e.length);
    }

    for (var e in shutter1stFillList) {
      fillShutter1Size += (e.size1 * e.size2 * e.length);
    }

    for (var e in shutter2ndFillList) {
      fillShutter2Size += (e.size1 * e.size2 * e.length);
    }

    for (var e in shutterDoubleFillList) {
      fillShutterDoubleSize += (e.size1 * e.size2 * e.length);
    }

    emit(MaterialListState());
  }

  void deleteUnitFromList(int id) {
    unitsList.removeWhere((e) => e.id == id);
    listOfUnits.removeWhere((e) => e.id == id);
    cornerUnits.removeWhere((e) => e.id == id);

    emit(DeleteUnitFromListState());
  }

  List<MaterialList> AlList() => materialList.isNotEmpty
      ? [
          if (materialList[0] != 0)
            MaterialList(
                size: 'المفرد',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[0] / 590).toStringAsFixed(1)} عود'),
          if (materialList[1] != 0)
            MaterialList(
                size: 'المتقارب',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[1] / 590).toStringAsFixed(1)} عود'),
          if (materialList[2] != 0)
            MaterialList(
                size: 'المتباعد',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[2] / 590).toStringAsFixed(1)} عود'),
          if (materialList[3] != 0)
            MaterialList(
                size: 'قطاع ركنة',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[3] / 590).toStringAsFixed(1)} عود'),
          if (materialList[4] != 0)
            MaterialList(
                size: 'الدرج',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[4] / 590).toStringAsFixed(1)} عود'),
          if (materialList[5] != 0)
            MaterialList(
                size: 'الرف',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[5] / 590).toStringAsFixed(1)} عود'),
          if (materialList[6] != 0)
            MaterialList(
                size: 'الدرفة أساسي',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[6] / 590).toStringAsFixed(1)} عود'),
          if (materialList[7] != 0)
            MaterialList(
                size: 'الدرفة ثانوي',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[7] / 590).toStringAsFixed(1)} عود'),
          if (materialList[8] != 0)
            MaterialList(
                size: 'درفة الزجاج',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[8] / 590).toStringAsFixed(1)} عود'),
          if (materialList[9] != 0)
            MaterialList(
                size: 'مجرى الجرار',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[9] / 590).toStringAsFixed(1)} عود'),
          if (materialList[10] != 0)
            MaterialList(
                size: 'الكورنيشة',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[10] / 590).toStringAsFixed(1)} عود'),
          if (materialList[11] != 0)
            MaterialList(
                size: 'الوزرة السفلية 2*8',
                length:
                    '${(materialList.isEmpty ? 590 : materialList[11] / 590).toStringAsFixed(1)} عود'),
        ]
      : [];

  List<MaterialList> BoardList() => [
        if (fillSize != 0)
          MaterialList(
              size: 'ألواح الدواخل',
              length: '${(fillSize / 32800).toStringAsFixed(1)}لوح'),
        if (fillShutter1Size != 0)
          MaterialList(
              size: 'الدرف اللون الأساسي',
              length: '${(fillShutter1Size / 27400).toStringAsFixed(1)}لوح'),
        if (fillShutter2Size != 0)
          MaterialList(
              size: 'الدرف اللون الثانوي',
              length: '${(fillShutter2Size / 27400).toStringAsFixed(1)}لوح'),
        if (fillShutterDoubleSize != 0)
          MaterialList(
              size: 'ألواح الضبل',
              length:
                  '${(fillShutterDoubleSize / 32800).toStringAsFixed(1)}لوح'),
      ];

  List<MaterialList> accessoriesList() => [
        MaterialList(
            size:
                ' ${unitsList.isNotEmpty ? unitsList[0].isFaceUnit ? 'عظم تجميع دفن' : 'زاوية تجميع ثلاثية' : ''}',
            length: '${(listOfUnits.length * 8 + totalDrawerUnit * 8)}'),
        if (shutterLength != 0)
          MaterialList(
              size: 'عظم تجميع درفة', length: '${(shutterLength * 4)}'),
        if (totalFixed != 0)
          MaterialList(size: 'عظم دفن قائم', length: '${(totalFixed * 4)}'),
        if (totalRack != 0)
          MaterialList(size: 'عظم تجميع رف', length: '${(totalRack * 4)}'),
        if (hingeLength != 0)
          MaterialList(size: 'مفصلات', length: '${hingeLength * 2}'),
        if (totalDrawer != 0)
          MaterialList(size: 'مجر أدراج', length: '${(totalDrawer)}'),
        if (totalHing != 0)
          MaterialList(size: 'مقابض', length: '${(totalHing)}'),
        if (totalLowerUnit != 0)
          MaterialList(size: 'رجول', length: '${(totalLowerUnit)}'),
        if (totalTilt != 0)
          MaterialList(size: 'ذراع قلاب', length: '${(totalTilt)}'),
        if (basketLength != 0)
          MaterialList(size: 'سبت بامبو', length: '${(basketLength)}'),
        if (slideBike != 0)
          MaterialList(size: 'عجل جرار', length: '${(slideBike)}'),
      ];

  List<ResultData> resultCollectData() => [
        ResultData(
            'تجميع الدرف ${shutterCollect2ndColorList.isNotEmpty ? 'اللون الأساسي' : ''}',
            shutterCollect1stColorList),
        if (shutterCollect2ndColorList.isNotEmpty)
          ResultData('تجميع الدرف اللون الثانوي', shutterCollect2ndColorList),
        if (rackCollectList.isNotEmpty)
          ResultData('تجميع الرف', rackCollectList),
        if (fixedCollectList.isNotEmpty)
          ResultData('تجميع القواطع', fixedCollectList),
        if (drawerCollectList.isNotEmpty)
          ResultData('تجميع الأدراج ', drawerCollectList),
        if (basketCollectList.isNotEmpty)
          ResultData('تجميع درج البامبو ', basketCollectList),
      ];

  List<ResultData> resultCutData() => [
        ResultData('تقطيع العلب', collectSKList),
        ResultData('تقطيع الدرف', collectShutterList),
        if (onceSK45List.isNotEmpty) ResultData('تقطيع القواطع', onceSK45List),
        if (rackList.isNotEmpty) ResultData('تقطيع الرف', rackList),
        if (drawerList.isNotEmpty) ResultData('تقطيع الدرج ', drawerList),
        if (basketList.isNotEmpty) ResultData('تقطيع درج البامبو ', basketList),
        if (slideTrackList.isNotEmpty)
          ResultData('تقطيع مجرى الجرار ', slideTrackList),
      ];

  List<ResultData> resultFillData() => [
        ResultData('الظهريات', fillBackList),
        ResultData(' تسقيط الأجناب والأرضية', fillInList),
        if (fillRackList.isNotEmpty) ResultData('الأرفف', fillRackList),
        if (fillDrawerList.isNotEmpty)
          ResultData('أرضية الأدراج', fillDrawerList),
        if (fillFixedList.isNotEmpty) ResultData('حشو القواطع', fillFixedList)
      ];

  List<ResultData> resultFillShutterData() => [
        ResultData('اللون الأساسي لحشو الدرف', shutter1stFillList),
        if (shutter2ndFillList.isNotEmpty)
          ResultData('اللون الثانوي لحشو الدرف', shutter2ndFillList),
        if (shutterDoubleFillList.isNotEmpty)
          ResultData('الحشو الداخلي للدرفة الضبل', shutterDoubleFillList),
        if (glassShutter.isNotEmpty) ResultData('زجاج الدرف', glassShutter)
      ];

  List<ResultData> materialResultList() => [
        ResultData('تقرير الألومنيوم', AlList()),
        ResultData('تقرير الألواح', BoardList()),
        ResultData('تقرير الاكسسوار', accessoriesList()),
      ];

  List<ResultData> titleList() => [
        ResultData('تقرير التجميع', resultCollectData()),
        ResultData('تقرير تقطيع الألومنيوم', resultCutData(), false, true),
        ResultData('تقرير  حشو الوحدات', resultFillData()),
        ResultData('تقرير  حشو الدرف', resultFillShutterData()),
        ResultData('تقرير الخامات', materialResultList(), true),
      ];
}

class CollectSKData {
  final double size;
  final List length;

  CollectSKData({required this.size, required this.length});
}
