import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/screens/welcome/a_home.dart';
import 'package:the_smart_workshop/screens/deducts/home_content.dart';
import 'package:the_smart_workshop/sql/home.dart';
import 'package:the_smart_workshop/sql/kitchen/aluminum_unit_details.dart';
import 'package:the_smart_workshop/sql/kitchen/wood_unit_details.dart';

class Setting extends StatelessWidget {
  static String id = 'Setting';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);

          Size size = MediaQuery.of(context).size;

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text('الاعدادات'),
              ),
              body: AppBackGround(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      myStack('تشغيل وايقاف الصلاة علي النبي - ﷺ -'),
                      Container(
                        color: Colors.white,
                        child: DPadding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BTextB5('الصلاة على النبي - ﷺ -'),
                              Switch(
                                  value: cubit.isPray,
                                  onChanged: (val) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        dSnackBarShowResult(
                                            icon: Icons.done,
                                            title:
                                                'تم ${PrayPlay.isPray ? 'إيقاف' : 'تشغيل'} الصلاة علي النبي - ﷺ - .'));
                                    PrayPlay.savePrayStopState();
                                    cubit.getPrayState();
                                    PrayPlay.playPray();
                                  })
                            ],
                          ),
                        ),
                      ),
                      if (cubit.getUserTypePrefs == 0)
                        myStack('اضافة وتعديل تخصيماتي'),
                      if (cubit.getUserTypePrefs == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            myDeductCard('الجرار', 'slide', size, () {
                              Navigator.pushNamed(
                                  context, SlideDeductSetting.id);
                            }),
                            myDeductCard('المفصلي', 'turn', size, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SlideDeductSetting(true, false)));
                            }),
                          ],
                        ),
                      if (cubit.getUserTypePrefs < 2)
                        GestureDetector(
                          onTap: () {
                            DeductsContent deductContent = DeductsContent(
                                title: 'تخصيم المطابخ',
                                color: Colors.blue.shade600,
                                icon: Icons.map,
                                list: [
                                  if (cubit.getUserTypePrefs == 0)
                                    BottomSheetButtons(
                                        title: 'مطابخ ألومنيوم',
                                        onPressed: AlKitchenSitting()),
                                  BottomSheetButtons(
                                      title: ' مطابخ 18مم',
                                      onPressed: WoodUnitDetails()),
                                ]);

                            showModalBottomSheet(
                                backgroundColor: Colors.black54,
                                elevation: 50,
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: size.width * .25,
                                        color: Colors.transparent,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                deductContent.list.map((j) {
                                              return DPadding(
                                                  val: .04,
                                                  child: SizedBox(
                                                      width: size.width * .5,
                                                      child: MaterialButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            j.onPressed));
                                                          },

                                                          //  ,
                                                          color: Colors.white,
                                                          child: RTextB5(
                                                              j.title))));
                                            }).toList())),
                                  );
                                });
                          },
                          child: SizedBox(
                            width: size.width * .96,
                            child: Card(
                                color: Colors.black45,
                                child: DPadding(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: DPadding(
                                          val: .01,
                                          child: Image.asset(
                                            'assets/images/kitchen_unit/1019.jpg',
                                            width: size.width * .18,
                                          ),
                                        ),
                                      ),
                                      SPadding(
                                          v: .025,
                                          h: .05,
                                          child: WTextB5(
                                              'تخصيص إعداداتك في المطابخ'))
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      myStack('تعديل تخصصك الفني'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (i) => GestureDetector(
                                  onTap: () {
                                    if (i != 0) {
                                      cubit.userStateChange(i, true);
                                      cubit.saveUserType(i);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(dSnackBarShowResult(
                                              icon: Icons.done,
                                              title:
                                                  'تم تغيير تخصصك لـ${userName[i]} '));
                                      cubit.saveUserType(i);
                                    } else {
                                      cubit.userStateChange(i, true);

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WelcomePage(3)));
                                    }
                                  },
                                  child: Container(
                                    width: size.width * .3,
                                    height: size.height * .17,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/user_type/user_type00$i.jpg'),
                                            fit: BoxFit.cover),
                                        boxShadow: cubit.userState[i] == true
                                            ? [
                                                BoxShadow(
                                                    color: cLogoColor,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 1),
                                                    spreadRadius: 0)
                                              ]
                                            : [],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top: -7,
                                            right: -7,
                                            child: Checkbox(
                                              value: cubit.userState[i],
                                              onChanged: (val) {
                                                cubit.userStateChange(i, val);
                                              },
                                            )),
                                        Positioned(
                                            bottom: 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white70,
                                              ),
                                              child: DPadding(
                                                  child: BTextB4(userName[i])),
                                            )),
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

myDeductCard(
  title,
  img,
  size,
  onTap,
) =>
    Card(
        color: Colors.black45,
        child: GestureDetector(
          onTap: onTap,
          child: DPadding(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: DPadding(
                    val: .01,
                    child: Image.asset(
                      'assets/images/setting/$img.png',
                      width: size.width * .38,
                    ),
                  ),
                ),
                SPadding(v: .025, h: 0, child: WTextB5('تخصيمات $title'))
              ],
            ),
          ),
        ));

myStack(title) => Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          thickness: 7,
        ),
        Card(
          color: cLogoColorW,
          child: DPadding(child: WTextB5(title)),
        )
      ],
    );

List<String> userName = ['فني ألومنيوم', 'نجار مطابخ ', 'عميل مُتعاقد'];
