import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_smart_workshop/local_notifications/notifications.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/screens/settings/a_settings.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/corner.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/rotation.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/wood_home.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/home.dart';

import 'component/ui/theme.dart';
import 'screens/a_home/cubit/cubit.dart';
import 'screens/a_home/home_screen/a_home.dart';
import 'screens/a_home/screens/about_us/about_us.dart';
import 'screens/a_home/screens/call_us/call_us.dart';
import 'screens/a_home/screens/policy/policy.dart';
import 'screens/a_home/screens/support_us/support_us.dart';
import 'screens/a_home/screens/welcome/a_home.dart';
import 'screens/deducts/a-component/cubit/cubit.dart';
import 'screens/deducts/angles/cubit/cubit.dart';
import 'screens/deducts/angles/view/irregular_angle.dart';
import 'screens/deducts/kitchen/al_home.dart';
import 'screens/deducts/kitchen/cubit/al_cubit/cubit.dart';
import 'screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'screens/deducts/kitchen/cubit/wood_cubit/cubit.dart';
import 'screens/deducts/windows/cubit/slide_cubit/cubit.dart';
import 'screens/deducts/windows/cubit/turn_cubit/cubit.dart';
import 'screens/deducts/windows/slide_home.dart';
import 'screens/deducts/windows/turn_home.dart';
import 'screens/utilities/todo/cubit/cubit/cubit.dart';
import 'screens/utilities/todo/cubit/db_cubit/cubit.dart';
import 'sql/kitchen/cubit/cubit.dart';
import 'sql/slide_windows/cubit/cubit.dart';
import 'sql/turn_windows/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalNotificationHelper.init();
  FlutterLocalNotificationHelper.showNotification();
  runApp(TheSmartWorkshop());
}

class TheSmartWorkshop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ComponentCubit()..getId()),
          BlocProvider(create: (context) => SlideCubit()),
          BlocProvider(create: (context) => TurnCubit()),
          BlocProvider(create: (context) => NoteCubit()),
          BlocProvider(create: (context) => AddNoteCubit()..createDb()),
          BlocProvider(create: (context) => HomeCubit()..initState(context)),
          BlocProvider(create: (context) => AddKitchenCubit()),
          BlocProvider(create: (context) => KitchenCubit()),
          BlocProvider(create: (context) => WoodCubit()),
          BlocProvider(create: (context) => CornerCubit()),
          BlocProvider(create: (context) => SQLSlideCubit()),
          BlocProvider(create: (context) => SQLTurnCubit()),
          BlocProvider(create: (context) => OtherDeductCubit()),
          BlocProvider(
              create: (context) => KitchenSettingCubit()..getAllPrefs()),
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              HomeCubit cubit = BlocProvider.of(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: myTheme,
                home: cubit.enterApp ? MyHomePage() : WelcomePage(),
                routes: {
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
                },
                localizationsDelegates: [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale("ar"),
                ],
                locale: Locale("ar"),
              );
            }));
  }
}
