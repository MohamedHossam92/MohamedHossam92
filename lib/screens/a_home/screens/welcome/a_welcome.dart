import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/gif/robotintro_dribble.gif'),
          BTextB5('أهلاً وسهلاً بك في تطبيق الورشة الذكية'),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Colors.white70,
            child: DPadding(
              child: Column(
                children: [
                  BTextB4('أول وأكبر تطبيق إلكتروني مجاني لتنظيم وإدارة'),
                  SizedBox(
                    height: 5,
                  ),
                  BTextB4('مصانع الألومنيوم والنجارة والـU-pvc'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Colors.amber,
            child:
                DPadding(child: BTextB5('مع بعض ثواني لضبط إعدادات التطبيق')),
          ),
          BTextB5('اضغط علي الخطوة التالية للمتابعة')
        ],
      ),
    );
  }
}
