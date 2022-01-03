import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

class ListIsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * .8,
        child: SingleChildScrollView(
          child: Center(
              child: DPadding(
                  child: Center(
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list_alt,
                  size: size.width * .3,
                  color: Colors.grey.shade300,
                ),
                Column(
                  children: [
                    Center(
                        child: BText5(
                      'لا يوجد مقاسات حتى الآن',
                    )),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    BText5(
                      ' أضف مقاس جديد من الأسفل ',
                    ),
                  ],
                ),
              ],
            )),
          ))),
        ));
  }
}
