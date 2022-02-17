import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

import 'component/const/bloc_providers.dart';
import 'component/const/my_routes.dart';
import 'component/tasks/local_notifications/notifications.dart';
import 'component/ui/theme.dart';
import 'screens/a_home/cubit/cubit.dart';
import 'screens/a_home/home_screen/a_home.dart';
import 'screens/a_home/screens/welcome/a_home.dart';

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
        providers: [...myBlocProviders],
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              HomeCubit cubit = BlocProvider.of(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: myTheme,
                home: cubit.enterApp ? MyHomePage() : WelcomePage(),
                routes: myRoutes,
                localizationsDelegates: myLocalizations,
                supportedLocales: [Locale("ar")],
                locale: Locale("ar"),
              );
            }));
  }
}
