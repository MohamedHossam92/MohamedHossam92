import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/screens/welcome/d_login_iphone.dart';

import 'a_welcome.dart';
import 'b_country.dart';
import 'c_sure_technical.dart';
import 'e_download_deduct.dart';
import 'f_enter_app.dart';
import 'user_type.dart';

class WelcomePage extends StatefulWidget {
  final int activeSteps;

  const WelcomePage([this.activeSteps = 0]);
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<WelcomePage> {
  late int activeStep;

  @override
  void initState() {
    activeStep = widget.activeSteps;
    super.initState();
  }

  int iosIndex = Platform.isIOS ? 6 : 5;
  int fieldTry = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          return SafeArea(
            child: Scaffold(
              body: AppBackGround(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(children: [
                        DPadding(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: size.height * .1,
                          ),
                        ),
                        BTextB8('الورشة الذكية'),
                      ]),
                      IconStepper(
                        icons: [
                          Icon(Icons.supervised_user_circle),
                          Icon(Icons.flag),
                          Icon(Icons.widgets),
                          Icon(Icons.policy),
                          Icon(Icons.app_registration),
                          if (Platform.isIOS) Icon(Icons.login),
                          Icon(Icons.done_all),
                        ],
                        activeStep: activeStep,
                      ),
                      header(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: ss[activeStep],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: activeStep == iosIndex
                                ? Colors.green
                                : cLogoColorW,
                            child: SPadding(
                                h: .1,
                                v: .01,
                                child: WTextB5(
                                    '${activeStep + 1}    -    ${Platform.isIOS ? '7' : '6'}')),
                          ),
                          if (activeStep < iosIndex)
                            MaterialButton(
                              color: Colors.green.shade700,
                              onPressed: () async {
                                if (activeStep == 0) {
                                  activeStep++;
                                  this.setState(() {});
                                } else if (activeStep == 1) {
                                  if (cubit.countryGroupVal == 1) {
                                    activeStep = 5;
                                    this.setState(() {});
                                  } else {
                                    activeStep++;
                                    this.setState(() {});
                                  }
                                } else if (activeStep == 2) {
                                  if (cubit.userType == -1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        dSnackBarShowResult(
                                            title: 'لم تحدد أي اختيارات'));
                                  } else if (cubit.userType == 0) {
                                    activeStep++;
                                    this.setState(() {});
                                  } else {
                                    activeStep = 5;
                                    this.setState(() {});
                                  }
                                } else if (activeStep == 3) {
                                  if (cubit.sureTechnical != 2) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        dSnackBarShowResult(
                                            title:
                                                'يبدو أنك لست فني ألومنيوم .. شكراً لك'));
                                    activeStep = 2;
                                    this.setState(() {});
                                  } else {
                                    await cubit.getDownloadDeductPrefs();

                                    this.setState(() {
                                      cubit.downloadDeduct
                                          ? activeStep = 5
                                          : activeStep++;
                                    });
                                  }
                                } else if (activeStep == 4) {
                                  await cubit.getDownloadDeductPrefs();

                                  if (!cubit.downloadDeduct) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        dSnackBarShowResult(
                                            title:
                                                'قم بتحميل التخصيمات أولاً .'));
                                    this.setState(() {});
                                  } else {
                                    activeStep++;
                                    this.setState(() {});
                                  }
                                } else {
                                  if (cubit.isLoginIOS) {
                                    activeStep++;
                                    this.setState(() {});
                                  } else {
                                    fieldTry++;
                                    this.setState(() {});

                                    if (fieldTry < 3) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(dSnackBarShowResult(
                                              title:
                                                  'رجاء التأكد من رقم الهاتف وكلمة المرور .'));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(dSnackBarShowResult(
                                              title:
                                                  'ربما ليس لديك عضوية قم بالتسجيل الآن.'));
                                    }
                                  }
                                  ;
                                }
                              },
                              child: WTextB5('الخطوة التالية'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: cLogoColorW,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WTextB5(
              headerText[activeStep],
            ),
          ),
        ],
      ),
    );
  }

  List ss = [
    Welcome(),
    Country(),
    UserType(),
    SureTechnical(),
    DownloadDeducts(),
    if (Platform.isIOS) LoginIPhone(),
    OpenApp(),
  ];

  List<String> headerText = [
    'مرحباً .. أجمل تحية ',
    'أهلاً وسهلاً بك ,,, من أي دولة أنت ؟',
    'من فضلك حدد طبيعة استخدامك للتطبيق',
    'إختبار الأمان',
    'تحميل التخصيمات علي هاتفك',
    if (Platform.isIOS) 'تسجيل الدخول',
    'أهلاً بك .. تفضل بالدخول'
  ];
}
