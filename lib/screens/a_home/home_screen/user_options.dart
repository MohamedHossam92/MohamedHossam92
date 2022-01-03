import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/wood_home.dart';
import 'package:the_smart_workshop/screens/utilities/design_kitchen/design_kitchen.dart';
import 'package:url_launcher/url_launcher.dart';

class Carpenter extends StatelessWidget {
  const Carpenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .9,
      height: size.height * .39,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * .015),
              topRight: Radius.circular(size.height * .015)),
          image: DecorationImage(
              image: AssetImage('assets/images/user_type/user_type001.jpg'),
              fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size.height * .12,
            color: Colors.black45,
            child: DPadding(
              child: Column(
                children: [
                  WTextB5('قم بإضافة وحدات المطبخ'),
                  WTextB4('وسنوفر عليك الوقت والجهد في الحساب ونعطيك'),
                  DPadding(
                      child: WTextB4(
                          '(تقرير بالتقطيع - تقرير بالتجميع - تقرير بالخامات)')),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: size.height * .1,
              child: Container(
                width: size.width * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BTextB4('Hpl -'),
                    BTextB4('Poly Lac -'),
                    BTextB4('.... إلخ'),
                  ],
                ),
              )),
          Positioned(
              bottom: 4,
              left: 4,
              child: MaterialButton(
                  color: Colors.white70,
                  onPressed: () {
                    Navigator.pushNamed(context, KitchenWood.id);
                    PrayPlay.playPray();
                  },
                  child: BTextB5('جرب الآن من هنا')))
        ],
      ),
    );
  }
}

class Customer extends StatelessWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .9,
      height: size.height * .39,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * .015),
              topRight: Radius.circular(size.height * .015)),
          image: DecorationImage(
              image: AssetImage('assets/images/user_type/user_type002.jpg'),
              fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size.height * .1,
            color: Colors.black45,
            child: DPadding(
              child: Column(
                children: [
                  WTextB5('نقدم لك إستشارة فنية خاصة'),
                  WTextB4('للتسهيل عليك في إختيار المواصفات الأنسب لك'),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: size.height * .1,
              child: Container(
                width: size.width * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.wb_incandescent,
                      color: Colors.black45,
                    ),
                    BTextB4('الأبواب والنوافذ'),
                    Icon(Icons.wb_incandescent, color: Colors.black45),
                    BTextB4('المطابخ'),
                    Icon(Icons.wb_incandescent, color: Colors.black45),
                    BTextB4('الواجهات'),
                  ],
                ),
              )),
          Positioned(
              bottom: 4,
              left: 4,
              child: Row(
                children: [
                  Image.asset('assets/images/social_icons/whats.png'),
                  TextButton(
                      onPressed: () async {
                        final link = whatsApp(
                            phone: '01020608160', message: 'استشارة فنية');

                        await launch('$link');
                        PrayPlay.playPray();
                      },
                      child: Text('اطلب الآن'))
                ],
              ))
        ],
      ),
    );
  }
}

class CustomerUtilities extends StatelessWidget {
  const CustomerUtilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DesignKitchen()));
      },
      child: Container(
        width: size.width * .9,
        height: size.height * .39,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/new/001.png'),
                fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(size.width * .01)),
      ),
    );
  }
}
