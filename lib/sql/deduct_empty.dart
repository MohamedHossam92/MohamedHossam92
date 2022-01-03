import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

import 'home.dart';

class MyDeductIsEmpty extends StatelessWidget {
  final bool isSlide;

  const MyDeductIsEmpty(this.isSlide);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Image.asset('assets/images/gif/robotintro_dribble.gif'),
          BTextB5('قائمة تخصيماتك ما زالت فارغة'),
          Card(
            color: Colors.amber,
            child: DPadding(child: BTextB5('يمكنك اضافة تخصيماتك الخاصة')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: size.width * .1),
              MaterialButton(
                  color: cLogoColorW,
                  child: Row(
                    children: [
                      Icon(
                        Icons.open_in_new,
                        color: Colors.white,
                      ),
                      DPadding(child: WTextB5('اضافة قطاعاتي الخاصة'))
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => DialogIsPVC(isSlide));
                  }),
              Image.asset('assets/images/logo.png', width: size.width * .1),
            ],
          )
        ],
      ),
    );
  }
}
