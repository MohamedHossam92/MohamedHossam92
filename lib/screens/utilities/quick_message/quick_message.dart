import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/text_scale.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickMessage extends StatefulWidget {
  static String id = 'QuickMessage';
  QuickMessage({Key? key}) : super(key: key);

  @override
  _QuickMessageState createState() => _QuickMessageState();
}

class _QuickMessageState extends State<QuickMessage> {
  String countryKey = '002';
  String phoneNumber = '01xxxxxxxxx';
  String? message = '';
  var countryController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    countryController.addListener(getCountryKey);
    phoneController.addListener(getPhoneNumber);
    countryController.text = countryKey;
    super.initState();
  }

  getCountryKey() {
    countryKey = countryController.text;
    this.setState(() {});
  }

  getPhoneNumber() {
    phoneNumber = phoneController.text;
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String sendNumber = '$countryKey-$phoneNumber';
    Size size = MediaQuery.of(context).size;
    return textScale(
        context,
        Scaffold(
            appBar: AppBar(
              title: Text('رسالة سريعة'),
            ),
            body: AppBackGround(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Icon(
                    Icons.schedule_send,
                    size: MediaQuery.of(context).size.width * .3,
                  ),
                  BTextB5('خدمة رسالة سريعة'),
                  DPadding(
                    child: BTextB4(
                        'ستتمكن من إرسال رسالة إلي أي رقم علي تطبيق الواتس'),
                  ),
                  BTextB4('دون الحاجة إلي تسجيله'),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * .04),
                        topLeft: Radius.circular(size.width * .04),
                      ),
                      color: Colors.blueGrey.shade900,
                    ),
                    child: DPadding(
                      val: .04,
                      child: Center(child: WTextB5('إرسال رسالة سريعة')),
                    ),
                  ),
                  Column(
                    children: [
                      DPadding(
                        child: Row(
                          children: [
                            Icon(Icons.input),
                            BTextB4('    ضع نص الرسالة هنا (اختياري).'),
                          ],
                        ),
                      ),
                      DTextFieldMax(
                          validator: () {},
                          labelText: 'نص الرسالة   (اختياري)',
                          onChanged: (val) {
                            message = val;
                            this.setState(() {});
                          }),
                      DPadding(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline_outlined),
                            BTextB4(
                                'تأكد ان الرقم مُسجل علي الواتس قبل الارسال.'),
                          ],
                        ),
                      ),
                      DPadding(child: Text(sendNumber)),
                      DPadding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: size.width * .5,
                                height: size.width * .11,
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      labelText: 'أدخل رقم الواتس هنا'),
                                )),
                            DPadding(
                              child: SizedBox(
                                  height: size.width * .08,
                                  width: size.width * .15,
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: countryController,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DPadding(
                              child: SizedBox(
                                  width: size.width * .4,
                                  child: MaterialButton(
                                    color: Colors.blueGrey.shade900,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                        WTextB4('      أرســــل')
                                      ],
                                    ),
                                    onPressed: () async {
                                      final link = whatsApp(
                                          phone: phoneNumber, message: message);

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
                      Icon(Icons.more_horiz)
                    ],
                  )
                ],
              )),
            )));
  }
}
