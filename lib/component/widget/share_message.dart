import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/text_scale.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareMessage extends StatefulWidget {
  static String id = 'ShareMessage';
  final color;

  const ShareMessage(this.color);

  @override
  _ShareMessageState createState() => _ShareMessageState();
}

class _ShareMessageState extends State<ShareMessage> {
  String countryKey = '002';
  String phoneNumber = '01xxxxxxxxx';
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
        SingleChildScrollView(
            child: Column(
          children: [
            Card(
                elevation: 7,
                child: Column(
                  children: [
                    DPadding(
                        child:
                            BTextB4(' أدخل رقم الواتس للعميل ثم إضغط إرسال')),
                    Divider(
                      thickness: 2,
                      color: cLogoColor,
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
                    DPadding(
                        child: SizedBox(
                            width: size.width * .4,
                            child: MaterialButton(
                              color: cLogoColorW,
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
                                    phone: sendNumber,
                                    message: 'كود اللون ${widget.color} \n'
                                        'شاهده من الرابط التالي :- http://onelink.to/v7sdbq'
                                        'قم بالتحميل ثم اذهب إلي كتالوج الألوان لمشاهدة اللون كود رقم ${widget.color} ');

                                await launch('$link');
                              },
                            )))
                  ],
                ))
          ],
        )));
  }
}
