import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/social_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'call_us_button.dart';

class CallUs extends StatelessWidget {
  static String id = 'CallUs';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;

          return SafeArea(
            bottom: true,
            left: true,
            top: true,
            right: true,
            child: Scaffold(
              appBar: AppBar(
                title: Text('تواصل معنا'),
              ),
              body: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .55,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DPadding(
                                child: Container(
                                  alignment: Alignment.topRight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(size.height * .017),
                                      topLeft:
                                          Radius.circular(size.height * .017),
                                    ),
                                    color: Colors.indigo,
                                  ),
                                  child: DPadding(
                                    val: .03,
                                    child: Center(
                                        child: WTextB5(
                                            'يسعدنا ويشرفنا تواصلكم معنا')),
                                  ),
                                ),
                              ),
                              SPadding(
                                v: .045,
                                h: 0,
                                child: BTextB4(
                                    ' • لمناقشة فكرة جديدة تتمني وجودها في التطبيق.' +
                                        '\n\n • لمناقشة مشكلة تقنية في التطبيق لنحلها سوياً.' +
                                        '\n\n • للإبلاغ عن خطأ فني في نتائج عملية التخصيمات .'),
                              ),
                              DTextFieldMax(
                                labelText: 'نص الرسالة',
                                onChanged: (val) {
                                  homeCubit.callUsMessageChange(val);
                                },
                                validator: () {},
                              ),
                              CallUsButton(homeCubit.callUsMessage),
                            ]),
                      ),
                      DPadding(
                        child: Card(
                          child: Column(
                            children: [
                              DPadding(
                                child: BTextB4(
                                    'تابعنا علي وسائل التواصل الإجتماعي'),
                              ),
                              Container(
                                width: 250,
                                child: Row(
                                    children: socialList.map((e) {
                                  return GestureDetector(
                                    child: DPadding(
                                      val: .015,
                                      child: Image.asset(
                                          'assets/images/social_icons/${e.imagePath}.png'),
                                    ),
                                    onTap: () async {
                                      await launch(e.link);
                                    },
                                  );
                                }).toList()),
                              )
                            ],
                          ),
                        ),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
