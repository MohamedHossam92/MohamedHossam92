import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/alert_card.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us.dart';
import 'package:the_smart_workshop/screens/utilities/fly_screen/fly_screen.dart';
import 'package:the_smart_workshop/screens/utilities/support/support.dart';
import 'package:url_launcher/url_launcher.dart';

import 'design_kitchen/design_kitchen.dart';
import 'guide/guide.dart';
import 'quick_message/quick_message.dart';
import 'todo/view/home.dart';

class Utilities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;
          return Column(
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              Wrap(
                  children: List.generate(utilitiesList.length, (i) {
                return SPadding(
                  h: .015,
                  v: .009,
                  child: GestureDetector(
                    onTap: i >= 1
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        utilitiesList[i].onTap));
                          }
                        : utilitiesList[i].onPressed,
                    child: Container(
                      height: size.height * .07,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                                spreadRadius: 0)
                          ],
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4)),
                      width: MediaQuery.of(context).size.width * .4,
                      child: Card(
                        margin: EdgeInsets.all(1),
                        child: Row(
                          children: [
                            DPadding(
                              val: .013,
                              child: utilitiesList[i].imagePath == ''
                                  ? Icon(
                                      utilitiesList[i].icon,
                                      color: utilitiesList[i].colors,
                                      size: MediaQuery.of(context).size.width *
                                          .1,
                                    )
                                  : Image.asset(
                                      utilitiesList[i].imagePath,
                                      width: size.width * .11,
                                    ),
                            ),
                            BTextB4(utilitiesList[i].title)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CallUs()));
                  homeCubit.itemIndexChanged(4);
                },
                child: AlertCard('واقترح علينا خدمة جديدة'),
              )
            ],
          );
        });
  }
}

class UtilitiesData {
  final Color color, colors;
  final String title, imagePath;
  final Function() onPressed;
  final Widget onTap;
  final IconData icon;

  UtilitiesData(
      {required this.color,
      required this.colors,
      required this.title,
      required this.imagePath,
      required this.onPressed,
      required this.onTap,
      required this.icon});
}

List<UtilitiesData> utilitiesList = [
  UtilitiesData(
    title: 'المعرض',
    imagePath: '',
    color: Colors.green.shade300,
    colors: Colors.green.shade600,
    icon: Icons.photo_album,
    onPressed: () async {
      await launch('https://drive.google.com/drive/u/0/my-drive');
    },
    onTap: Container(),
  ),
  // UtilitiesData(
  //     title: 'فيديو تعليمي',
  //     imagePath: '',
  //     color: Colors.red.shade300,
  //     colors: Colors.red.shade600,
  //     icon: Icons.video_collection,
  //     onTap: Container(),
  //     onPressed: () async {
  //       await launch(
  //           'https://www.youtube.com/channel/UCGrDTch4-c0ghYoO8OezTow');
  //     }),
  UtilitiesData(
      title: ' الدعم الفني',
      imagePath: '',
      color: Colors.pink.shade300,
      colors: Colors.pink.shade600,
      icon: Icons.support_agent,
      onPressed: () {},
      onTap: Supports()),
  UtilitiesData(
      title: ' دليل التجار',
      imagePath: '',
      color: Colors.indigo.shade300,
      colors: Colors.indigo.shade600,
      icon: Icons.quick_contacts_dialer,
      onPressed: () {},
      onTap: Guide()),
  UtilitiesData(
      title: 'مدونة مقاسات',
      imagePath: '',
      color: Colors.blue.shade300,
      colors: Colors.blue.shade600,
      icon: Icons.pending_actions,
      onPressed: () {},
      onTap: ToDo()),
  UtilitiesData(
      title: 'رسالة سريعة',
      imagePath: '',
      color: Colors.green.shade300,
      colors: Colors.green.shade600,
      icon: Icons.schedule_send,
      onPressed: () {},
      onTap: QuickMessage()),
  UtilitiesData(
      title: 'صمم مطبخك',
      imagePath: '',
      color: Colors.deepPurple.shade300,
      colors: Colors.deepPurple.shade600,
      icon: Icons.design_services,
      onPressed: () {},
      onTap: DesignKitchen()),
  UtilitiesData(
      title: 'سلك بيليسية',
      imagePath: 'assets/images/guide/sm.png',
      color: Colors.black,
      colors: Colors.black,
      icon: Icons.apps,
      onPressed: () {},
      onTap: FlyScreen()),
  UtilitiesData(
      title: 'شيش حصيرة',
      imagePath: 'assets/images/guide/qu.png',
      color: Colors.black,
      colors: Colors.black,
      icon: Icons.apps,
      onPressed: () {},
      onTap: FlyScreen(false)),
];
