import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/a_home.dart';

class OpenApp extends StatelessWidget {
  const OpenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          return Column(
            children: [
              Image.asset(
                'assets/images/coffee.gif',
                width: size.width * .8,
              ),
              Card(
                  color: Colors.amber,
                  child: DPadding(
                      child: BTextB6('شكراً لك لانتظارك وضبط اعداداتك'))),
              SizedBox(
                height: size.height * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: size.width * .15,
                  ),
                  MaterialButton(
                    child: DPadding(child: WTextB5('الدخول إلي التطبيق')),
                    color: cLogoColorW,
                    onPressed: () async {
                      await cubit.saveUserType(cubit.userType);
                      await cubit.saveEnterApp(true);
                      PrayPlay.playPray();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: size.width * .15,
                  ),
                ],
              ),
            ],
          );
        });
  }
}
