import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:url_launcher/url_launcher.dart';

import 'guides_data.dart';

class GuideProfile extends StatelessWidget {
  final int index;
  const GuideProfile(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          return SafeArea(
            child: Scaffold(
              body: AppBackGround(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('assets/images/guide/product.png',
                          fit: BoxFit.fitHeight),
                      Row(
                        children: [
                          DPadding(
                            val: .03,
                            child: Container(
                              width: size.width * .22,
                              height: size.width * .22,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/guide/${guidList[index].logo}'),
                                      fit: BoxFit.cover),
                                  boxShadow: [
                                    BoxShadow(
                                        color: cLogoColor,
                                        blurRadius: 5,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0)
                                  ],
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DPadding(child: BTextB6(guidList[index].name)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.approval_sharp,
                                    color: Colors.red,
                                  ),
                                  Card(
                                    color: Colors.yellow.shade200,
                                    child: DPadding(
                                        val: .01,
                                        child: BTextB4(guidList[index].place)),
                                  ),
                                ],
                              ),
                              Row(
                                children: List.generate(
                                    5,
                                    (i) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        )),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 5,
                      ),
                      Container(
                          color: Colors.black12,
                          child:
                              // DPadding(child: BTextB5(guidList[index].type))),
                              DPadding(child: BTextB5('وصف قصير'))),
                      Card(
                        color: Colors.black54,
                        child: DPadding(
                            child: WTextB5(
                                'لعرض المنتجات إضغط علي الصندوق التالي')),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await launch('https://wa.me/c/201020608160');
                        },
                        child: Image.asset(
                          'assets/images/guide/products.png',
                          height: size.height * .2,
                        ),
                      ),
                      Card(
                        color: Colors.black54,
                        child: DPadding(
                            child: WTextB5('ثم تواصل مع الشركة لطلب المنتج')),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Divider(
                            thickness: 5,
                            color: Colors.black54,
                          ),
                          Card(
                            color: Colors.green.shade900,
                            child: DPadding(
                                child: WTextB5('للتواصل السريع مع الشركة')),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: DPadding(
                              child: TextFormField(
                                onChanged: (val) {
                                  homeCubit.guideData(4, val);
                                },
                                decoration: InputDecoration(
                                    hintText: 'اكتب رسالتك هنا',
                                    suffixIcon: Icon(Icons.attach_file),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.white12,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25))),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final link = whatsApp(
                                  phone: guidList[index].phone,
                                  message: homeCubit.guideMessage);
                              await launch('$link');
                            },
                            child: DPadding(
                              child: CircleAvatar(
                                radius: size.width * .07,
                                backgroundColor: Colors.green.shade900,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: size.width * .09,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: size.width,
                        height: 10,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
