import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/state.dart';
import 'package:the_smart_workshop/sql/turn_windows/data.dart';

import '../const.dart';
import '../turn_deduct_list.dart';

List turnDeductListDb = [];
List oneTurnSystemList = [];

class SQLTurnCubit extends Cubit<SQLTurnState> {
  SQLTurnCubit() : super(InitState());
  Database? _db;

  Future<Database> createDb() async {
    String path = join(await getDatabasesPath(), 'swTalTurn.db');
    return _db ??
        await openDatabase(path, version: 1, onCreate: (db, v) {
          db.execute('CREATE TABLE $cTTableName (' +
              '$cTId INTEGER PRIMARY KEY AUTOINCREMENT,' +
              '$cTCountry TEXT,' +
              '$cTSystemType TEXT,' +
              '$cTWindowsProfile TEXT,' +
              '$cTOneSashDeDuct REAL,' +
              '$cTTowSashDeDuct REAL,' +
              '$cTHeightSashDeduct REAL,' +
              '$cTDeductFrameWithBar REAL,' +
              '$cTDeductFrameWithFex REAL,' +
              '$cTBead REAL,' +
              '$cTDeductSmallZ REAL,' +
              '$cTDeductLargeZ REAL,' +
              '$cTDeductTCenter REAL,' +
              '$cTWeightFrame REAL,' +
              '$cTWeightFrameWithFex REAL,' +
              '$cTWeightSash REAL,' +
              '$cTWeightPanda REAL,' +
              '$cTWeightT REAL,' +
              '$cTWeightBead REAL,' +
              '$cTWeightBar REAL' +
              ')');
        });
  }

  //===============insertData=================
  Future<void> insertDataToDb(TurnDeductData turnDeductData) async {
    Database db = await createDb();

    db.insert(cTTableName, turnDeductData.toMap()).then((value) {
      emit(InsertDataToDb());
      getDataFromDb().then((value) => emit(GetDataFromDb()));
    });
  }

  //==================getData===============

  Future<List<Map>?> getDataFromDb() async {
    Database db = await createDb();

    return db.query(cTTableName).then((value) {
      turnDeductListDb = value;
      emit(GetDataFromDb());
    });
  }

//===================deleteData===================
  void deleteDataFromDb(int id) async {
    Database db = await createDb();
    db.delete(cTTableName, where: '$cTId = ?', whereArgs: [id]).then((value) {
      getDataFromDb().then((value) => emit(GetDataFromDb()));
      emit(DeleteDataFromDb());
    });
  }
//===================updateData===================

  Future updateData(TurnDeductData turnDeductData) async {
    Database db = await createDb();
    db.update(cTTableName, turnDeductData.toMap(),
        where: '$cTId = ?', whereArgs: [turnDeductData.id]).then((value) {
      getDataFromDb().then((value) => emit(GetDataFromDb()));

      emit(UpdateData());
    });
  }
  //===============insertAllData=================

  void insertAllDeduct() {
    for (var data in allTurnDeductList) {
      insertDataToDb(data);
    }
  }

  void addOneSystemList(String systemName) {
    oneTurnSystemList.clear();
    for (var data in turnDeductListDb) {
      if (data[cTSystemType] == systemName) oneTurnSystemList.add(data);
    }

    emit(SystemNameChange());
  }

//===================== اضافة تخصيم جديد ====================
  int? id;
  String? country, windowsSystem, windowsProfile;
  double? oneSashDeDuct, towSashDeDuct, heightSashDeduct;
  double? deductFrameWithBar, deductFrameWithFex, bead;
  double? deductSmallZ, deductLargeZ, deductTCenter;
  double? weightFrame, weightSash, weightPanda, weightT, weightBead;
  double? weightFrameWithFex, weightBar;

  int validate = -1;
  validateInc([int i = 0]) {
    if (i == 1) validate = -1;
    validate++;
    emit(ValidateIncState());
  }

  late bool isPVC;
  int isPVCValGroup = -1;

  isPVCState(val) {
    isPVCValGroup = val;
    val == 1 ? isPVC = true : isPVC = false;
    emit(IsPVCState());
  }

  sashDeductOnChange(int i, String? val) {
    if (i == 0) oneSashDeDuct = double.parse(val!) * .1;
    if (i == 1) towSashDeDuct = double.parse(val!) * .1;
    if (i == 2) heightSashDeduct = double.parse(val!) * .1;
    if (i == 3) deductTCenter = double.parse(val!) * .1;
    if (i == 4) windowsProfile = val;

    emit(SashOnChangeState());
  }

  profilesValue(int i, String? val) {
    if (i == 0) deductFrameWithBar = double.parse(val!) * .1;
    if (i == 1) deductFrameWithFex = double.parse(val!) * .1;
    if (i == 2) deductLargeZ = double.parse(val!) * .1;
    if (i == 3) deductSmallZ = double.parse(val!) * .1;
    if (i == 4) bead = double.parse(val!) * .1;
    emit(FlyScreenOnChangeState());
  }

  weightOnChange(int i, String? val) {
    if (i == 0) weightFrame = double.parse(val!) / 6.5;
    if (i == 1) weightSash = double.parse(val!) / 6.5;
    if (i == 2) weightPanda = double.parse(val!) / 6.5;
    if (i == 3) weightT = double.parse(val!) / 6.5;
    if (i == 4) weightBead = double.parse(val!) / 6.5;

    emit(WeightOnChangeState());
  }

  editDeducts(
      {idOld,
      countryOld,
      windowsSystemOld,
      windowsProfileOld,
      oneSashDeDuctOld,
      towSashDeDuctOld,
      heightSashDeductOld,
      deductFrameWithBarOld,
      deductFrameWithFex2Old,
      beadOld,
      deductSmallZOld,
      deductLargeZOld,
      deductTCenterOld,
      weightFrameOld,
      weightSashOld,
      weightPandaOld,
      weightFrameWithFexOld,
      weightTOld,
      weightBeadOld,
      weightBarOld}) {
    id = idOld;
    country = countryOld;
    windowsSystem = windowsSystemOld;
    windowsProfile = windowsProfileOld;
    oneSashDeDuct = oneSashDeDuctOld;
    towSashDeDuct = towSashDeDuctOld;
    heightSashDeduct = heightSashDeductOld;
    deductFrameWithBar = deductFrameWithBarOld;
    deductFrameWithFex = deductFrameWithFex2Old;
    bead = beadOld;
    deductSmallZ = deductSmallZOld;
    deductLargeZ = deductLargeZOld;
    deductTCenter = deductTCenterOld;
    weightFrame = weightFrameOld;
    weightFrameWithFex = weightFrameWithFexOld;
    weightSash = weightSashOld;
    weightPanda = weightPandaOld;
    weightT = weightTOld;
    weightBead = weightBeadOld;
    weightBar = weightBarOld;

    List textFieldValue = [
      windowsProfile!,
      (oneSashDeDuct! * 10).toStringAsFixed(0),
      (towSashDeDuct! * 10).toStringAsFixed(0),
      (heightSashDeduct! * 10).toStringAsFixed(0),
      (deductTCenter! * 10).toStringAsFixed(0),
      (deductFrameWithBar! * 10).toStringAsFixed(0),
      (deductFrameWithFex! * 10).toStringAsFixed(0),
      (deductLargeZ! * 10).toStringAsFixed(0),
      (deductSmallZ! * 10).toStringAsFixed(0),
      (bead! * 10).toStringAsFixed(0),
      (weightFrame! * 6.5).toStringAsFixed(1),
      (weightFrameWithFex! * 6.5).toStringAsFixed(1),
      (weightSash! * 6.5).toStringAsFixed(1),
      (weightPanda! * 6.5).toStringAsFixed(1),
      (weightT! * 6.5).toStringAsFixed(1),
      (weightBead! * 6.5).toStringAsFixed(1),
      (weightBar! * 6.5).toStringAsFixed(1),
    ];

    getVal() {
      textFieldValue.forEach((e) {
        e = addController[textFieldValue.indexOf(e)].text;
      });
      emit(EditDeductState());
    }

    for (var data in addController) {
      data.addListener(getVal);
      data.text = '${textFieldValue[addController.indexOf(data)]}';
    }

    emit(EditDeductState());
  }
}

List<TextEditingController> addController =
    List.generate(17, (i) => TextEditingController(), growable: false);
