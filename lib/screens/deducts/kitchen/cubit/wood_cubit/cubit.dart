import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/class.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/corner_data.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/wood_kitchen_data.dart';

class WoodCubit extends Cubit<WoodState> {
  WoodCubit() : super(InitState());

  List allUnits = [];

  List<WoodKitchenData> unitsList = [];
  List<CornerData> cornerList = [];
  List<Size2AndLength> hplList = [];
  List<Size2AndLength> polyLac1stList = [];
  List<Size2AndLength> polyLac2ndList = [];
  List<Size2AndLength> backList = [];
  List<Size2AndLength> backDrawerList = [];
  List<Size2AndLength> rackList = [];
  List<Size2AndLength> drawerBodyList = [];
  List<Size2AndLength> basketBodyList = [];

  double totalShutter = 0, totalDrawer = 0;
  double hplSize = 0, polyLac1Size = 0, polyLac2Size = 0, backSize = 0;
  int hingeLength = 0, basketLength = 0;

  void insertUnitToList(WoodKitchenData k) {
    unitsList.insert(0, k);
    allUnits.insert(0, k);

    emit(InsertUnitToListState());
  }

  void insertCornerUnitToList(CornerData c) {
    cornerList.insert(0, c);
    allUnits.insert(0, c);
    emit(InsertCornerToListState());
  }

  addItemsToList() {
    clearLists(false);

    for (var c in cornerList) {
      hplList.addAll([
        Size2AndLength(size1: c.width, size2: c.height, length: 2),
        if (!c.isEnd)
          Size2AndLength(
              size1: c.deepLeft, size2: c.cornerHeight - (c.sk * 2), length: 1),
        if (!c.isEnd)
          Size2AndLength(
              size1: c.deepRight,
              size2: c.cornerHeight - (c.sk * 2),
              length: 1),
        if (!c.isEnd)
          Size2AndLength(
              size1: 7,
              size2: c.cornerHeight - (c.sk * 2),
              length: c.is90 ? 1 : 3),
      ]);

      if (!c.isEnd)
        backList.addAll([
          Size2AndLength(size1: c.width, size2: c.cornerHeight - 2, length: 1),
          Size2AndLength(size1: c.height, size2: c.cornerHeight - 2, length: 1),
        ]);

      if (c.isEnd) {
        hplList.addAll([
          Size2AndLength(size1: c.width, size2: c.entryHeight(), length: 1),
          Size2AndLength(
              size1: c.height - c.sk, size2: c.entryHeight(), length: 1),
        ]);
      }
      rackList.add(Size2AndLength(
          size1: c.width - (c.totalSk()),
          size2: c.height - (c.totalSk()),
          length: c.rackLength));
      if (!c.isEnd) {
        if (c.isShutterOnceColor || c.isShutterMixColor) {
          polyLac1stList.addAll([
            Size2AndLength(
                size1: c.is90
                    ? c.right90widthShutter() - c.sk
                    : c.resultWidthWoodShutter() / c.shutterLength,
                size2: c.resultHeightWoodShutter(),
                length: c.shutterLength),
            if (c.is90)
              Size2AndLength(
                  size1: c.left90widthShutter() - c.sk,
                  size2: c.resultHeightWoodShutter(),
                  length: 1),
          ]);
        }
        if (c.isShutterMultiColor) {
          polyLac2ndList.addAll([
            Size2AndLength(
                size1: c.is90
                    ? c.right90widthShutter() - c.sk
                    : c.resultWidthWoodShutter() / c.shutterLength,
                size2: c.resultHeightWoodShutter(),
                length: c.shutterLength),
            if (c.is90)
              Size2AndLength(
                  size1: c.left90widthShutter() - c.sk,
                  size2: c.resultHeightWoodShutter(),
                  length: 1),
          ]);
        }
      }
    }

    for (var w in unitsList) {
      hplList.addAll([
        Size2AndLength(
            size1: w.resultWidth(),
            size2: w.resultDeep(),
            length: w.unitType == 0 ? 1 : 2),
        Size2AndLength(
            size1: w.resultHeight() +
                (w.unitType == 0 && w.isUp ? w.thicknessCM() : 0),
            size2: w.resultDeep(),
            length: 2),
      ]);

      if (w.isBasket) {
        basketBodyList.addAll([
          Size2AndLength(size1: w.entryWidth() - 2.5, size2: 7, length: 6),
          Size2AndLength(size1: w.deep - 7, size2: 7, length: 6)
        ]);

        if (!w.withoutShutter) {
          polyLac1stList.add(Size2AndLength(
              size1: w.resultWidthShutter(), size2: 10, length: 3));
        }

        basketLength += 3;
      }
      if (w.unitType == 0)
        hplList.add(
          Size2AndLength(
              size1: w.resultWidth() - (w.isUp ? w.totalThickness() : 0),
              size2: 7,
              length: 2),
        );

      backList.add(Size2AndLength(
          size1: w.resultWidthBack(), size2: w.resultHeightBack(), length: 1));

      if (w.isFixed || w.isOpened) {
        rackList.add(Size2AndLength(
            size1: w.isFixed ? w.fixedWidth : w.fixedSizeFinal(),
            size2: w.isFixed ? w.height : w.resultDeepRack(),
            length: 1));
      }

      if (w.rackLength > 0 || w.heightShutterLength > 1) {
        rackList.add(
          Size2AndLength(
              size1: w.resultWidthRack(),
              size2: w.heightShutterLength > 1
                  ? w.resultDeepRack()
                  : w.resultDeepRack() - .5,
              length: w.heightShutterLength > 1 ? 1 : w.rackLength),
        );
      }

      if (!w.withoutShutter && !w.isBasket) {
        if (w.isShutterOnceColor || w.isShutterMixColor) {
          polyLac1stList.add(Size2AndLength(
              size1: w.resultWidthShutter(),
              size2: !w.isWithTilt
                  ? w.resultHeightShutter()
                  : w.entryHeight() +
                      (w.thicknessCM() * 3 / 2) -
                      w.shutterDeductCM(),
              length: w.isShutterMixColor ? 1 : w.lShutter()));
        }
        if (w.isShutterMultiColor || w.isShutterMixColor && w.lShutter() > 1) {
          polyLac2ndList.add(Size2AndLength(
              size1: w.resultWidthShutter(),
              size2: !w.isWithTilt
                  ? w.resultHeightShutter()
                  : w.entryHeight() +
                      (w.thicknessCM() * 3 / 2) -
                      w.shutterDeductCM(),
              length: w.isShutterMixColor ? 1 : w.lShutter()));
        }
      }

      if (w.isWithTilt) {
        polyLac1stList.add(Size2AndLength(
            size1: w.width - w.shutterDeductCM(),
            size2: w.openedUnitHeight +
                (w.thicknessCM() * 3 / 2) -
                w.shutterDeductCM(),
            length: 1));
      }
//=================== دواليب ======================
      if (w.isMultiHeight) {
        if (w.isShutterOnceColor || w.isShutterMixColor) {
          polyLac1stList.add(Size2AndLength(
              size1: w.resultWidthMultiHeightShutter(),
              size2: w.resultHeightMultiHeightShutter(),
              length: w.isShutterMixColor ? 1 : w.shutterMultiLength()));
        }
        if (w.isShutterMultiColor ||
            w.isShutterMixColor && w.shutterMultiLength() > 1) {
          polyLac2ndList.add(Size2AndLength(
              size1: w.resultWidthMultiHeightShutter(),
              size2: w.resultHeightMultiHeightShutter(),
              length: w.isShutterMixColor ? 1 : w.shutterMultiLength()));
        }
        rackList.add(Size2AndLength(
            size1: w.resultWidthRack(), size2: w.resultDeepRack(), length: 1));
      }
//===================== وحدات بالعرض ===================================
      if (w.isMultiWidth) {
        if (w.isShutterOnceColor || w.isShutterMixColor) {
          polyLac1stList.add(Size2AndLength(
              size1: w.resultWidthMultiWidthShutter(),
              size2: w.resultHeightMultiWidthShutter(),
              length: w.isShutterMixColor ? 1 : w.shutterMultiLength()));
        }
        if (w.isShutterMultiColor ||
            w.isShutterMixColor && w.shutterMultiLength() > 1) {
          polyLac2ndList.add(Size2AndLength(
              size1: w.resultWidthMultiWidthShutter(),
              size2: w.resultHeightMultiWidthShutter(),
              length: w.isShutterMixColor ? 1 : w.shutterMultiLength()));
        }

        rackList.addAll([
          Size2AndLength(size1: w.height, size2: w.resultDeepRack(), length: 1),
          Size2AndLength(
              size1: w.entryWidthMultiRight(),
              size2: w.resultDeepRack(),
              length: 1)
        ]);
      }

//===================== الأدراج ===================================

      if (w.isDrawer) {
        if (w.isShutterOnceColor || w.isShutterMixColor)
          polyLac1stList.add(Size2AndLength(
              size1: w.resultWidthDrawerShutter(),
              size2: w.withoutShutter
                  ? w.resultHeightShutter()
                  : w.heightDrawerShutter,
              length: w.isShutterMixColor
                  ? w.drawerMixColor1stLength()
                  : w.drawerLength));

        if (w.isShutterMultiColor || w.isShutterMixColor && w.drawerLength > 1)
          polyLac2ndList.add(Size2AndLength(
              size1: w.resultWidthDrawerShutter(),
              size2: w.withoutShutter
                  ? w.resultHeightShutter()
                  : w.heightDrawerShutter,
              length: w.isShutterMixColor
                  ? w.drawerMixColor2ndLength()
                  : w.drawerLength));
        drawerBodyList.addAll([
          Size2AndLength(
              size1: w.heightDrawerBody,
              size2: w.resultDeepDrawer(),
              length: w.drawerLength * 2),
          Size2AndLength(
              size1: w.heightDrawerBody,
              size2: w.resultWidthDrawer(),
              length: w.drawerLength * 2),
        ]);

        backDrawerList.add(
          Size2AndLength(
              size1: w.resultDeepDrawerBack(),
              size2: w.resultWidthDrawerBack(),
              length: w.drawerLength),
        );
      }
      if (w.isShutterWithDrawer) {
        drawerBodyList.addAll([
          Size2AndLength(
              size1: w.resultHeightShutter() - 5,
              size2: w.resultDeepDrawer(),
              length: w.lShutter() * 2),
          Size2AndLength(
              size1: w.resultHeightShutter() - 5,
              size2: w.resultWidthDrawer(),
              length: w.lShutter() * 2),
        ]);

        backDrawerList.add(
          Size2AndLength(
              size1: w.resultDeepDrawerBack(),
              size2: w.resultWidthDrawerBack(),
              length: w.drawerLength),
        );
      }
    }
    emit(AddNewUnitState());
  }

  void clearLists([isUnit = true]) {
    if (isUnit) unitsList.clear();
    hplList.clear();
    polyLac1stList.clear();
    polyLac2ndList.clear();
    backList.clear();
    backDrawerList.clear();
    rackList.clear();
    drawerBodyList.clear();
    basketBodyList.clear();
    basketLength = 0;
    emit(ClearListsState());
  }

  sortLists() {
    List<List<Size2AndLength>> lists = [
      hplList,
      polyLac1stList,
      polyLac2ndList,
      backList,
      backDrawerList,
      rackList,
      drawerBodyList
    ];

    for (var data in lists) {
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
  }

  materialsList() {
    totalShutter = 0;
    hingeLength = 0;
    totalDrawer = 0;
    hplSize = 0;
    polyLac1Size = 0;
    polyLac2Size = 0;
    backSize = 0;
    List<List<Size2AndLength>> sizeHplList = [
      hplList,
      rackList,
      drawerBodyList,
      basketBodyList
    ];

    for (var data in sizeHplList) {
      double size = 0;
      for (var e in data) {
        size = (size + (e.size1 * e.size2 * e.length));
      }
      hplSize += size;
    }

    List<List<Size2AndLength>> sizeBackList = [backList, backDrawerList];

    for (var data in sizeBackList) {
      double size = 0;
      for (var e in data) {
        size = (size + (e.size1 * e.size2 * e.length));
      }
      backSize += size;
    }

    for (var e in polyLac1stList)
      polyLac1Size += (e.size1 * e.size2 * e.length);

    for (var e in polyLac2ndList)
      polyLac2Size += (e.size1 * e.size2 * e.length);

    for (var data in polyLac1stList) {
      totalShutter += data.length;
      hingeLength += data.length * 2;
      if (unitsList.any((e) => e.isBasket)) {
        hingeLength -= data.length * 2;
      }
    }

    for (var data in polyLac2ndList) {
      totalShutter += data.length;
      hingeLength += data.length * 2;
      if (unitsList.any((e) => e.isBasket)) {
        hingeLength -= data.length * 2;
      }
    }

    for (var data in drawerBodyList) totalDrawer += (data.length / 4);

    for (var data in unitsList) if (data.isShutterWithDrawer) totalDrawer++;
  }

  void deleteUnitFromList(int id) {
    unitsList.removeWhere((e) => e.id == id);
    allUnits.removeWhere((e) => e.id == id);
    cornerList.removeWhere((e) => e.id == id);

    emit(DeleteUnitFromListState());
  }

  List<MaterialList> boardList() => [
        MaterialList(
            size: 'ألواح الدواخل',
            length: '${(hplSize / 27400).toStringAsFixed(1)} لوح'),
        MaterialList(
            size: 'الدرف لون أساسي',
            length: '${(polyLac1Size / 27400).toStringAsFixed(1)} لوح'),
        MaterialList(
            size: 'الدرف لون ثانوي',
            length: '${(polyLac2Size / 27400).toStringAsFixed(1)} لوح'),
        MaterialList(
            size: 'ألواح الظهريات',
            length: '${(backSize / 27400).toStringAsFixed(1)} لوح'),
      ];

  List<MaterialList> accessoriesList() => [
        MaterialList(
          size: 'المفصلات',
          length: '$hingeLength',
        ),
        MaterialList(size: 'المقابض', length: '${totalShutter.round()} '),
        MaterialList(
            size: 'مجر الأدراج',
            length: '${totalDrawer.round() + basketLength.round()} '),
      ];

  List<ResultData> hplResultList() => [
        ResultData('الأجناب  و الأرضيات', hplList),
        if (drawerBodyList.isNotEmpty)
          ResultData(' أجناب الأدراج', drawerBodyList),
        if (basketBodyList.isNotEmpty)
          ResultData(' أجناب البامبو', basketBodyList),
      ];
  List<ResultData> rackResultList() => [
        ResultData('الأرفف و القواطع', rackList),
      ];
  List<ResultData> backResultList() => [
        ResultData('الظهريات', backList),
        if (backDrawerList.isNotEmpty)
          ResultData('أرضيات الأدراج', backDrawerList),
      ];
  List<ResultData> shutterResultList() => [
        ResultData('الدرف اللون الأساسي', polyLac1stList),
        if (polyLac2ndList.isNotEmpty)
          ResultData('الدرف اللون الثانوي', polyLac2ndList),
      ];
  List<ResultData> materialList() => [
        ResultData('تقرير الألواح', boardList()),
        ResultData('تقرير الإكسسوار', accessoriesList()),
      ];

  List<ResultData> titleList() => [
        ResultData('تقرير الأجناب', hplResultList()),
        ResultData('تقرير الأرفف والقواطع', rackResultList()),
        ResultData('تقرير الظهريات', backResultList()),
        ResultData('تقرير   الدرف', shutterResultList()),
        ResultData('تقرير الخامات', materialList(), true),
      ];
}
