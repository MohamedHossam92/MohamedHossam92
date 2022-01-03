import 'const.dart';

class SlideDeduct {
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
  double? widthGlassDeduct, heightGlassDeduct, trackDeduct;

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
  double? frameFixSize, beadSize;

  SlideDeduct(dynamic obj) {
    id = obj[cSId];
    country = obj[cSCountry];
    windowsSystem = obj[cSWindowsSystem];
    windowsProfile = obj[cSWindowsProfile];
    widthSashDeduct2 = obj[cSWidthSashDeduct2];
    widthSashDeduct4 = obj[cSWidthSashDeduct4];
    widthSashDeduct32 = obj[cSWidthSashDeduct32];
    widthSashDeduct33 = obj[cSWidthSashDeduct33];
    widthFlyScreenDeduct2 = obj[cSWidthFlyScreenDeduct2];
    widthFlyScreenDeduct4 = obj[cSWidthFlyScreenDeduct4];
    widthFlyScreenDeduct32 = obj[cSWidthFlyScreenDeduct32];
    widthFlyScreenDeduct33 = obj[cSWidthFlyScreenDeduct33];
    heightSashDeduct = obj[cSHeightSashDeduct];
    heightFluScreenDeduct = obj[cSHeightFluScreenDeduct];
    heightHookDeduct = obj[cSHeightHookDeduct];
    heightAdjoiningDeduct = obj[cSHeightAdjoiningDeduct];
    widthGlassDeduct = obj[cSWidthGlassDeduct];
    heightGlassDeduct = obj[cSHeightGlassDeduct];
    frameFixSize = obj[cSFrameFixSize];
    beadSize = obj[cSBeadSize];
    trackDeduct = obj[cSTrackDeduct];
    weightFrame = obj[cSWeightFrame];
    weightFrameWithoutBar = obj[cSWeightFrameWithoutBar];
    weightSash = obj[cSWeightSash];
    weightFlyScreen = obj[cSWeightFlyScreen];
    weightHook = obj[cSWeightHook];
    weightAdjoining = obj[cSWeightAdjoining];
    weightFix = obj[cSWeightFix];
    weightT = obj[cSWeightT];
    weightBead = obj[cSWeightBead];
    weightBar = obj[cSWeightBar];
    weightCollect = obj[cSWeightCollect];
  }
  SlideDeduct.fromMap(Map<String, dynamic> data) {
    id = data[cSId];
    country = data[cSCountry];
    windowsSystem = data[cSWindowsSystem];
    windowsProfile = data[cSWindowsProfile];
    widthSashDeduct2 = data[cSWidthSashDeduct2];
    widthSashDeduct4 = data[cSWidthSashDeduct4];
    widthSashDeduct32 = data[cSWidthSashDeduct32];
    widthSashDeduct33 = data[cSWidthSashDeduct33];
    widthFlyScreenDeduct2 = data[cSWidthFlyScreenDeduct2];
    widthFlyScreenDeduct4 = data[cSWidthFlyScreenDeduct4];
    widthFlyScreenDeduct32 = data[cSWidthFlyScreenDeduct32];
    widthFlyScreenDeduct33 = data[cSWidthFlyScreenDeduct33];
    heightSashDeduct = data[cSHeightSashDeduct];
    heightFluScreenDeduct = data[cSHeightFluScreenDeduct];
    heightHookDeduct = data[cSHeightHookDeduct];
    heightAdjoiningDeduct = data[cSHeightAdjoiningDeduct];
    widthGlassDeduct = data[cSWidthGlassDeduct];
    heightGlassDeduct = data[cSHeightGlassDeduct];
    frameFixSize = data[cSFrameFixSize];
    beadSize = data[cSBeadSize];

    trackDeduct = data[cSTrackDeduct];
    weightFrame = data[cSWeightFrame];
    weightFrameWithoutBar = data[cSWeightFrameWithoutBar];
    weightSash = data[cSWeightSash];
    weightFlyScreen = data[cSWeightFlyScreen];
    weightHook = data[cSWeightHook];
    weightAdjoining = data[cSWeightAdjoining];
    weightFix = data[cSWeightFix];
    weightT = data[cSWeightT];
    weightBead = data[cSWeightBead];
    weightBar = data[cSWeightBar];
    weightCollect = data[cSWeightCollect];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cSCountry: country,
      cSWindowsSystem: windowsSystem,
      cSWindowsProfile: windowsProfile,
      cSWidthSashDeduct2: widthSashDeduct2,
      cSWidthSashDeduct4: widthSashDeduct4,
      cSWidthSashDeduct32: widthSashDeduct32,
      cSWidthSashDeduct33: widthSashDeduct33,
      cSWidthFlyScreenDeduct2: widthFlyScreenDeduct2,
      cSWidthFlyScreenDeduct4: widthFlyScreenDeduct4,
      cSWidthFlyScreenDeduct32: widthFlyScreenDeduct32,
      cSWidthFlyScreenDeduct33: widthFlyScreenDeduct33,
      cSHeightSashDeduct: heightSashDeduct,
      cSHeightFluScreenDeduct: heightFluScreenDeduct,
      cSHeightHookDeduct: heightHookDeduct,
      cSHeightAdjoiningDeduct: heightAdjoiningDeduct,
      cSWidthGlassDeduct: widthGlassDeduct,
      cSHeightGlassDeduct: heightGlassDeduct,
      cSBeadSize: beadSize,
      cSFrameFixSize: frameFixSize,
      cSTrackDeduct: trackDeduct,
      cSWeightFrame: weightFrame,
      cSWeightFrameWithoutBar: weightFrameWithoutBar,
      cSWeightSash: weightSash,
      cSWeightFlyScreen: weightFlyScreen,
      cSWeightHook: weightHook,
      cSWeightAdjoining: weightAdjoining,
      cSWeightFix: weightFix,
      cSWeightT: weightT,
      cSWeightBead: weightBead,
      cSWeightBar: weightBar,
      cSWeightCollect: weightCollect,
    };
    if (id != null) map[cSId] = id;
    return map;
  }
}
