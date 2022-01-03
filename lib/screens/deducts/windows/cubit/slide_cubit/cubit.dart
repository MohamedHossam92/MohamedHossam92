import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/class.dart';
import 'package:the_smart_workshop/screens/deducts/windows/cubit/slide_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/windows/models/fixed_data.dart';
import 'package:the_smart_workshop/screens/deducts/windows/models/slide_data.dart';
import 'package:the_smart_workshop/sql/slide_windows/const.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/cubit.dart';

class SlideCubit extends Cubit<SlideState> {
  SlideCubit() : super(InitSlideState());

  List<SlideData> windowsList = [];
  List<SizeAndLength> frameList = [];
  List<SizeAndLength> frame3SashList = [];
  List<SizeAndLength> frameListWithoutBar = [];
  List<SizeAndLength> barList = [];
  List<SizeAndLength> sashList = [];
  List<SizeAndLength> flyScreenList = [];
  List<SizeAndLength> hookList = [];
  List<SizeAndLength> adjoiningList = [];
  List<SizeAndLength> trackList = [];
  //=================التجميع =======================
  List<Size2AndLength> frameCollectList = [];
  List<Size2AndLength> sashCollectList = [];
  List<Size2AndLength> flyScreenCollectList = [];
  //=================الثوابت =======================
  List<FixedData> fixedCollectList = [];
  List<SizeAndLength> fixedFrameList = [];
  List<SizeAndLength> fixedTList = [];
  List<SizeAndLength> fixedBeadList = [];
  List<SizeAndLength> collectList = [];
  //=================الزجاج =======================
  List<Size2AndLength> glassList = [];

  double glassMaterial = 0;
  double weightWindows = 0;
  double totalSashAccessories = 0,
      totalFrameLength = 0,
      totalFlyScreenLength = 0,
      cornerLength = 0,
      fixedCornerLength = 0;
  double cornerMetalFrame = 0, cornerMetalSash = 0;

  int lock2Length = 0, lock4Length = 0;

  pvcCutting(double num) => windowsList[0].isPVC ? num + .6 : num;

  void insertWindowsToList(SlideData s) {
    windowsList.insert(0, s);
    emit(InsertWindowsToListState());
  }

  addItemsToList() async {
    await clearWindowsList(false);
    for (var s in windowsList) {
      frameCollectList.add(Size2AndLength(
          size1: s.finalWidth(),
          size2: s.finalHeight(),
          length: s.windowsLength));

      sashCollectList.add(Size2AndLength(
          size1: s.resultSashWidth(),
          size2: s.windowsType == '$qPS$qPS9600' && s.sashLength == 1
              ? s.resultSashHeight() + 2.7
              : s.resultSashHeight(),
          length: s.sashCollectLength()));

      flyScreenCollectList.add(Size2AndLength(
          size1: s.resultFlyScreenWidth(),
          size2: s.windowsType == '$qPS$qPS9600' && s.sashLength == 1
              ? s.resultFlyScreenHeight() + 2.7
              : s.resultFlyScreenHeight(),
          length: s.flyScreenCollectLength()));

      if (s.isLeftFixed || s.isRightFixed || s.isBottomFixed || s.isTopFixed)
        frameListWithoutBar.addAll([
          SizeAndLength(
              size: pvcCutting(s.finalWidth()), length: s.frameCuttingLength()),
          SizeAndLength(
              size: pvcCutting(s.finalHeight()),
              length: s.frameCuttingLength()),
        ]);
      else if (s.sashLength == 1)
        frame3SashList.addAll([
          SizeAndLength(
              size: pvcCutting(s.finalWidth()), length: s.frameCuttingLength()),
          SizeAndLength(
              size: pvcCutting(s.finalHeight()),
              length: s.frameCuttingLength()),
        ]);
      else
        frameList.addAll([
          SizeAndLength(
              size: pvcCutting(s.finalWidth()), length: s.frameCuttingLength()),
          SizeAndLength(
              size: pvcCutting(s.finalHeight()),
              length: s.frameCuttingLength()),
        ]);

      sashList.addAll([
        SizeAndLength(
            size: pvcCutting(s.resultSashWidth()),
            length: s.sashCuttingLength()),
        SizeAndLength(
            size: s.windowsType == '$qPS$qPS9600' && s.sashLength == 1
                ? s.resultSashHeight() + 2.7
                : pvcCutting(s.resultSashHeight()),
            length: s.sashCuttingLength()),
      ]);
      flyScreenList.addAll([
        SizeAndLength(
            size: pvcCutting(s.resultFlyScreenWidth()),
            length: s.flyScreenCuttingLength()),
        SizeAndLength(
            size: s.windowsType == '$qPS$qPS9600' && s.sashLength == 1
                ? s.resultFlyScreenHeight() + 2.7
                : pvcCutting(s.resultFlyScreenHeight()),
            length: s.flyScreenCuttingLength()),
      ]);

      if (windowsList[0].isPVC)
        fixedBeadList.addAll([
          SizeAndLength(
              size: (s.widthGlass() + .5), length: (s.sashCollectLength() * 2)),
          SizeAndLength(
              size: (s.heightGlass() + .5),
              length: (s.sashCollectLength() * 2)),
        ]);
      hookList.add(
          SizeAndLength(size: s.resultHook(), length: s.hookCuttingLength()));

      if (s.sashLength == 0 || s.sashLength == 4) {
        adjoiningList.add(
            SizeAndLength(size: s.resultAdjoining(), length: s.windowsLength));
      }

      glassList.add(Size2AndLength(
          size1: s.widthGlass(),
          size2: s.windowsType == '$qPS$qPS9600' && s.sashLength == 1
              ? s.heightGlass() + 2.7
              : s.heightGlass(),
          length: s.sashCollectLength()));

      //============ الاكسسوارات ============

      lock2Length += s.windowsLength * (s.sashLength == 0 ? 1 : 2);
      if (s.sashLength == 0 || s.sashLength == 4)
        lock4Length += s.windowsLength;

      cornerLength +=
          s.windowsLength * 4 + s.sashLengthFinal() * s.windowsLength * 4;
      if (windowsList[0].windowsType == '$qPS$qPS9600')
        cornerLength += s.windowsLength * 4;

      cornerMetalFrame += s.windowsLength * 4;
      cornerMetalSash += s.sashLengthFinal() * s.windowsLength * 8;

      totalSashAccessories += (s.sashLengthFinal() * s.windowsLength) / 2;

      totalFrameLength += s.windowsLength;

      totalFlyScreenLength += s.flyScreenLength() * s.windowsLength;

      //============ الثوابت ============

      if (s.isTopFixed)
        fixedCollectList.add(FixedData(
            size1: s.windowsWidth,
            size2: s.topFixedSize,
            tSize: s.tSize,
            suctionSize: s.topFixedSize,
            tLength: s.topFixedLength,
            fixSize: s.fixSize,
            length: s.windowsLength,
            beadSize: s.beadSize,
            isH: true));
      if (s.isBottomFixed)
        fixedCollectList.add(FixedData(
            size1: s.windowsWidth,
            size2: s.bottomFixedSize,
            tSize: s.tSize,
            suctionSize: s.bottomFixedSize,
            tLength: s.bottomFixedLength,
            fixSize: s.fixSize,
            length: s.windowsLength,
            beadSize: s.beadSize,
            isH: true));
      if (s.isRightFixed)
        fixedCollectList.add(FixedData(
          size1: s.rightFixedSize,
          size2: s.finalHeight(),
          tSize: s.tSize,
          suctionSize: s.rightFixedSize,
          tLength: s.rightFixedLength,
          fixSize: s.fixSize,
          length: s.windowsLength,
          beadSize: s.beadSize,
          isV: true,
        ));
      if (s.isLeftFixed)
        fixedCollectList.add(FixedData(
          size1: s.leftFixedSize,
          size2: s.finalHeight(),
          tSize: s.tSize,
          suctionSize: s.leftFixedSize,
          tLength: s.rightFixedLength,
          fixSize: s.fixSize,
          length: s.windowsLength,
          beadSize: s.beadSize,
          isV: true,
        ));

      if (s.isTopFixed || s.isBottomFixed || s.isRightFixed || s.isLeftFixed)
        barList.addAll([
          SizeAndLength(
              size: s.windowsWidth + s.barDeduct!,
              length: s.frameCuttingLength()),
          SizeAndLength(
              size: s.windowsHeight + s.barDeduct!,
              length: s.frameCuttingLength()),
        ]);

      if (s.isPVC)
        trackList.add(
            SizeAndLength(size: s.trackWidth(), length: s.windowsLength * 2));
    }
    //============ الثوابت ============

    for (var data in fixedCollectList) {
      fixedFrameList.addAll([
        SizeAndLength(size: pvcCutting(data.size1), length: data.length * 2),
        SizeAndLength(size: pvcCutting(data.size2), length: data.length * 2),
      ]);
      glassList.add(Size2AndLength(
          size1: data.widthGlass(),
          size2: data.heightGlass(),
          length: (data.tLength + 1) * data.length));
      fixedTList.add(SizeAndLength(
          size: data.cutTSize(), length: data.tLength * data.length));
      fixedBeadList.addAll([
        SizeAndLength(
            size: data.widthGlass() + .5,
            length: (data.tLength + 1) * data.length * 2),
        SizeAndLength(
            size: data.heightGlass() + .5 - data.beadSize * 2,
            length: (data.tLength + 1) * data.length * 2),
      ]);
      collectList.add(SizeAndLength(
          size: data.isH ? data.size1 - 2.3 : data.size2 - 2.3,
          length: data.length));

      fixedCornerLength += data.length * 4;
    }
    emit(AddNewWindowsToListState());
  }

  sortLists() {
    List<List<SizeAndLength>> sizeList = [
      frameList,
      frameListWithoutBar,
      frame3SashList,
      sashList,
      flyScreenList,
      hookList,
      adjoiningList,
      fixedFrameList,
      fixedTList,
      fixedBeadList,
      collectList,
      barList,
      trackList
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
      glassList,
      frameCollectList,
      sashCollectList,
      flyScreenCollectList
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

  List<double> materialList = [];

  materialsList() {
    materialList.clear();

    List<List<SizeAndLength>> size1List = [
      frameList,
      frameListWithoutBar,
      frame3SashList,
      sashList,
      flyScreenList,
      hookList,
      adjoiningList,
      fixedFrameList,
      barList,
      fixedTList,
      fixedBeadList,
      collectList,
      trackList
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

    for (var data in glassList) {
      glassMaterial =
          (glassMaterial + (data.size1 * data.size2 * data.length * .0001));
    }

    for (var data in slideDeductListDb!) {
      if (windowsList.isNotEmpty) {
        if (data[cSWindowsProfile] == windowsList[0].windowsType) {
          weightWindows = ((materialList[0] * data[cSWeightFrame]) +
                  (materialList[1] * data[cSWeightFrameWithoutBar]) +
                  (materialList[2] * data[cSWeightFrame]) +
                  (materialList[3] * data[cSWeightSash]) +
                  (materialList[4] * data[cSWeightFlyScreen]) +
                  (materialList[5] * data[cSWeightHook]) +
                  (materialList[6] * data[cSWeightAdjoining]) +
                  (materialList[7] * data[cSWeightFix]) +
                  (materialList[8] * data[cSWeightT]) +
                  (materialList[9] * data[cSWeightBead]) +
                  (materialList[10] * data[cSWeightBar]) +
                  (materialList[11] * data[cSWeightCollect])) *
              .01;
        }
      }
    }

    emit(MaterialsList());
  }

  void deleteWindowsFromList(int id) {
    windowsList.removeWhere((e) => e.id == id);

    emit(DeleteWindowsFromListState());
  }

  clearWindowsList([isClear = true]) {
    if (isClear) windowsList.clear();
    frameCollectList.clear();
    sashCollectList.clear();
    flyScreenCollectList.clear();

    sashList.clear();
    frameList.clear();
    frameListWithoutBar.clear();
    frame3SashList.clear();
    flyScreenList.clear();
    glassList.clear();
    hookList.clear();
    adjoiningList.clear();
    materialList.clear();
    trackList.clear();
    fixedCollectList.clear();
    fixedFrameList.clear();
    fixedBeadList.clear();
    fixedTList.clear();
    barList.clear();
    collectList.clear();
    glassMaterial = 0;
    weightWindows = 0;
    totalSashAccessories = 0;
    totalFrameLength = 0;
    cornerLength = 0;
    fixedCornerLength = 0;
    cornerMetalFrame = 0;
    cornerMetalSash = 0;
    totalFlyScreenLength = 0;
    lock2Length = 0;
    lock4Length = 0;

    emit(ClearWindowsListState());
  }

  List<MaterialList> accessoriesList() =>
      windowsList.isNotEmpty && materialList.isNotEmpty
          ? [
              if (!windowsList.last.isPVC)
                MaterialList(
                    size: 'زاوية تجميع',
                    length: '${cornerLength.toStringAsFixed(0)}'),
              MaterialList(
                  size: 'طقم عجل',
                  length: '${(totalSashAccessories).toStringAsFixed(0)}'),
              MaterialList(
                  size: 'سكاك جنب',
                  length: '${(lock2Length / 2).toStringAsFixed(0)}'),
              MaterialList(
                  size: 'سكاك أكرة',
                  length: '${(lock2Length / 2).toStringAsFixed(0)}'),
              if (windowsList.last.isPVC)
                MaterialList(
                    size: 'سابليونة',
                    length: '${(lock2Length).toStringAsFixed(0)}'),
              if (lock4Length != 0)
                MaterialList(
                    size: 'سكاك 4 درفة',
                    length: '${lock4Length.toStringAsFixed(0)}'),
              if (!windowsList.last.isPVC) ...[
                if (fixedCornerLength != 0)
                  MaterialList(
                      size: 'زاوية تجميع الثابت',
                      length: '${fixedCornerLength.toStringAsFixed(0)}'),
                MaterialList(
                    size: 'زاوية صاج للحلق',
                    length: '${cornerMetalFrame.toStringAsFixed(0)}'),
                MaterialList(
                    size: 'زاوية صاج للدرفة',
                    length: '${cornerMetalSash.toStringAsFixed(0)}'),
                MaterialList(
                    size: 'دليل السكينة',
                    length: '${totalSashAccessories.toStringAsFixed(0)}'),
                MaterialList(
                    size: 'مانع ارتجاج',
                    length: '${totalFrameLength.toStringAsFixed(0)}'),
                MaterialList(
                    size: 'طقم تجميع سلك',
                    length: '${totalFlyScreenLength.toStringAsFixed(0)}'),
                MaterialList(size: '', length: ''),
                MaterialList(
                    size: 'فُرش 7*10',
                    length:
                        '${(materialList[3] / 100 * 2).toStringAsFixed(0)}متر'),
                MaterialList(
                    size: 'فُرش 5*5',
                    length: '${(materialList[4] / 100).toStringAsFixed(0)}متر'),
                MaterialList(
                    size: 'كاوتش 3 خط',
                    length:
                        '${(materialList[3] / 100 * .8).toStringAsFixed(0)}متر'),
                MaterialList(
                    size: 'كاوتش بار',
                    length:
                        '${(materialList[0] / 100 + materialList[8] / 100 + materialList[2] / 100).toStringAsFixed(0)}متر '),
                MaterialList(
                    size: 'كاوتش زجاج',
                    length:
                        '${(materialList[3] / 100 / 12 < 1 ? 1 : materialList[3] / 100 / 12).toStringAsFixed(0)}لفة'),
                MaterialList(
                    size: 'كاوتش سلك',
                    length:
                        '${(materialList[4] / 100 / 60 < 1 ? 1 : materialList[3] / 100 / 60).toStringAsFixed(0)}لفة'),
              ]
            ]
          : [];
  List<MaterialList> alList() {
    if (materialList.isNotEmpty)
      return [
        if (materialList[0] != 0)
          MaterialList(
              size: 'حلق ببار',
              length: '${(materialList[0] / 100).toStringAsFixed(1)} متر'),
        if (materialList[1] != 0)
          MaterialList(
              size: 'حلق بدون بار',
              length: '${(materialList[1] / 100).toStringAsFixed(1)} متر'),
        if (materialList[2] != 0)
          MaterialList(
              size: 'حلق 3 سكة',
              length: '${(materialList[2] / 100).toStringAsFixed(1)} متر'),
        if (materialList[3] != 0)
          MaterialList(
              size: 'الدرفة',
              length: '${(materialList[3] / 100).toStringAsFixed(1)} متر'),
        if (materialList[4] != 0)
          MaterialList(
              size: 'السلك',
              length: '${(materialList[4] / 100).toStringAsFixed(1)} متر'),
        if (materialList[5] != 0)
          MaterialList(
              size: 'السكينة',
              length: '${(materialList[5] / 100).toStringAsFixed(1)} متر'),
        if (materialList[6] != 0)
          MaterialList(
              size: 'التقابل',
              length: '${(materialList[6] / 100).toStringAsFixed(1)} متر'),
        if (materialList[7] != 0)
          MaterialList(
              size: 'الثابت',
              length: '${(materialList[7] / 100).toStringAsFixed(1)} متر'),
        if (materialList[8] != 0)
          MaterialList(
              size: 'البار',
              length: '${(materialList[8] / 100).toStringAsFixed(1)} متر'),
        if (materialList[9] != 0)
          MaterialList(
              size: 'السؤاس',
              length: '${(materialList[9] / 100).toStringAsFixed(1)} متر'),
        if (materialList[10] != 0)
          MaterialList(
              size: 'الباكتة',
              length: '${(materialList[10] / 100).toStringAsFixed(1)} متر'),
        if (materialList[11] != 0)
          MaterialList(
              size: 'المشترك',
              length: '${(materialList[11] / 100).toStringAsFixed(1)} متر'),
        if (materialList[12] != 0)
          MaterialList(
              size: 'التراك',
              length: '${(materialList[12] / 100).toStringAsFixed(1)} متر'),
        MaterialList(size: '', length: ''),
        MaterialList(
            size: 'إجمالي مساحة الزجاج',
            length: '${glassMaterial.toStringAsFixed(2)} متر '),
        if (weightWindows != 0)
          MaterialList(
              size: 'إجمالي الوزن المتوقع',
              length: '${weightWindows.toStringAsFixed(2)} كجم'),
      ];
    else
      return [];
  }

  List<ResultData> result2Data() => [
        ResultData('تجميع الحلوق', frameCollectList),
        ResultData('تجميع الدرف', sashCollectList),
        ResultData('تجميع السلك', flyScreenCollectList),
        if (fixedCollectList.isNotEmpty)
          ResultData('تجميع الثوابت', fixedCollectList),
      ];
  List<ResultData> resultData() => [
        if (frameList.isNotEmpty) ResultData('تقطيع الحلق ببار', frameList),
        if (frame3SashList.isNotEmpty)
          ResultData('تقطيع الحلق 3 سكة', frame3SashList),
        if (frameListWithoutBar.isNotEmpty)
          ResultData('تقطيع الحلق بدون بار', frameListWithoutBar),
        ResultData('تقطيع الدرف', sashList),
        ResultData('تقطيع السلك', flyScreenList),
        ResultData('تقطيع السكينة', hookList),
        if (fixedFrameList.isNotEmpty)
          ResultData('تقطيع الثابت', fixedFrameList),
        if (barList.isNotEmpty) ResultData('تقطيع البار', barList),
        if (fixedTList.isNotEmpty) ResultData('تقطيع السؤاس', fixedTList),
        if (fixedBeadList.isNotEmpty)
          ResultData('تقطيع الباكتة', fixedBeadList),
        if (collectList.isNotEmpty) ResultData('تقطيع المشترك', collectList),
        if (trackList.isNotEmpty) ResultData('تقطيع التراك', trackList),
      ];

  List<ResultData> glassResultList() => [
        ResultData('تقرير الزجاج', glassList),
      ];

  List<ResultData> materialResultList() => [
        ResultData('تقرير الخامات', alList()),
        ResultData('تقرير الاكسسوارات', accessoriesList()),
      ];
  List<ResultData> titleList() => [
        ResultData('تقرير التجميع', result2Data()),
        ResultData('تقرير التقطيع', resultData(), true),
        ResultData('تقرير الزجاج', glassResultList()),
        ResultData('تقرير الخامات', materialResultList(), true),
      ];
}
