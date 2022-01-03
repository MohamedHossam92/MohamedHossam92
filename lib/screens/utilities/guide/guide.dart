import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_new_guide.dart';
import 'guides_data.dart';
import 'profile.dart';

class Guide extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('دليل التجار'),
      ),
      body: AppBackGround(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Icon(
                Icons.quick_contacts_dialer,
                size: MediaQuery.of(context).size.width * .3,
              ),
              BTextB5('خدمة دليل التجار'),
              DPadding(
                child:
                    BTextB4('لتسهل علي الفني الوصول إلي المنتجات وأماكن بيعها'),
              ),
              BTextB4('للتواصل مع شركة إضغط عليها'),
              Expanded(child: GuideBody()),
              SPadding(
                v: .02,
                h: 0,
                child: MaterialButton(
                    color: cLogoColorW,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [WTextB5('إضافة تاجر')],
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!
                          .showBottomSheet((context) => AddNewGuide());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GuideBody extends StatelessWidget {
  const GuideBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          return DPadding(
            child: Container(
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 3,
                children: guidList.map((e) {
                  return GestureDetector(
                    onTap: () async {
                      final link = whatsApp(phone: e.phone, message: '');
                      await launch('$link');

                      homeCubit.incrementGuidePressedLength();
                      PrayPlay.playPray();
                    },
                    onDoubleTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GuideProfile(guidList.indexOf(e))));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        'assets/images/guide/${e.logo}',
                      ))),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            right: 0,
                            child: Card(
                              child: DPadding(
                                val: .01,
                                child: BTextB3(e.type),
                              ),
                              color: e.color,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: Opacity(
                                  opacity: .4,
                                  child: Container(
                                    width: size.width * .31,
                                    height: size.height * .05,
                                    color: Colors.black,
                                  ))),
                          Positioned(
                              bottom: size.height * .02,
                              child: WTextB4(e.name)),
                          Positioned(
                              bottom: 0, left: 0, child: BTextB3(e.place)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
