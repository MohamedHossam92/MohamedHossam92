import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/turn_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/windows/models/fixed_data.dart';
import 'package:the_smart_workshop/screens/deducts/windows/models/turn_data.dart';
import 'package:the_smart_workshop/sql/turn_windows/const.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/cubit.dart';

import '../../../a-component/cubit/class.dart';

class TurnCubit extends Cubit<TurnState> {
  TurnCubit() : super(InitState());

  late double fixedSize = 1;

  List<TurnData> windowsList = [];
  List<FixedData> fixedCollectList = [];

  List<SizeAndLength> frameList = [];
  List<SizeAndLength> frame4590List = [];
  List<SizeAndLength> sashList = [];
  List<SizeAndLength> sash4590List = [];
  List<SizeAndLength> pandaList = [];
  List<SizeAndLength> flyScreenList = [];
  List<SizeAndLength> tList = [];
  List<SizeAndLength> underList = [];
  List<SizeAndLength> tCenterList = [];
  List<SizeAndLength> beadList = [];
  List<SizeAndLength> barList = [];
  List<Size2AndLength> frameCollectList = [];
  List<Size2AndLength> frame4590CollectList = [];
  List<Size2AndLength> sashCollectList = [];
  List<Size2AndLength> sash4590CollectList = [];
  List<Size2AndLength> sashPandaCollectList = [];
  List<Size2AndLength> flyScreenCollectList = [];
  List<Size2AndLength> glassList = [];
  List<Size2AndLength> glassFixedList = [];
  double kGlass = 0;
  double weightWindows = 0;
  double totalSashLength = 0,
      totalFrameLength = 0,
      totalPandaLength = 0,
      hingeLength = 0,
      cornerLength = 0,
      tCenterLength = 0;

  pvcCutting(double num) => windowsList[0].isPVC ? num + .6 : num;

  void fixedSizeChange(String val) {
    fixedSize = double.parse(val);
    emit(FixedChangeState());
  }

  void insertWindowsToList(TurnData m) {
    windowsList.insert(0, m);
    emit(InsertWindowsToListState());
  }

  void addItemsToList() {
    clearWindowsList(false);
    for (var m in windowsList) {
      !m.isWithoutUnder
          ? frameCollectList.add(
              Size2AndLength(
                  size1: m.windowsWidth,
                  size2: m.windowsHeight,
                  length: m.windowsLength),
            )
          : frame4590CollectList.add(
              Size2AndLength(
                  size1: m.windowsWidth,
                  size2: m.windowsHeight,
                  length: m.windowsLength),
            );

      !m.isWithoutUnder
          ? sashCollectList.add(Size2AndLength(
              size1: m.resultWidthSash(),
              size2: m.resultHeightSash(),
              length: m.totalSashLength()))
          : sash4590CollectList.add(Size2AndLength(
              size1: m.resultWidthSash(),
              size2: m.resultHeightSash(),
              length: m.totalSashLength()));

      !m.isWithoutUnder
          ? frameList.addAll([
              SizeAndLength(
                  size: pvcCutting(m.windowsWidth),
                  length: m.frameLengthCutting()),
              SizeAndLength(
                  size: pvcCutting(m.windowsHeight),
                  length: m.frameLengthCutting())
            ])
          : frame4590List.add(SizeAndLength(
              size: pvcCutting(m.windowsHeight),
              length: m.frameLengthCutting()));

      if (m.isWithoutUnder)
        frameList.add(SizeAndLength(
            size: pvcCutting(m.windowsWidth),
            length: m.frameLengthCutting(true)));

      !m.isWithoutUnder
          ? sashList.addAll([
              SizeAndLength(
                  size: pvcCutting(m.resultWidthSash()),
                  length: m.sashLengthCutting()),
              SizeAndLength(
                  size: pvcCutting(m.resultHeightSash()),
                  length: m.sashLengthCutting())
            ])
          : sash4590List.add(SizeAndLength(
              size: pvcCutting(m.resultHeightSash()),
              length: m.sashLengthCutting()));
      if (m.isWithoutUnder)
        sashList.add(SizeAndLength(
            size: pvcCutting(m.resultWidthSash()),
            length: m.sashLengthCutting(true)));

      if (m.isPanda) {
        pandaList.addAll([
          SizeAndLength(
              size: pvcCutting(m.resultWidthPanda()),
              length: m.sashLengthCutting()),
          SizeAndLength(
              size: pvcCutting(m.resultHeightPanda()),
              length: m.sashLengthCutting())
        ]);
        if (!windowsList[0].isPVC)
          flyScreenList.addAll([
            SizeAndLength(
                size: m.resultWidthPanda() - 1, length: m.sashLengthCutting()),
            SizeAndLength(
                size: m.resultHeightPanda() - 1, length: m.sashLengthCutting())
          ]);

        sashPandaCollectList.add(
          Size2AndLength(
              size1: m.resultWidthPanda(),
              size2: m.resultHeightPanda(),
              length: m.totalSashLength()),
        );
        if (!windowsList[0].isPVC)
          flyScreenCollectList.add(
            Size2AndLength(
                size1: m.resultWidthPanda() - 1,
                size2: m.resultHeightPanda() - 1,
                length: m.totalSashLength()),
          );
      }

      if (m.isSashFixed) {
        tList.add(SizeAndLength(
            size: m.entryWidthSash(), length: m.totalSashLength()));
      }

      if (m.isTilt && m.sashLength > 1) {
        tList.add(
            SizeAndLength(size: m.entryWidthFrame(), length: m.sashLength - 1));
      }

      if (m.isWithoutUnder) {
        underList.add(SizeAndLength(
            size: m.entryWidthSash(), length: m.totalSashLength()));
      }

      glassList.add(Size2AndLength(
          size1: m.widthSashGlass(),
          size2: m.heightSashGlass(),
          length: m.totalSashLength()));
      if (m.isSashFixed) {
        glassFixedList.add(Size2AndLength(
            size1: m.widthFixedGlass(),
            size2: m.heightFixedGlass(),
            length: m.totalSashLength()));
      }

      beadList.addAll([
        SizeAndLength(size: m.widthSashBead(), length: m.sashLengthCutting()),
        SizeAndLength(size: m.heightSashBead(), length: m.sashLengthCutting())
      ]);
      if (m.isSashFixed) {
        beadList.addAll([
          SizeAndLength(
              size: m.widthFixedBead(), length: m.sashLengthCutting()),
          SizeAndLength(
              size: m.heightFixedBead(), length: m.sashLengthCutting())
        ]);
      }
      if (m.sashLength >= 2 && !m.isTilt) {
        tCenterList.add(SizeAndLength(
            size: m.tCenterSize(),
            length: m.windowsLength * (m.sashLength - 1)));
      }

      if (m.isFexFrame)
        barList.addAll([
          SizeAndLength(
              size: m.windowsWidth + m.barDeduct,
              length: m.frameLengthCutting()),
          SizeAndLength(
              size: m.windowsHeight + m.barDeduct,
              length: m.frameLengthCutting()),
        ]);

      //============ الثوابت ============

      if (m.isTopFixed)
        fixedCollectList.add(FixedData(
            size1: m.entryWidthFrame(),
            size2: m.topFixedSize,
            tSize: m.tSize,
            suctionSize: m.topFixedSize,
            tLength: m.topFixedLength,
            fixSize: 0,
            length: m.windowsLength,
            isH: true,
            beadSize: m.bead,
            isTilt: m.isTilt));
      if (m.isBottomFixed)
        fixedCollectList.add(FixedData(
            size1: m.entryWidthFrame(),
            size2: m.bottomFixedSize,
            tSize: m.tSize,
            suctionSize: m.bottomFixedSize,
            tLength: m.bottomFixedLength,
            fixSize: 0,
            length: m.windowsLength,
            isH: true,
            beadSize: m.bead,
            isTilt: m.isTilt));
      if (m.isRightFixed)
        fixedCollectList.add(FixedData(
            size1: m.rightFixedSize,
            size2: m.entryHeightWithFex(),
            tSize: m.tSize,
            suctionSize: m.rightFixedSize,
            tLength: m.rightFixedLength,
            fixSize: 0,
            length: m.windowsLength,
            isV: true,
            beadSize: m.bead,
            isTilt: m.isTilt));
      if (m.isLeftFixed)
        fixedCollectList.add(FixedData(
            size1: m.leftFixedSize,
            size2: m.entryHeightWithFex(),
            tSize: m.tSize,
            suctionSize: m.leftFixedSize,
            tLength: m.rightFixedLength,
            fixSize: 0,
            length: m.windowsLength,
            isV: true,
            beadSize: m.bead,
            isTilt: m.isTilt));
      if (m.isRightFixed && m.isWithoutUnder)
        underList.add(SizeAndLength(size: m.rightFixedSize, length: 1));
      if (m.isLeftFixed && m.isWithoutUnder)
        underList.add(SizeAndLength(size: m.leftFixedSize, length: 1));

      hingeLength +=
          m.sashLength * m.windowsLength * (m.windowsHeight > 150 ? 3 : 2);

      if (m.isPanda) {
        hingeLength +=
            m.sashLength * m.windowsLength * (m.windowsHeight > 150 ? 3 : 2);
        totalPandaLength += m.sashLength * m.windowsLength;
        cornerLength += m.sashLength * m.windowsLength * 4;
      }
      totalFrameLength += m.windowsLength;

      if (m.sashLength > 1) {
        tCenterLength += (m.sashLength - 1) * m.windowsLength;
      }

      cornerLength += (m.windowsLength * (m.isWithoutUnder ? 2 : 4)) +
          (m.sashLength * m.windowsLength * (m.isWithoutUnder ? 2 : 4));

      if (m.isTilt) totalSashLength += m.sashLength * m.windowsLength;
    }

    for (var data in fixedCollectList) {
      glassList.add(Size2AndLength(
          size1: data.widthGlass(),
          size2: data.heightGlass(),
          length: (data.tLength + 1) * data.length));
      tList.addAll([
        SizeAndLength(
            size: data.cutTSize(), length: data.tLength * data.length),
        SizeAndLength(size: data.cutTFrameSize(), length: data.length),
      ]);
      beadList.addAll([
        SizeAndLength(
            size: data.widthGlass() + .5,
            length: (data.tLength + (windowsList[0].isTilt ? 0 : 1)) *
                data.length *
                2),
        SizeAndLength(
            size: data.heightGlass() + .5 - data.beadSize * 2,
            length: (data.tLength + (windowsList[0].isTilt ? 0 : 1)) *
                data.length *
                2),
      ]);

      if (windowsList[0].isTilt)
        beadList.addAll([
          SizeAndLength(size: data.size1 + .5, length: 2 * data.length),
          SizeAndLength(
              size: data.size2 + .5 - data.beadSize * 2,
              length: 2 * data.length),
        ]);
    }

    emit(AddNewWindowsListState());
  }

  void sortLists() {
    List<List<SizeAndLength>> size1List = [
      frameList,
      frame4590List,
      sashList,
      sash4590List,
      pandaList,
      flyScreenList,
      tList,
      barList,
      underList,
      tCenterList,
      beadList
    ];

    for (var data in size1List) {
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
      glassList,
      frameCollectList,
      frame4590CollectList,
      sashCollectList,
      sash4590CollectList,
      flyScreenCollectList,
      glassFixedList,
      sashPandaCollectList
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

    emit(SortListState());
  }

  clearWindowsList([isClear = true]) {
    if (isClear) windowsList.clear();
    fixedCollectList.clear();
    frameCollectList.clear();
    frame4590List.clear();
    sash4590List.clear();
    frame4590CollectList.clear();
    sash4590CollectList.clear();
    sashCollectList.clear();
    sashPandaCollectList.clear();
    tCenterList.clear();
    flyScreenList.clear();
    flyScreenCollectList.clear();
    sashList.clear();
    pandaList.clear();
    frameList.clear();
    tList.clear();
    barList.clear();
    underList.clear();
    glassList.clear();
    glassFixedList.clear();
    beadList.clear();

    kGlass = 0;
    weightWindows = 0;
    totalSashLength = 0;
    totalFrameLength = 0;
    cornerLength = 0;
    totalPandaLength = 0;
    hingeLength = 0;
    tCenterLength = 0;

    emit(ClearWindowsListState());
  }

  List<double> materialList = [];

  void materialsList() {
    materialList.clear();

    kGlass = 0;

    List<List<SizeAndLength>> size1List = [
      frameList,
      frame4590List,
      sashList,
      sash4590List,
      pandaList,
      flyScreenList,
      tList,
      barList,
      tCenterList,
      beadList,
      underList
    ];

    for (var data in size1List) {
      double size = 0;
      for (var e in data) {
        if (size1List.indexOf(data) == 0) {
          size = (size + ((e.size + 11) * e.length));
        } else {
          size = (size + (e.size * e.length));
        }
      }
      materialList.add(size);
    }

    double size = materialList[0] + materialList[1];
    materialList.removeRange(0, 2);
    materialList.insert(0, size);

    double size1 = materialList[1] + materialList[2];
    materialList.removeRange(1, 3);
    materialList.insert(1, size1);

    for (var data in glassList) {
      kGlass = (kGlass + (data.size1 * data.size2 * data.length * .0001));
    }

    for (var data in turnDeductListDb) {
      if (data[cTWindowsProfile] == windowsList[0].windowsType) {
        weightWindows = ((materialList[0] * data[cTWeightFrame]) +
                (materialList[1] * data[cTWeightSash]) +
                (materialList[2] * data[cTWeightPanda]) +
                (materialList[3] * data[cTWeightBead]) +
                (materialList[4] * data[cTWeightT]) +
                (materialList[5] * (data[cTWeightT]) / 2) +
                (materialList[6] * data[cTWeightT]) +
                (materialList[7] * data[cTWeightT]) +
                (materialList[8] * data[cTWeightBead])) *
            .01;
      }
    }

    emit(MaterialListState());
  }

  void deleteWindowsFromList(int id) {
    windowsList.removeWhere((e) => e.id == id);

    emit(DeleteWindowsFromListState());
  }

  List<MaterialList> accessoriesListTilt() =>
      materialList.isNotEmpty && windowsList.isNotEmpty
          ? [
              MaterialList(
                  size: 'زاوية تجميع',
                  length: '${cornerLength.toStringAsFixed(0)}'),
              MaterialList(
                  size: 'ذراع قلاب',
                  length:
                      '${(totalSashLength + totalPandaLength).toStringAsFixed(0)}'),
              MaterialList(
                  size: 'سكاك',
                  length:
                      '${(totalSashLength + totalPandaLength).toStringAsFixed(0)}'),
              if (totalFrameLength != 0)
                MaterialList(
                    size: 'زاوية صاج للحلق',
                    length: '${(totalFrameLength * 4).toStringAsFixed(0)}'),
              MaterialList(
                  size: 'كاوتش بار',
                  length: '${(materialList[0] / 100).toStringAsFixed(0)}متر '),
              MaterialList(
                  size: 'كاوتش منفاخ',
                  length:
                      '${(materialList[1] / 100 + materialList[2] / 100).toStringAsFixed(0)}متر '),
              MaterialList(
                  size: 'كاوتش مركزي',
                  length: '${(materialList[0] / 100).toStringAsFixed(0)}متر '),
              MaterialList(
                  size: 'كاوتش زجاج',
                  length:
                      '${(materialList[7] / 100 / 12 < 1 ? 1 : materialList[7] / 100 / 12).toStringAsFixed(0)}لفة '),
            ]
          : [];

  List<MaterialList> accessoriesList() =>
      materialList.isNotEmpty && windowsList.isNotEmpty
          ? [
              MaterialList(
                  size: 'زاوية تجميع',
                  length: '${cornerLength.toStringAsFixed(0)}'),
              MaterialList(
                  size: 'مفصلات', length: '${hingeLength.toStringAsFixed(0)}'),
              MaterialList(
                  size: 'أكرة سابليونة',
                  length: '${totalFrameLength.toStringAsFixed(0)}'),
              if (totalPandaLength != 0)
                MaterialList(
                    size: 'أكــرة الباندا',
                    length: '${totalPandaLength.toStringAsFixed(0)}'),
              if (tCenterLength != 0)
                MaterialList(
                    size: 'ترباس جنب',
                    length: '${(tCenterLength * 2).toStringAsFixed(0)}'),
              if (tCenterLength != 0)
                MaterialList(
                    size: 'طبة مرد الدرفة',
                    length: '${tCenterLength.toStringAsFixed(0)}'),
              if (totalFrameLength != 0)
                MaterialList(
                    size: 'زاوية صاج للحلق',
                    length: '${(totalFrameLength * 4).toStringAsFixed(0)}'),
              MaterialList(
                  size: 'كاوتش بار',
                  length: '${(materialList[0] / 100).toStringAsFixed(0)}متر '),
              MaterialList(
                  size: 'كاوتش منفاخ',
                  length:
                      '${(materialList[1] / 100 + materialList[2] / 100).toStringAsFixed(0)}متر '),
              MaterialList(
                  size: 'كاوتش مركزي',
                  length: '${(materialList[0] / 100).toStringAsFixed(0)}متر '),
              MaterialList(
                  size: 'كاوتش زجاج',
                  length:
                      '${((materialList[7] / 100 / 12 < 1 ? 1 : materialList[7] / 100 / 12).round())}لفة '),
              MaterialList(
                  size: 'فرش 7*10',
                  length:
                      '${(materialList[6] / 100 + materialList[8] / 100 * 2).toStringAsFixed(0)}متر '),
            ]
          : [];
  List<MaterialList> alList() => materialList.isNotEmpty &&
          windowsList.isNotEmpty
      ? [
          MaterialList(
              size: 'الحلق',
              length: '${(materialList[0] / 100).toStringAsFixed(1)} متر'),
          MaterialList(
              size: 'الدرفة',
              length: '${(materialList[1] / 100).toStringAsFixed(1)} متر'),
          if (materialList[2] != 0)
            MaterialList(
                size: 'الدرفة الباندا',
                length: '${(materialList[2] / 100).toStringAsFixed(1)} متر'),
          if (materialList[3] != 0)
            MaterialList(
                size: 'السلك الثابت',
                length: '${(materialList[3] / 100).toStringAsFixed(1)} متر'),
          if (materialList[4] != 0)
            MaterialList(
                size: 'السؤاس',
                length: '${(materialList[4] / 100).toStringAsFixed(1)} متر'),
          if (materialList[5] != 0)
            MaterialList(
                size: 'البـار',
                length: '${(materialList[5] / 100).toStringAsFixed(1)} متر'),
          if (materialList[6] != 0)
            MaterialList(
                size: 'مرد الدرفة',
                length: '${(materialList[6] / 100).toStringAsFixed(1)} متر'),
          if (materialList[7] != 0)
            MaterialList(
                size: 'الباكتات',
                length: '${(materialList[7] / 100).toStringAsFixed(1)} متر'),
          if (materialList[8] != 0)
            MaterialList(
                size: 'الجلسة',
                length: '${(materialList[8] / 100).toStringAsFixed(1)} متر'),
          MaterialList(size: '', length: ''),
          MaterialList(
              size: 'إجمالي مساحة الزجاج',
              length: '${kGlass.toStringAsFixed(2)} متر '),
          if (!windowsList.last.isPVC)
            MaterialList(
                size: 'إجمالي الوزن المتوقع',
                length: '${weightWindows.toStringAsFixed(2)} كجم'),
        ]
      : [];

  List<ResultData> result2Data() => [
        if (frameCollectList.isNotEmpty)
          ResultData('تجميع الحلوق', frameCollectList),
        if (frame4590CollectList.isNotEmpty)
          ResultData('تجميع حلوق 45وعدل', frame4590CollectList),
        if (sashCollectList.isNotEmpty)
          ResultData('تجميع الدرف', sashCollectList),
        if (sash4590CollectList.isNotEmpty)
          ResultData('تجميع درف 45وعدل', sash4590CollectList),
        if (sashPandaCollectList.isNotEmpty)
          ResultData(
              'تجميع الدرفة الباندا ${windowsList[0].isPVC ? '(درفة صغيرة)' : '(z صغير)'}',
              sashPandaCollectList),
        if (flyScreenCollectList.isNotEmpty)
          ResultData('تجميع السلك الثابت', flyScreenCollectList),
      ];
  List<ResultData> resultData() => [
        if (frameList.isNotEmpty) ResultData('تقطيع الحلوق', frameList),
        if (frame4590List.isNotEmpty)
          ResultData('تقطيع الحلوق 45وعدل', frame4590List),
        if (sashList.isNotEmpty) ResultData(' تقطيع الدرف ', sashList),
        if (sash4590List.isNotEmpty)
          ResultData('تقطيع الدرف 45وعدل', sash4590List),
        if (pandaList.isNotEmpty)
          ResultData(
              'تقطيع الدرفة الباندا ${windowsList[0].isPVC ? '(درفة صغيرة)' : '(z صغير)'}',
              pandaList),
        if (tList.isNotEmpty) ResultData('تقطيع السؤاس', tList),
        ResultData('تقطيع الباكتات', beadList),
        if (tCenterList.isNotEmpty) ResultData('تقطيع مرد الدرفة', tCenterList),
        if (flyScreenList.isNotEmpty)
          ResultData('تقطيع السلك الثابت', flyScreenList),
      ];

  List<ResultData> glassResultList() => [
        ResultData('تقرير الزجاج', glassList),
        if (glassFixedList.isNotEmpty)
          ResultData('حشو ثابت الدرفة', glassFixedList),
      ];

  List<ResultData> materialResultList() => [
        ResultData('تقرير الخامات', alList()),
        ResultData('تقرير الاكسسوارات',
            windowsList[0].isTilt ? accessoriesListTilt() : accessoriesList()),
      ];
  List<ResultData> titleList() => [
        ResultData('تقرير التجميع', result2Data()),
        ResultData('تقرير التقطيع', resultData(), true),
        ResultData('تقرير الزجاج', glassResultList()),
        ResultData('تقرير الخامات', materialResultList(), true),
      ];
}
