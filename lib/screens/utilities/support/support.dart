import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/utilities/support/supports_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Supports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          String supportType = homeCubit.supportType;
          String supportPhone = homeCubit.supportPhone;
          return Scaffold(
              appBar: AppBar(
                title: Text('الدعم الفني'),
              ),
              body: AppBackGround(
                child: Column(
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: size.width * .3,
                    ),
                    BTextB5('خدمة الدعم الفني'),
                    BTextB4('للإجابة عن الأسئلة والاستفسارات الفنية'),
                    BTextB4('التي تواجه الفني أثناء العمل'),
                    Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.width * .04),
                          topLeft: Radius.circular(size.width * .04),
                        ),
                        color: Colors.grey.shade700,
                      ),
                      child: DPadding(
                        val: .04,
                        child: Center(child: WTextB5('للإستفادة من الخدمة')),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DPadding(
                              child: Row(
                                children: [
                                  Icon(Icons.input),
                                  BTextB4('    ضع سؤالك هنا'),
                                ],
                              ),
                            ),
                            DTextFieldMax(
                                validator: () {},
                                labelText: 'نص السؤال',
                                onChanged: (val) {
                                  homeCubit.askSupportChanged(val);
                                }),
                            DPadding(
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_outline_outlined),
                                  BTextB4('    إختار تخصص الإجابة عن السؤال'),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey.shade700,
                              child: Card(
                                child: Wrap(
                                    children: supportsList.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      homeCubit.supportTypeChanged(
                                          e.title, e.phone);
                                    },
                                    child: Card(
                                      child: DPadding(
                                        val: .009,
                                        child: BTextB4(e.title),
                                      ),
                                    ),
                                  );
                                }).toList()),
                              ),
                            ),
                            BTextB3(
                                '* يجب إختيار جهة التخصص صحيحة لتحصل علي أفضل إجابة'),
                            if (homeCubit.supportType != '')
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BTextB3('لقد إخترت إرسال السؤال إلي تخصص '),
                                    Card(
                                      color: cLogoColorW,
                                      child: WTextB5(supportType),
                                    )
                                  ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    child: Text(
                                      'إرســال',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      homeCubit.playPray();
                                      if (homeCubit.supportType != '') {
                                        final link = whatsApp(
                                            phone: supportPhone,
                                            message: homeCubit.askSupport);

                                        await launch('$link');
                                        homeCubit.sendMessageChanged();
                                        PrayPlay.playPray();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(dSnackBarShowResult(
                                                icon: Icons.error,
                                                title:
                                                    'من فضلك حدد تخصص الإجابة عن السؤال أولاً .'));
                                      }
                                    },
                                    color: cLogoColor,
                                  ),
                                  DPadding(
                                    child: Image.asset(
                                        'assets/images/social_icons/whats.png'),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
