import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us_button.dart';

class DesignKitchen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('إطلب تصميم مطبخ'),
      ),
      body: AppBackGround(
        child: Column(
          children: [
            Image.asset('assets/images/new/001.png'),
            DPadding(
              child: Row(
                children: [
                  Icon(
                    Icons.design_services,
                    color: Colors.orange,
                    size: size.width * .1,
                  ),
                  BTextB5('إطلب تصميم مطبخك 3D في 3 خطوات'),
                ],
              ),
            ),
            Divider(thickness: 3),
            Column(
              children: designData.map((e) {
                return DPadding(
                  child: Row(
                    children: [
                      Icon(
                        e.icon,
                        color: e.color,
                        size: size.width * .08,
                      ),
                      DPadding(
                        child: BTextB5(e.title),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            CallUsButton('طلب تصميم مطبخ'),
            DPadding(
              child: BTextB4('مسموح بالتعديل  مرة واحدة علي التصميم'),
            ),
          ],
        ),
      ),
    );
  }
}

class DesignData {
  final String title;

  final IconData icon;

  final Color color;

  DesignData({required this.title, required this.icon, required this.color});
}

List<DesignData> designData = [
  DesignData(
      title: 'ارسم مقاساتك كروكي علي ورقة',
      icon: Icons.edit,
      color: Colors.green),
  DesignData(
      title: 'حدد ألوانك وأماكن الأجهزة والفتحات',
      icon: Icons.color_lens,
      color: Colors.purple.shade300),
  DesignData(
      title: 'إضغط إرسال في الأسفل وراسلنا',
      icon: Icons.file_present,
      color: Colors.brown.shade600),
];
