import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/a_home.dart';
import 'package:the_smart_workshop/screens/a_home/screens/about_us/about_us.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us.dart';
import 'package:the_smart_workshop/screens/a_home/screens/policy/policy.dart';
import 'package:the_smart_workshop/screens/a_home/screens/settings/a_settings.dart';
import 'package:the_smart_workshop/screens/a_home/screens/support_us/support_us.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/corner.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/irregular_angle.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/rotation.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/al_home.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/wood_home.dart';
import 'package:the_smart_workshop/screens/deducts/windows/slide_home.dart';
import 'package:the_smart_workshop/screens/deducts/windows/turn_home.dart';
import 'package:the_smart_workshop/sql/home.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  AluminumSlideHome.id: (context) => AluminumSlideHome(),
  AluminumTurnHome.id: (context) => AluminumTurnHome(),
  KitchenAluminum.id: (context) => KitchenAluminum(),
  KitchenWood.id: (context) => KitchenWood(),
  Corner.id: (context) => Corner(),
  MyHomePage.id: (context) => MyHomePage(),
  SupportUs.id: (context) => SupportUs(),
  AboutUs.id: (context) => AboutUs(),
  Policy.id: (context) => Policy(),
  CallUs.id: (context) => CallUs(),
  RotationAngle.id: (context) => RotationAngle(),
  IrregularAngle.id: (context) => IrregularAngle(),
  Setting.id: (context) => Setting(),
  SlideDeductSetting.id: (context) => SlideDeductSetting(),
};

List<LocalizationsDelegate> myLocalizations = [
  GlobalCupertinoLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
