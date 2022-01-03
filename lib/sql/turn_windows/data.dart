import 'const.dart';

class TurnDeductData {
  int? id;
  String? country, windowsSystem, windowsProfile;
  double? oneSashDeDuct, towSashDeDuct, heightSashDeduct;
  double? deductFrameWithBar, deductFrameWithFex, bead;
  double? deductSmallZ, deductLargeZ, deductTCenter;
  double? weightFrame, weightSash, weightPanda, weightT, weightBead;
  double? weightFrameWithFex, weightBar;

  TurnDeductData(dynamic obj) {
    id = obj[cTId];
    country = obj[cTCountry];
    windowsSystem = obj[cTSystemType];
    windowsProfile = obj[cTWindowsProfile];
    oneSashDeDuct = obj[cTOneSashDeDuct];
    towSashDeDuct = obj[cTTowSashDeDuct];
    heightSashDeduct = obj[cTHeightSashDeduct];
    deductFrameWithBar = obj[cTDeductFrameWithBar];
    deductFrameWithFex = obj[cTDeductFrameWithFex];
    bead = obj[cTBead];
    deductSmallZ = obj[cTDeductSmallZ];
    deductLargeZ = obj[cTDeductLargeZ];
    deductTCenter = obj[cTDeductTCenter];
    weightFrame = obj[cTWeightFrame];
    weightFrameWithFex = obj[cTWeightFrameWithFex];
    weightSash = obj[cTWeightSash];
    weightPanda = obj[cTWeightPanda];
    weightT = obj[cTWeightT];
    weightBead = obj[cTWeightBead];
    weightBar = obj[cTWeightBar];
  }

  TurnDeductData.fromMap(Map<String, dynamic> data) {
    id = data[cTId];
    country = data[cTCountry];
    windowsSystem = data[cTSystemType];
    windowsProfile = data[cTWindowsProfile];
    oneSashDeDuct = data[cTOneSashDeDuct];
    towSashDeDuct = data[cTTowSashDeDuct];
    heightSashDeduct = data[cTHeightSashDeduct];
    deductFrameWithBar = data[cTDeductFrameWithBar];
    deductFrameWithFex = data[cTDeductFrameWithFex];
    bead = data[cTBead];
    deductSmallZ = data[cTDeductSmallZ];
    deductLargeZ = data[cTDeductLargeZ];
    deductTCenter = data[cTDeductTCenter];
    weightFrame = data[cTWeightFrame];
    weightFrameWithFex = data[cTWeightFrameWithFex];
    weightSash = data[cTWeightSash];
    weightPanda = data[cTWeightPanda];
    weightT = data[cTWeightT];
    weightBead = data[cTWeightBead];
    weightBar = data[cTWeightBar];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      cTCountry: country,
      cTWindowsProfile: windowsProfile,
      cTSystemType: windowsSystem,
      cTOneSashDeDuct: oneSashDeDuct,
      cTTowSashDeDuct: towSashDeDuct,
      cTHeightSashDeduct: heightSashDeduct,
      cTDeductFrameWithBar: deductFrameWithBar,
      cTDeductFrameWithFex: deductFrameWithFex,
      cTBead: bead,
      cTDeductSmallZ: deductSmallZ,
      cTDeductLargeZ: deductLargeZ,
      cTDeductTCenter: deductTCenter,
      cTWeightFrame: weightFrame,
      cTWeightFrameWithFex: weightFrameWithFex,
      cTWeightSash: weightSash,
      cTWeightPanda: weightPanda,
      cTWeightT: weightT,
      cTWeightBead: weightBead,
      cTWeightBar: weightBar,
    };

    if (id != null) map[cTId] = id;

    return map;
  }
}
