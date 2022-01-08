import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';

class CoffeeHome extends StatefulWidget {
  const CoffeeHome({Key? key}) : super(key: key);

  @override
  _CoffeeHomeState createState() => _CoffeeHomeState();
}

class _CoffeeHomeState extends State<CoffeeHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: AppBackGround(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/coffee.gif',
                  width: size.width * .7,
                ),
                Image.asset('assets/images/thanks.png'),
                Card(
                    color: Colors.amber,
                    child: DPadding(
                        child: BTextB5(
                            'اضغط علي الزر بالأسفل لتعزمني علي فنجان'))),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GiveMeCoffee()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/coffee.gif',
                          width: size.width * .1),
                      DPadding(
                        child: MaterialButton(
                            color: cLogoColorW,
                            child: DPadding(
                                child: WTextB5('اعزمني علي فنجان قهوة')),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GiveMeCoffee()));
                            }),
                      ),
                      Image.asset('assets/images/coffee.gif',
                          width: size.width * .1),
                    ],
                  ),
                ),
                BText5('عن النبي صلى الله عليه و سلم أنه قال : '),
                SizedBox(
                  height: 5,
                ),
                BText5('" كُلُ معروفٍ صدقة ، والدالُ على الخير كفاعله " .'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
class GiveMeCoffee extends StatefulWidget {
  const GiveMeCoffee({Key? key}) : super(key: key);

  @override
  _GiveMeCoffeeState createState() => _GiveMeCoffeeState();
}

class _GiveMeCoffeeState extends State<GiveMeCoffee> {
  int upperBound = 6;
  int activeStep = 0;

  Object? coffeeSalesGroupVal = 2;
  Object? coffeeSupportTypeGroupVal = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      'assets/images/coffee.gif',
                      height: size.height * .2,
                    ),
                  ),
                  BTextB8('جزاكم الله خيراً'),
                ]),
                IconStepper(
                  icons: [
                    Icon(Icons.supervised_user_circle),
                    Icon(Icons.flag),
                    Icon(Icons.widgets),
                    Icon(Icons.policy),
                    Icon(Icons.app_registration),
                    Icon(Icons.done_all),
                  ],
                  activeStep: activeStep,
                ),
                header(),
                SingleChildScrollView(
                  child: Center(
                    child: ss()[activeStep],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (activeStep < 2)
                      MaterialButton(
                        color: Colors.red.shade700,
                        onPressed: () async {
                          if (activeStep == 1) {
                            if (coffeeSupportTypeGroupVal == 0) {
                              activeStep = 2;
                              this.setState(() {});
                            } else if (coffeeSupportTypeGroupVal == 1) {
                              activeStep = 3;
                              this.setState(() {});
                            } else if (coffeeSupportTypeGroupVal == 2) {
                              activeStep = 4;
                              this.setState(() {});
                            } else if (coffeeSupportTypeGroupVal == 3) {
                              activeStep = 5;
                              this.setState(() {});
                            } else if (coffeeSupportTypeGroupVal == 4) {
                              activeStep = 6;
                              this.setState(() {});
                            }
                          } else {
                            activeStep++;
                            this.setState(() {});
                          }
                        },
                        child: WTextB5('انتقل للخطوة التالية'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
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

  List ss() => [
        CoffeeSales(),
        CoffeeSupportType(),
        other("x         *9*7#         x"),
        bank(),
        other("x         *777#         x"),
        other("x         #115#         x"),
        other("x         *322#         x"),
      ];

  List<String> headerText = [
    'هتدعمنا بقيمة فنجان قهوة بكام ؟؟ ',
    'حدد طريقة إرسال الدعم ؟',
    'من فضلك حدد طبيعة استخدامك للتطبيق',
    'إختبار الأمان',
    'تحميل التخصيمات علي هاتفك',
    'أهلاً بك .. تفضل بالدخول',
    'أهلاً بك .. تفضل بالدخول'
  ];

  List<String> coffeeTitle = [
    'قهوة بلدي بقيمة 50 جنية',
    'قهوة فاخر بقيمة 100 جنية',
    'قهوة ملوكي بقيمة 200 جنية',
  ];
  CoffeeSales() => Container(
        child: Column(
            children: List.generate(
          3,
          (i) => RadioListTile(
            title: BTextB5(coffeeTitle[i]),
            value: i,
            groupValue: coffeeSalesGroupVal,
            onChanged: (val) {
              setState(() {
                coffeeSalesGroupVal = val;
              });
            },
          ),
        )),
      );

  List<String> coffeeSupportType = [
    'ارسال من فودافون كاش',
    'ارسال من خلال البنك',
    'ارسال كاش من اتصالات كاش',
    'ارسال كاش من أورنج كاش',
    'ارسال كاش من وي كاش'
  ];
  CoffeeSupportType() => Container(
        child: Column(
            children: List.generate(
          coffeeSupportType.length,
          (i) => RadioListTile(
            title: BTextB5(coffeeSupportType[i]),
            value: i,
            groupValue: coffeeSupportTypeGroupVal,
            onChanged: (val) {
              setState(() {
                coffeeSupportTypeGroupVal = val;
              });
            },
          ),
        )),
      );

  other(String number) => Container(
        child: Column(children: [
          DPadding(child: BTextB5('من خدمة كاش علي موبايلك')),
          DPadding(child: BTextB5('اتصل علي رقم')),
          Card(
              color: Colors.yellow.shade200,
              child: DPadding(child: BTextB8(number))),
          DPadding(child: BTextB5('واتبع التعليمات')),
          DPadding(child: BTextB5('والرقم المحول عليه هو')),
          Card(
              color: Colors.yellow.shade200,
              child: DPadding(child: BTextB8('     01020608160     '))),
        ]),
      );

  bank() => Container(
        child: Column(children: [
          DPadding(child: BTextB5('يمكنك التحويل من أي حساب بنكي')),
          DPadding(child: BTextB5('علي حساب رقم')),
          Card(
              color: Colors.yellow.shade200,
              child: DPadding(child: BTextB8('2880333000040995'))),
          DPadding(child: BTextB5('بنك مصر')),
          DPadding(child: BTextB5('اسم صاحب الحساب')),
          Card(
              color: Colors.yellow.shade200,
              child: DPadding(child: BTextB8(' محمد حسام عبدالحي محمد '))),
        ]),
      );
}
