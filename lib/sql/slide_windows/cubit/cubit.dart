import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/state.dart';

import '../const.dart';
import '../data.dart';
import '../slide_deduct_list.dart';

List<Map>? slideDeductListDb = [];
List oneSlideSystemList = [];

class SQLSlideCubit extends Cubit<SQLSlideState> {
  SQLSlideCubit() : super(InitState());

  Database? _db;

  Future<Database> createDb() async {
    String path = join(await getDatabasesPath(), 'swTalSlide.db');
    return _db ??
        await openDatabase(path, version: 1, onCreate: (db, v) {
          db.execute('CREATE TABLE $cSTableName (' +
              '$cSId INTEGER PRIMARY KEY AUTOINCREMENT,' +
              '$cSCountry TEXT,' +
              '$cSWindowsSystem TEXT,' +
              '$cSWindowsProfile TEXT,' +
              '$cSWidthSashDeduct2 REAL,' +
              '$cSWidthSashDeduct4 REAL,' +
              '$cSWidthSashDeduct32 REAL,' +
              '$cSWidthSashDeduct33 REAL,' +
              '$cSWidthFlyScreenDeduct2 REAL,' +
              '$cSWidthFlyScreenDeduct4 REAL,' +
              '$cSWidthFlyScreenDeduct32 REAL,' +
              '$cSWidthFlyScreenDeduct33 REAL,' +
              '$cSHeightSashDeduct REAL,' +
              '$cSHeightFluScreenDeduct REAL,' +
              '$cSHeightHookDeduct REAL,' +
              '$cSHeightAdjoiningDeduct REAL,' +
              '$cSWidthGlassDeduct REAL,' +
              '$cSHeightGlassDeduct REAL,' +
              '$cSFrameFixSize REAL,' +
              '$cSBeadSize REAL,' +
              '$cSTrackDeduct REAL,' +
              '$cSWeightFrame REAL,' +
              '$cSWeightFrameWithoutBar REAL,' +
              '$cSWeightSash REAL,' +
              '$cSWeightFlyScreen REAL,' +
              '$cSWeightHook REAL,' +
              '$cSWeightAdjoining REAL,' +
              '$cSWeightFix REAL,' +
              '$cSWeightT REAL,' +
              '$cSWeightBead REAL,' +
              '$cSWeightBar REAL,' +
              '$cSWeightCollect REAL' +
              ')');
        });
  }

  //===============insertData=================
  Future<void> insertDataToDb(SlideDeduct slideDeduct) async {
    Database db = await createDb();

    db.insert(cSTableName, slideDeduct.toMap()).then((value) {
      emit(InsertDataToDb());
      getDataFromDb().then((value) => emit(GetDataFromDb()));
    });
  }

  //==================getData===============

  Future<List<Map>?> getDataFromDb() async {
    Database db = await createDb();
    return db.query(cSTableName).then((value) {
      slideDeductListDb = value;
      emit(GetDataFromDb());
    });
  }

//===================deleteData===================
  Future<void> deleteDataFromDb(int id) async {
    Database db = await createDb();
    db.delete(cSTableName, where: '$cSId = ?', whereArgs: [id]).then((value) {
      getDataFromDb().then((value) => emit(GetDataFromDb()));
      emit(DeleteDataFromDb());
    });
  }

  Future updateData(SlideDeduct slideDeduct) async {
    Database db = await createDb();
    db.update(cSTableName, slideDeduct.toMap(),
        where: '$cSId = ?', whereArgs: [id]).then((value) {
      getDataFromDb().then((value) => emit(GetDataFromDb()));

      emit(UpdateData());
    });
  }
  //===============insertAllData=================

  void insertAllDeduct() {
    for (var data in allSlideDeductList) {
      insertDataToDb(data);
    }
  }

  void addOneSystemList(String systemName) {
    oneSlideSystemList.clear();
    for (var data in slideDeductListDb!)
      if (data[cSWindowsSystem] == systemName) oneSlideSystemList.add(data);
    emit(SystemNameChange());
  }

//===================== اضافة تخصيم جديد ====================
  int? id;
  String? country, windowsSystem, windowsProfile;
  double? widthSashDeduct2,
      widthSashDeduct4,
      widthSashDeduct32,
      widthSashDeduct33;
  double? widthFlyScreenDeduct2,
      widthFlyScreenDeduct4,
      widthFlyScreenDeduct32,
      widthFlyScreenDeduct33;
  double? heightSashDeduct, heightFluScreenDeduct;
  double? heightHookDeduct, heightAdjoiningDeduct;
  double? widthGlassDeduct, heightGlassDeduct;
  double? weightFrame,
      weightFrameWithoutBar,
      weightSash,
      weightFlyScreen,
      weightHook,
      weightAdjoining,
      weightFix,
      weightT,
      weightBead,
      weightBar,
      weightCollect;
  double? frameFixSize, deductTrack, beadSize;

  int validate = -1;
  validateInc([int i = 0]) {
    if (i == 1) validate = -1;
    validate++;
    emit(ValidateIncState());
  }

  sashOnChange(int i, String? val) {
    if (i == 0) widthSashDeduct2 = double.parse(val!) * .1;
    if (i == 1) widthSashDeduct33 = double.parse(val!) * .1;
    if (i == 2) widthSashDeduct32 = double.parse(val!) * .1;
    if (i == 3) widthSashDeduct4 = double.parse(val!) * .1;
    if (i == 4) heightSashDeduct = double.parse(val!) * .1;
    emit(SashOnChangeState());
  }

  flyScreenOnChange(int i, String? val) {
    if (i == 0) widthFlyScreenDeduct2 = double.parse(val!) * .1;
    if (i == 1) widthFlyScreenDeduct33 = double.parse(val!) * .1;
    if (i == 2) widthFlyScreenDeduct32 = double.parse(val!) * .1;
    if (i == 3) widthFlyScreenDeduct4 = double.parse(val!) * .1;
    if (i == 4) heightFluScreenDeduct = double.parse(val!) * .1;
    emit(FlyScreenOnChangeState());
  }

  otherOnChange(int i, String? val) {
    if (i == 0) heightHookDeduct = double.parse(val!) * .1;
    if (i == 1) heightAdjoiningDeduct = double.parse(val!) * .1;
    if (i == 2) frameFixSize = double.parse(val!) * .1;
    if (i == 3) windowsProfile = val;
    if (i == 4) deductTrack = double.parse(val!) * .1;
    if (i == 5) beadSize = double.parse(val!) * .1;
    emit(OtherOnChangeState());
  }

  glassOnChange(int i, String? val) {
    if (i == 0) widthGlassDeduct = double.parse(val!) * .1;
    if (i == 1) heightGlassDeduct = double.parse(val!) * .1;
    emit(GlassOnChangeState());
  }

  weightOnChange(int i, String? val) {
    if (i == 0) weightFrame = double.parse(val!) / 6.5;
    if (i == 1) weightFrameWithoutBar = double.parse(val!) / 6.5;
    if (i == 2) weightSash = double.parse(val!) / 6.5;
    if (i == 3) weightFlyScreen = double.parse(val!) / 6.5;
    if (i == 4) weightHook = double.parse(val!) / 6.5;
    if (i == 5) weightAdjoining = double.parse(val!) / 6.5;
    if (i == 6) weightFix = double.parse(val!) / 6.5;
    if (i == 7) weightT = double.parse(val!) / 6.5;
    if (i == 8) weightBead = double.parse(val!) / 6.5;
    if (i == 9) weightBar = double.parse(val!) / 6.5;

    emit(WeightOnChangeState());
  }
//===================== تعديل التخصيمات ====================

  editDeducts({
    idOld,
    countryOld,
    windowsSystemOld,
    windowsProfileOld,
    widthSashDeduct2Old,
    widthSashDeduct4Old,
    widthSashDeduct32Old,
    widthSashDeduct33Old,
    widthFlyScreenDeduct2Old,
    widthFlyScreenDeduct4Old,
    widthFlyScreenDeduct32Old,
    widthFlyScreenDeduct33Old,
    heightSashDeductOld,
    heightFluScreenDeductOld,
    heightHookDeductOld,
    heightAdjoiningDeductOld,
    widthGlassDeductOld,
    heightGlassDeductOld,
    weightFrameOld,
    weightFrameWithoutBarOld,
    weightSashOld,
    weightFlyScreenOld,
    weightHookOld,
    weightAdjoiningOld,
    weightFixOld,
    weightTOld,
    weightBeadOld,
    weightBarOld,
    weightCollectOld,
    frameFixSizeOld,
    beadSizeOld,
    trackDeductSizeOld,
  }) {
    id = idOld;
    country = countryOld;
    windowsSystem = windowsSystemOld;
    windowsProfile = windowsProfileOld;
    widthSashDeduct2 = widthSashDeduct2Old;
    widthSashDeduct4 = widthSashDeduct4Old;
    widthSashDeduct32 = widthSashDeduct32Old;
    widthSashDeduct33 = widthSashDeduct33Old;
    widthFlyScreenDeduct2 = widthFlyScreenDeduct2Old;
    widthFlyScreenDeduct4 = widthFlyScreenDeduct4Old;
    widthFlyScreenDeduct32 = widthFlyScreenDeduct32Old;
    widthFlyScreenDeduct33 = widthFlyScreenDeduct33Old;
    heightSashDeduct = heightSashDeductOld;
    heightFluScreenDeduct = heightFluScreenDeductOld;
    heightHookDeduct = heightHookDeductOld;
    heightAdjoiningDeduct = heightAdjoiningDeductOld;
    widthGlassDeduct = widthGlassDeductOld;
    heightGlassDeduct = heightGlassDeductOld;
    weightFrame = weightFrameOld;
    weightFrameWithoutBar = weightFrameWithoutBarOld;
    weightSash = weightSashOld;
    weightFlyScreen = weightFlyScreenOld;
    weightHook = weightHookOld;
    weightAdjoining = weightAdjoiningOld;
    weightFix = weightFixOld;
    weightT = weightTOld;
    weightBead = weightBeadOld;
    weightBar = weightBarOld;
    frameFixSize = frameFixSizeOld;
    beadSize = beadSizeOld;
    deductTrack = trackDeductSizeOld;

    List textFieldValue = [
      windowsProfile!,
      (widthSashDeduct2! * 10).toStringAsFixed(0),
      (widthSashDeduct4! * 10).toStringAsFixed(0),
      (widthSashDeduct32! * 10).toStringAsFixed(0),
      (widthSashDeduct33! * 10).toStringAsFixed(0),
      (heightSashDeduct! * 10).toStringAsFixed(0),
      (widthFlyScreenDeduct2! * 10).toStringAsFixed(0),
      (widthFlyScreenDeduct4! * 10).toStringAsFixed(0),
      (widthFlyScreenDeduct32! * 10).toStringAsFixed(0),
      (widthFlyScreenDeduct33! * 10).toStringAsFixed(0),
      (heightFluScreenDeduct! * 10).toStringAsFixed(0),
      (heightHookDeduct! * 10).toStringAsFixed(0),
      (heightAdjoiningDeduct! * 10).toStringAsFixed(0),
      (widthGlassDeduct! * 10).toStringAsFixed(0),
      (heightGlassDeduct! * 10).toStringAsFixed(0),
      (weightFrame! * 6.5).toStringAsFixed(1),
      (weightFrameWithoutBar! * 6.5).toStringAsFixed(1),
      (weightSash! * 6.5).toStringAsFixed(1),
      (weightFlyScreen! * 6.5).toStringAsFixed(1),
      (weightHook! * 6.5).toStringAsFixed(1),
      (weightAdjoining! * 6.5).toStringAsFixed(1),
      (weightFix! * 6.5).toStringAsFixed(1),
      (weightT! * 6.5).toStringAsFixed(1),
      (weightBead! * 6.5).toStringAsFixed(1),
      (weightBar! * 6.5).toStringAsFixed(1),
      (frameFixSize! * 10).toStringAsFixed(0),
      (beadSize! * 10).toStringAsFixed(0),
      (deductTrack! * 10).toStringAsFixed(0)
    ];

    getVal() {
      textFieldValue.forEach((e) {
        e = addController[textFieldValue.indexOf(e)].text;
      });
      emit(MyInitState());
    }

    for (var data in addController) {
      data.addListener(getVal);
      data.text = '${textFieldValue[addController.indexOf(data)]}';
    }

    emit(MyInitState());
  }
}

List<TextEditingController> addController =
    List.generate(28, (i) => TextEditingController(), growable: false);
