import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/rotation.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/view/fly_screen.dart';
import 'package:the_smart_workshop/screens/deducts/z_other/view/shade.dart';
import 'package:the_smart_workshop/sql/home.dart';

import 'angles/view/corner.dart';
import 'angles/view/irregular_angle.dart';
import 'kitchen/al_home.dart';
import 'kitchen/wood_home.dart';
import 'z_other/view/shutter.dart';

class Deducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DPadding(
      child: SingleChildScrollView(
          child: Column(
        children: contentList.map((e) {
          return DPadding(
            val: .008,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                        spreadRadius: 0)
                  ],
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(size.height * .01)),
              child: Card(
                  margin: EdgeInsets.all(size.height * .002),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * .02)),
                  elevation: 8,
                  child: ListTile(
                    leading: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.height * .02)),
                      color: e.color,
                      child: DPadding(
                        child: Icon(
                          e.icon,
                          color: Colors.white,
                          size: size.height * .025,
                        ),
                      ),
                    ),
                    title: BTextB5(e.title),
                    onTap: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              color: Colors.black54,
                              child: Column(
                                children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: e.list.map((j) {
                                        return DPadding(
                                            val: .04,
                                            child: SizedBox(
                                                width: size.width * .5,
                                                child: MaterialButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  j.onPressed));
                                                    },

                                                    //  ,
                                                    color: Colors.white,
                                                    child: RTextB5(j.title))));
                                      }).toList()),
                                  MaterialButton(
                                      child: Row(
                                        children: [
                                          Icon(Icons.threesixty_rounded),
                                          WTextB4('رجوع')
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.transparent,
                      );
                    },
                  )),
            ),
          );
        }).toList(),
      )),
    );
  }
}

class BottomSheetButtons {
  final String title;
  final Widget onPressed;

  BottomSheetButtons({required this.title, required this.onPressed});
}

class DeductsContent {
  final String title;
  final IconData icon;
  final Color color;
  final List<BottomSheetButtons> list;

  DeductsContent(
      {required this.title,
      required this.icon,
      required this.color,
      required this.list});
}

List<DeductsContent> contentList = [
  DeductsContent(
      title: 'أبواب ونوافذ',
      color: Colors.pink.shade600,
      icon: Icons.widgets,
      list: [
        BottomSheetButtons(
          title: ' جرار',
          onPressed: SlideDeductSetting(false),
        ),
        BottomSheetButtons(
            title: ' مفصلي', onPressed: SlideDeductSetting(false, false)),
        BottomSheetButtons(
            title: ' قلاب', onPressed: SlideDeductSetting(false, false, true)),
      ]),
  DeductsContent(
      title: 'تخصيم المطابخ',
      color: Colors.blue.shade600,
      icon: Icons.map,
      list: [
        BottomSheetButtons(
            title: 'مطبخ ألومنيوم', onPressed: KitchenAluminum()),
        BottomSheetButtons(title: ' مطابخ 18مم', onPressed: KitchenWood()),
      ]),
  DeductsContent(
      title: 'استخراج زوايا وأضلاع',
      color: Colors.green.shade600,
      icon: Icons.category,
      list: [
        BottomSheetButtons(title: 'زاوية الركنة ', onPressed: Corner(false)),
        BottomSheetButtons(
            title: ' زاوية الدورانات ', onPressed: RotationAngle()),
        BottomSheetButtons(
            title: ' زاوية الشطرات ', onPressed: IrregularAngle()),
      ]),
  DeductsContent(
      title: 'المزيد من التخصيمات',
      color: Colors.black,
      icon: Icons.more_horiz,
      list: [
        BottomSheetButtons(title: 'الشيش حصيرة', onPressed: Shutter()),
        BottomSheetButtons(title: 'السلك البيليسية', onPressed: FlyScreen()),
        BottomSheetButtons(title: 'التند الإيطالي', onPressed: Shade()),
      ]),
];
