import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/text_scale.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class FlyScreen extends StatefulWidget {
  static String id = 'FlyScreen';
  final bool isFlyScreen;

  const FlyScreen([this.isFlyScreen = true]);

  @override
  _FlyScreenState createState() => _FlyScreenState();
}

class _FlyScreenState extends State<FlyScreen> {
  String? message = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return textScale(
        context,
        Scaffold(
            appBar: AppBar(
              title: Text(widget.isFlyScreen ? 'سلك بيليسة' : 'شيش حصيرة'),
            ),
            body: AppBackGround(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Image.asset(
                      'assets/images/new/00${widget.isFlyScreen ? 0 : 2}.png'),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Column(
                    children: [
                      DPadding(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline_outlined),
                            BTextB4('تأكد من كتابة العرض أولا ثم الإرتفاع.'),
                          ],
                        ),
                      ),
                      DPadding(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline_outlined),
                            BTextB4('حدد المواصفات بدقه بعد كل مقاس .'),
                          ],
                        ),
                      ),
                      DPadding(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline_outlined),
                            BTextB4('استخدم أرقام إنجليزية فقط 0-9.'),
                          ],
                        ),
                      ),
                      DPadding(
                        child: Row(
                          children: [
                            Icon(Icons.input),
                            BTextB4('    ضع مقاساتك هنا.'),
                          ],
                        ),
                      ),
                      DTextFieldMax(
                          validator: () {},
                          labelText: '    ضع مقاساتك هنا.',
                          onChanged: (val) {
                            message = val;
                            this.setState(() {});
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DPadding(
                              child: SizedBox(
                                  width: size.width * .4,
                                  child: MaterialButton(
                                    color: Colors.indigo.shade900,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                        WTextB4('      أرســــل'),
                                      ],
                                    ),
                                    onPressed: () async {
                                      final link = whatsApp(
                                          phone: widget.isFlyScreen
                                              ? '01111555880'
                                              : '01008622077',
                                          message: message);
                                      await launch('$link');
                                      PrayPlay.playPray();
                                    },
                                  ))),
                          DPadding(
                            child: Image.asset(
                                'assets/images/social_icons/whats.png'),
                          ),
                        ],
                      ),
                      if (widget.isFlyScreen)
                        DPadding(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              BTextB4(
                                  'سيتم شحن الطلبية إليك من أحد الفروع الآتية :-\n(شبرا الخيمة - مؤسسة الزكاة - المريوطية - طنطا).'),
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              )),
            )));
  }
}
