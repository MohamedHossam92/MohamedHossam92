import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';

Map<String, dynamic> slideProfile = {
  qPS: [qPS6600, qPS9600],
  qSh: [
    qShJambo,
    '$qShJambo$radiusSkina',
    qShTango,
    '$qShTango$radiusSkina',
    qShNano,
    qShTendu,
    qShTembo
  ],
  qFolcano: [
    qFolcano70,
    '$qFolcano70$radiusSkina',
    qFolcano120,
    '$qFolcano120$radiusSkina'
  ],
  qValve: [
    qValveMV100,
    '$qValveV140$radiusSkina',
    qValveV170,
    '$qValveV170$radiusSkina'
  ],
  qAlumil: [
    qAlumilM900,
    qAlumilM9200,
    '$qAlumilM9200$radiusSkina',
    qAlumilM12000
  ]
};

List<String> turnProfiles = [
  '$qPS$qPS6600',
  '$qPS$qPS9600',
  '$qShSonata',
  '$qFolcano',
];

List<String> uPVCProfile = [
  '$qEnderPen',
  '$qPolyWin',
  '$qPolyWinSmall',
  '$qComPen',
  '$qWintech',
  '$qComPenLarge',
  '$qPriemere',
];
List<String> uPVCTurnProfile = [
  '$qEnderPen',
  '$qPolyWin',
  '$qComPen',
  '$qWintech',
  '$qPriemere',
];
String selectPVCSystem = '$qEnderPen';

List<String> frameTurnType = ['حلـق ببار', 'حلـق فكس'];
List<String> zType = ['z صغير', 'Z عريـض'];

List<String> framePVCTurnType = [' بار 4 سم', 'بـار 6 سم '];
List<String> zPVCType = ['درفة صغيرة', 'درفة كبيـرة'];

String selectedSystem = qPS6600;

List<List<String>> pvcTurnList = [uPVCTurnProfile, framePVCTurnType, zPVCType];
List<List<String>> aluminumTurnList = [turnProfiles, frameTurnType, zType];
