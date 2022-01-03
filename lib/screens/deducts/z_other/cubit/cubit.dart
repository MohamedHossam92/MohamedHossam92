import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/class.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/model/fly_screen_data.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/model/shade_data.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/model/shutter_data.dart';

class OtherDeductCubit extends Cubit<OtherDeductState> {
  OtherDeductCubit() : super(InitState());

  //========================التندا =======================================

  List<MyShadeData> shadeList = [];
  addItemToList(MyShadeData s) {
    shadeList.insert(0, s);
    emit(AddShadeState());
  }

  //========================السلك البيليسة =======================================

  List<ShutterData> shutterList = [];
  List<Size2AndLength> BoxList = [];
  List<Size2AndLength> coverList = [];
  List<SizeAndLength> streamList = [];
  List<FlyScreenFlyData> sliceList = [];
  List<SizeAndLength> underList = [];
  List<SizeAndLength> xList = [];
  num supportLength = 0, endLock = 0, endCap = 0;
  double totalBox = 0,
      totalCover = 0,
      totalStream = 0,
      totalUnder = 0,
      totalSlice = 0,
      totalX = 0;

  List<double> boxSizeList = [15, 16.5, 18, 20.5, 25, 30];

  String? sliceType;
  double? boxSize;

  Map<String, double> sliceTypeList = {
    'شريحة 4.5': 4.5,
    'شريحة 5.5': 5.5,
    'شريحة 5.8': 5.8,
    'زنكاليوم 5.5': 5.5,
    'حماية 5.5': 5.5,
    'حماية 5.5 مستقيمة': 5.5,
    'حماية 4.5': 4.5,
    'حماية ثقوب واسعة': 5.5,
  };

  detailsChange(int i, val) {
    if (i == 0) boxSize = val;
    if (i == 1) sliceType = val;
    emit(DetailsState());
  }

  addItemToShutterList(ShutterData s) {
    shutterList.insert(0, s);
    emit(AddShutterState());
  }

  addMaterialToLists() {
    clearList();
    for (var s in shutterList) {
      BoxList.add(Size2AndLength(
          size1: s.boxWidth(), size2: s.boxSize, length: s.length));
      coverList.add(Size2AndLength(
          size1: s.boxCoverSize(), size2: s.boxSize, length: s.length));
      streamList.add(SizeAndLength(size: s.streamSize(), length: s.length * 2));
      sliceList.add(FlyScreenFlyData(
          size1: s.sliceWidth(),
          size2: s.sliceType,
          length: s.sliceLength() * s.length));
      underList.add(SizeAndLength(size: s.underSize(), length: s.length));
      xList.add(SizeAndLength(size: s.xSize(), length: s.length));
      supportLength += s.supportLength() * s.length;
      endLock += (s.sliceLength() * s.length * 2);
      endCap += s.length;
    }

    for (var e in BoxList) {
      totalBox = (totalBox + (e.size1 * e.length));
    }
    for (var e in coverList) {
      totalCover = (totalCover + (e.size1 * e.length));
    }
    for (var e in streamList) {
      totalStream = (totalStream + (e.size * e.length));
    }

    for (var e in underList) {
      totalUnder = (totalUnder + (e.size * e.length));
    }

    for (var e in xList) {
      totalX = (totalX + (e.size * e.length));
    }

    for (var e in sliceList) {
      totalSlice = (totalSlice + (e.size1 * e.length));
    }
  }

  //========================بتخدم الكل =======================================

  removeItem(list, i) {
    list.removeAt(i);
    emit(RemoveState());
  }

  clearList([bool clearLists = false]) {
    if (clearLists) shadeList.clear();
    if (clearLists) shutterList.clear();
    BoxList.clear();
    coverList.clear();
    streamList.clear();
    sliceList.clear();
    underList.clear();
    xList.clear();
    if (clearLists) flyScreenList.clear();
    flyScreenFrame.clear();
    flyScreenSash.clear();
    flyScreenFly.clear();
    flyMaterialList.clear();
    flyScreenCollectList.clear();
    flyType = null;
    flySashLength = 0;
    sashLength = 1;
    isFlyUp = false;
    flyScreenTotalLength = 0;
    areaFlyScreen = 0;
    supportLength = 0;
    endLock = 0;
    endCap = 0;
    totalBox = 0;
    totalCover = 0;
    totalStream = 0;
    totalUnder = 0;
    totalSlice = 0;
    totalX = 0;
    emit(ClearState());
  }

//========================السلك البيليسة =======================================
  List<FlyScreenData> flyScreenList = [];
  List<SizeAndLength> flyScreenFrame = [];
  List<SizeAndLength> flyScreenSash = [];
  List<FlyScreenFlyData> flyScreenFly = [];
  List<Size2AndLength> flyScreenCollectList = [];

  String? flyType;
  int flySashLength = 0, sashLength = 1;
  bool isFlyUp = false;
  List<String> flyTypeList = [
    'شركة الاتحاد',
    'كومبن - ComPen',
    'شركة SM',
    'شركة قباري'
  ];
  List<double> flyMaterialList = [];
  int flyScreenTotalLength = 0;
  double areaFlyScreen = 0;

  flyDirectionChange(val) {
    flySashLength = val;
    sashLength = val + 1;
    emit(FlyDirectionChange());
  }

  isFlyUpChange(val) {
    isFlyUp = val;
    emit(IsFlyUpState());
  }

  flyTypeChange(val) {
    flyType = val;
    emit(IsFlyUpState());
  }

  addItemToFlyScreen(FlyScreenData f) {
    flyScreenList.insert(0, f);
    emit(AddFlyScreenState());
  }

  addFlyScreenDataToLists() {
    clearList();

    for (var f in flyScreenList) {
      flyScreenFrame.addAll([
        SizeAndLength(size: f.widthFrame(), length: f.length * 2),
        SizeAndLength(size: f.heightFrame(), length: f.length * 2),
      ]);

      flyScreenSash.add(
          SizeAndLength(size: f.sashFrame(), length: f.sashLength * f.length));

      flyScreenFly.add(FlyScreenFlyData(
          size1: f.flyScreenWithSash(),
          size2: ' ${f.flyScreenZigZag().round()} كسرة ',
          length: f.sashLength * f.length));

      flyScreenCollectList.add(
          Size2AndLength(size1: f.width, size2: f.height, length: f.length));

      flyScreenTotalLength += f.length;
      areaFlyScreen += f.area();
    }

    List<List<SizeAndLength>> sizeList = [
      flyScreenFrame,
      flyScreenSash,
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

    List<List<Size2AndLength>> size2List = [flyScreenCollectList];

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

    List<List<SizeAndLength>> size1List = [flyScreenFrame, flyScreenSash];

    for (var data in size1List) {
      double size = 0;
      for (var e in data) {
        size = (size + (e.size * e.length));
      }
      flyMaterialList.add(size);
    }

    emit(AddFlyScreenDataToListsState());
  }

  List<MaterialList> AlList() => flyMaterialList.isNotEmpty
      ? [
          MaterialList(
              size: 'الإطار',
              length:
                  '${(flyMaterialList.isEmpty ? 590 : flyMaterialList[0] / 590).toStringAsFixed(1)} عود'),
          MaterialList(
              size: 'الدرفة',
              length:
                  '${(flyMaterialList.isEmpty ? 590 : flyMaterialList[1] / 590).toStringAsFixed(1)} عود'),
          MaterialList(size: '', length: ''),
          MaterialList(size: 'طقم تجميع', length: '$flyScreenTotalLength طقم'),
          MaterialList(
              size: 'مساحة السلك',
              length: '${areaFlyScreen.toStringAsFixed(1)}  م'),
        ]
      : [];

  List<MaterialList> shutterMaterial() => [
        MaterialList(
            size: 'الشريحة',
            length: '${(totalSlice / 590).toStringAsFixed(1)} عود'),
        MaterialList(
            size: 'المجري',
            length: '${(totalStream / 590).toStringAsFixed(1)} عود'),
        MaterialList(
            size: 'السفلية',
            length: '${(totalUnder / 590).toStringAsFixed(1)} عود'),
        MaterialList(
            size: 'الصندوق',
            length: '${(totalBox / 590).toStringAsFixed(1)} عود'),
        MaterialList(
            size: 'الغطاء',
            length: '${(totalCover / 590).toStringAsFixed(1)} عود'),
        MaterialList(
            size: 'المحور', length: '${(totalX / 590).toStringAsFixed(1)} عود'),
      ];

  List<MaterialList> shutterAccessories() => [
        MaterialList(size: 'حمالة أمان', length: '${supportLength}  '),
        MaterialList(size: 'سدة الشريحة', length: '${endLock}  '),
        MaterialList(size: 'رولمان بلي', length: '${endCap}  '),
        MaterialList(size: 'حامل الرولمان', length: '${(endCap)}  '),
        MaterialList(size: 'كباية', length: '${(endCap)}  '),
        MaterialList(size: 'خدين الصندوق', length: '${(endCap)}  '),
        MaterialList(size: 'صاجة خد الصندوق', length: '${(endCap)}  '),
        MaterialList(size: 'آلة التحريك', length: '${(endCap)} '),
      ];
}

class FlyScreenFlyData {
  final double size1;
  final int length;
  final String size2;

  FlyScreenFlyData(
      {required this.size1, required this.size2, required this.length});
}
